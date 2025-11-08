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
        
        model.addAttribute("userName", userName);
        model.addAttribute("totalQuizzes", attempts.size());
        model.addAttribute("totalLessons", progress.size());
        model.addAttribute("recentAttempts", attempts.size() > 5 ? attempts.subList(0, 5) : attempts);
        
        return "student-dashboard";
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
        Long userId = (Long) session.getAttribute("userId");
        
        model.addAttribute("quiz", quiz);
        model.addAttribute("questions", questions);
        model.addAttribute("studentId", userId);
        
        return "quiz-take";
    }
    
    @PostMapping("/quiz/submit")
    public String submitQuiz(@RequestParam Long quizId,
                            @RequestParam Map<String, String> allParams,
                            HttpSession session,
                            Model model) {
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
    public String updateProgress(@RequestParam Long lessonId,
                                @RequestParam Integer completion,
                                HttpSession session) {
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