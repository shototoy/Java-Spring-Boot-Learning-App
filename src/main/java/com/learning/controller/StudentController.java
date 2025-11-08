package com.learning.controller;

import com.learning.model.*;
import com.learning.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.List;

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
    
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        Long userId = (Long) session.getAttribute("userId");
        String userName = (String) session.getAttribute("userName");
        
        List<QuizAttempt> attempts = attemptRepo.findByStudentIdOrderByCompletedAtDesc(userId);
        List<Progress> progress = progressRepo.findByStudentId(userId);
        
        model.addAttribute("userName", userName);
        model.addAttribute("totalQuizzes", attempts.size());
        model.addAttribute("totalLessons", progress.size());
        model.addAttribute("recentAttempts", attempts.stream().limit(5).toList());
        
        return "student-dashboard";
    }
    
    @GetMapping("/lessons")
    public String lessons(@RequestParam String subject, Model model) {
        List<Lesson> lessons = lessonRepo.findBySubjectOrderByOrderNum(subject);
        model.addAttribute("subject", subject);
        model.addAttribute("lessons", lessons);
        return "lessons";
    }
    
    @GetMapping("/quiz")
    public String quiz(@RequestParam Long id, Model model) {
        Quiz quiz = quizRepo.findById(id).orElse(null);
        List<Question> questions = questionRepo.findByQuizId(id);
        model.addAttribute("quiz", quiz);
        model.addAttribute("questions", questions);
        return "quiz-take";
    }
    
    @PostMapping("/quiz/submit")
    public String submitQuiz(@RequestParam Long quizId,
                            @RequestParam List<String> answers,
                            HttpSession session,
                            Model model) {
        Long userId = (Long) session.getAttribute("userId");
        List<Question> questions = questionRepo.findByQuizId(quizId);
        
        int score = 0;
        for (int i = 0; i < questions.size(); i++) {
            if (i < answers.size() && questions.get(i).getCorrectAnswer().equals(answers.get(i))) {
                score++;
            }
        }
        
        QuizAttempt attempt = new QuizAttempt();
        attempt.setStudentId(userId);
        attempt.setQuizId(quizId);
        attempt.setScore(score);
        attempt.setCompletedAt(LocalDateTime.now());
        attemptRepo.save(attempt);
        
        model.addAttribute("score", score);
        model.addAttribute("total", questions.size());
        return "redirect:/student/results";
    }
    
    @GetMapping("/results")
    public String results(HttpSession session, Model model) {
        Long userId = (Long) session.getAttribute("userId");
        List<QuizAttempt> attempts = attemptRepo.findByStudentIdOrderByCompletedAtDesc(userId);
        model.addAttribute("attempts", attempts);
        return "results";
    }
}
