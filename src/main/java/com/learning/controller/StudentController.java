package com.learning.controller;
import com.learning.model.*;
import com.learning.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;
@Controller
@RequestMapping("/student")
public class StudentController {
    @Autowired
    private LessonRepo lessonRepo;
    @Autowired
    private QuizRepo quizRepo;
    @Autowired
    private QuestionRepo questionRepo;
    @Autowired
    private QuizAttemptRepo attemptRepo;
    @Autowired
    private ProgressRepo progressRepo;
    @Autowired
    private UserRepo userRepo;
    private String checkSession(HttpSession session) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }
        if (!"STUDENT".equals(session.getAttribute("userRole"))) {
            return "redirect:/login";
        }
        return null;
    }
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        String redirect = checkSession(session);
        if (redirect != null) return redirect;
        Long userId = (Long) session.getAttribute("userId");
        String userName = (String) session.getAttribute("userName");
        List<QuizAttempt> attempts = attemptRepo.findByStudentIdOrderByCompletedAtDesc(userId);
        List<Progress> progress = progressRepo.findByStudentId(userId);
        List<LeaderboardEntry> leaderboard = getLeaderboardWithCurrentUser(userId);
        model.addAttribute("userName", userName);
        model.addAttribute("totalQuizzes", attempts.size());
        model.addAttribute("totalLessons", progress.size());
        model.addAttribute("recentAttempts", attempts.size() > 5 ? attempts.subList(0, 5) : attempts);
        model.addAttribute("leaderboard", leaderboard);
        return "student-dashboard";
    }
    private List<LeaderboardEntry> getLeaderboardWithCurrentUser(Long userId) {
        List<Object[]> results = userRepo.findLeaderboard();
        int totalQuizzesAvailable = (int) quizRepo.count();
        List<LeaderboardEntry> entries = new ArrayList<>();
        int rank = 1;
        LeaderboardEntry currentUserEntry = null;
        for (Object[] row : results) {
            int attemptsCount = row[3] != null ? ((Number) row[3]).intValue() : 0;
            int totalScore = row[4] != null ? ((Number) row[4]).intValue() : 0;
            double avgAcrossAll = 0.0;
            if (totalQuizzesAvailable > 0) {
                avgAcrossAll = (double) totalScore / (double) totalQuizzesAvailable;
            }
            LeaderboardEntry entry = new LeaderboardEntry(
                ((Number) row[0]).longValue(),
                (String) row[1],
                (String) row[2],
                attemptsCount,
                totalScore,
                avgAcrossAll
            );
            entry.setRank(rank);
            entry.setIsCurrentUser(entry.getId().equals(userId));
            if (entry.getIsCurrentUser()) {
                currentUserEntry = entry;
            }
            entries.add(entry);
            rank++;
        }
        // Only top 3 or fewer if less students
        List<LeaderboardEntry> displayList = new ArrayList<>();
        int maxRows = Math.min(3, entries.size());
        boolean userInTop = false;
        for (int i = 0; i < maxRows; i++) {
            LeaderboardEntry entry = entries.get(i);
            displayList.add(entry);
            if (entry.getIsCurrentUser()) {
                userInTop = true;
            }
        }
        // If current user is not in top 3 and exists in the list, add as 4th row
        if (!userInTop && currentUserEntry != null) {
            displayList.add(currentUserEntry);
        }
        return displayList;
    }
    @GetMapping("/lessons")
    public String lessons(@RequestParam String subject, HttpSession session, Model model) {
        String redirect = checkSession(session);
        if (redirect != null) return redirect;
        List<Lesson> lessons = lessonRepo.findBySubjectOrderByOrderNum(subject);
        List<Quiz> quizzes = quizRepo.findBySubject(subject);
        model.addAttribute("subject", subject);
        model.addAttribute("lessons", lessons);
        model.addAttribute("quizzes", quizzes);
        return "lessons";
    }
    @GetMapping("/quiz")
    public String quiz(@RequestParam Long id, HttpSession session, Model model) {
        String redirect = checkSession(session);
        if (redirect != null) return redirect;
        Quiz quiz = quizRepo.findById(id).orElse(null);
        if (quiz == null) {
            return "redirect:/student/dashboard";
        }
        List<Question> questions = questionRepo.findByQuizId(id);
        Collections.shuffle(questions);
        model.addAttribute("quiz", quiz);
        model.addAttribute("subject", quiz.getSubject());
        model.addAttribute("questions", questions);
        return "quiz-take";
    }
    @PostMapping("/quiz/submit")
    public String submitQuiz(@RequestParam Long quizId, @RequestParam Map<String, String> allParams, HttpSession session) {
        String redirect = checkSession(session);
        if (redirect != null) return redirect;
        Long userId = (Long) session.getAttribute("userId");
        List<Question> questions = questionRepo.findByQuizId(quizId);
        int score = 0;
        for (Question q : questions) {
            String answerKey = "answer_" + q.getId();
            String userAnswer = allParams.get(answerKey);
            if (userAnswer != null && userAnswer.equals(q.getCorrectAnswer())) {
                score++;
            }
        }
        QuizAttempt attempt = new QuizAttempt();
        attempt.setStudentId(userId);
        attempt.setQuizId(quizId);
        attempt.setScore(score);
        attempt.setCompletedAt(LocalDateTime.now());
        attemptRepo.save(attempt);
        return "redirect:/student/results";
    }
    @GetMapping("/results")
    public String results(HttpSession session, Model model) {
        String redirect = checkSession(session);
        if (redirect != null) return redirect;
        Long userId = (Long) session.getAttribute("userId");
        List<QuizAttempt> attempts = attemptRepo.findByStudentIdOrderByCompletedAtDesc(userId);
        Map<Long, String> quizTitles = new HashMap<>();
        Map<Long, String> quizSubjects = new HashMap<>();
        for (QuizAttempt attempt : attempts) {
            Quiz quiz = quizRepo.findById(attempt.getQuizId()).orElse(null);
            if (quiz != null) {
                quizTitles.put(attempt.getQuizId(), quiz.getTitle());
                quizSubjects.put(attempt.getQuizId(), quiz.getSubject());
            }
        }
        model.addAttribute("attempts", attempts);
        model.addAttribute("quizTitles", quizTitles);
        model.addAttribute("quizSubjects", quizSubjects);
        return "results";
    }
    @PostMapping("/progress/update")
    public String updateProgress(@RequestParam Long lessonId, @RequestParam Integer completion, HttpSession session) {
        String redirect = checkSession(session);
        if (redirect != null) return redirect;
        Long userId = (Long) session.getAttribute("userId");
        Progress progress = progressRepo.findByStudentIdAndLessonId(userId, lessonId);
        if (progress == null) {
            progress = new Progress();
            progress.setStudentId(userId);
            progress.setLessonId(lessonId);
        }
        progress.setCompletion(completion);
        progressRepo.save(progress);
        return "redirect:/student/dashboard";
    }
}
