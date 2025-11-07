package com.learning.controller;

import com.learning.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/teacher")
public class TeacherController {
    
    @Autowired
    private LessonRepo lessonRepo;
    @Autowired
    private QuizRepo quizRepo;
    @Autowired
    private QuestionRepo questionRepo;
    @Autowired
    private UserRepo userRepo;
    
    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        long totalLessons = lessonRepo.count();
        long totalQuizzes = quizRepo.count();
        long totalStudents = userRepo.findByRole("STUDENT").size();
        
        model.addAttribute("totalLessons", totalLessons);
        model.addAttribute("totalQuizzes", totalQuizzes);
        model.addAttribute("totalStudents", totalStudents);
        
        return "teacher-dashboard";
    }
    
    @GetMapping("/lessons")
    public String lessons(Model model) {
        model.addAttribute("lessons", lessonRepo.findAll());
        return "teacher-lessons";
    }
    
    @PostMapping("/lesson/add")
    public String addLesson(@RequestParam String subject,
                           @RequestParam String title,
                           @RequestParam String content,
                           @RequestParam(required = false) String videoUrl,
                           @RequestParam Integer orderNum) {
        Lesson lesson = new Lesson();
        lesson.setSubject(subject);
        lesson.setTitle(title);
        lesson.setContent(content);
        lesson.setVideoUrl(videoUrl);
        lesson.setOrderNum(orderNum);
        lessonRepo.save(lesson);
        return "redirect:/teacher/lessons";
    }
    
    @GetMapping("/quizzes")
    public String quizzes(Model model) {
        model.addAttribute("quizzes", quizRepo.findAll());
        return "teacher-quizzes";
    }
    
    @PostMapping("/quiz/add")
    public String addQuiz(@RequestParam String subject,
                         @RequestParam String title,
                         @RequestParam Integer duration) {
        Quiz quiz = new Quiz();
        quiz.setSubject(subject);
        quiz.setTitle(title);
        quiz.setDuration(duration);
        Quiz saved = quizRepo.save(quiz);
        return "redirect:/teacher/quizzes";
    }
}
