package com.learning.controller;

import com.learning.model.*;
import com.learning.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;
import java.util.List;

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
    
    private String checkSession(HttpSession session) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }
        if (!"TEACHER".equals(session.getAttribute("userRole"))) {
            return "redirect:/login";
        }
        return null;
    }
    
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        String redirect = checkSession(session);
        if (redirect != null) return redirect;
        
        long totalLessons = lessonRepo.count();
        long totalQuizzes = quizRepo.count();
        long totalStudents = userRepo.findByRole("STUDENT").size();
        
        model.addAttribute("totalLessons", totalLessons);
        model.addAttribute("totalQuizzes", totalQuizzes);
        model.addAttribute("totalStudents", totalStudents);
        
        return "teacher-dashboard";
    }
    
    @GetMapping("/lessons")
    public String lessons(HttpSession session, Model model) {
        String redirect = checkSession(session);
        if (redirect != null) return redirect;
        
        model.addAttribute("lessons", lessonRepo.findAll());
        return "teacher-lessons";
    }
    
    @PostMapping("/lesson/add")
    public String addLesson(@RequestParam String subject,
                           @RequestParam String title,
                           @RequestParam String content,
                           @RequestParam(required = false) String videoUrl,
                           @RequestParam Integer orderNum,
                           HttpSession session) {
        String redirect = checkSession(session);
        if (redirect != null) return redirect;
        
        Lesson lesson = new Lesson();
        lesson.setSubject(subject);
        lesson.setTitle(title);
        lesson.setContent(content);
        lesson.setVideoUrl(videoUrl);
        lesson.setOrderNum(orderNum);
        lessonRepo.save(lesson);
        
        return "redirect:/teacher/lessons";
    }
    
    @PostMapping("/lesson/edit")
    public String editLesson(@RequestParam Long id,
                            @RequestParam String subject,
                            @RequestParam String title,
                            @RequestParam String content,
                            @RequestParam(required = false) String videoUrl,
                            @RequestParam Integer orderNum,
                            HttpSession session) {
        String redirect = checkSession(session);
        if (redirect != null) return redirect;
        
        Lesson lesson = lessonRepo.findById(id).orElse(null);
        if (lesson != null) {
            lesson.setSubject(subject);
            lesson.setTitle(title);
            lesson.setContent(content);
            lesson.setVideoUrl(videoUrl);
            lesson.setOrderNum(orderNum);
            lessonRepo.save(lesson);
        }
        
        return "redirect:/teacher/lessons";
    }
    
    @PostMapping("/lesson/delete")
    public String deleteLesson(@RequestParam Long id, HttpSession session) {
        String redirect = checkSession(session);
        if (redirect != null) return redirect;
        
        lessonRepo.deleteById(id);
        return "redirect:/teacher/lessons";
    }
    
    @GetMapping("/quizzes")
    public String quizzes(HttpSession session, Model model) {
        String redirect = checkSession(session);
        if (redirect != null) return redirect;
        
        model.addAttribute("quizzes", quizRepo.findAll());
        return "teacher-quizzes";
    }
    
    @PostMapping("/quiz/add")
    public String addQuiz(@RequestParam String subject,
                         @RequestParam String title,
                         @RequestParam Integer duration,
                         HttpSession session) {
        String redirect = checkSession(session);
        if (redirect != null) return redirect;
        
        Quiz quiz = new Quiz();
        quiz.setSubject(subject);
        quiz.setTitle(title);
        quiz.setDuration(duration);
        quizRepo.save(quiz);
        
        return "redirect:/teacher/quizzes";
    }
    
    @PostMapping("/quiz/delete")
    public String deleteQuiz(@RequestParam Long id, HttpSession session) {
        String redirect = checkSession(session);
        if (redirect != null) return redirect;
        
        quizRepo.deleteById(id);
        return "redirect:/teacher/quizzes";
    }
    
    @GetMapping("/quiz/questions")
    public String quizQuestions(@RequestParam Long quizId, HttpSession session, Model model) {
        String redirect = checkSession(session);
        if (redirect != null) return redirect;
        
        Quiz quiz = quizRepo.findById(quizId).orElse(null);
        List<Question> questions = questionRepo.findByQuizId(quizId);
        
        model.addAttribute("quiz", quiz);
        model.addAttribute("questions", questions);
        
        return "teacher-quiz-questions";
    }
    
    @PostMapping("/question/add")
    public String addQuestion(@RequestParam Long quizId,
                             @RequestParam String text,
                             @RequestParam String optionA,
                             @RequestParam String optionB,
                             @RequestParam String optionC,
                             @RequestParam String optionD,
                             @RequestParam String correctAnswer,
                             HttpSession session) {
        String redirect = checkSession(session);
        if (redirect != null) return redirect;
        
        Question question = new Question();
        question.setQuizId(quizId);
        question.setText(text);
        question.setOptionA(optionA);
        question.setOptionB(optionB);
        question.setOptionC(optionC);
        question.setOptionD(optionD);
        question.setCorrectAnswer(correctAnswer);
        questionRepo.save(question);
        
        return "redirect:/teacher/quiz/questions?quizId=" + quizId;
    }
    
    @PostMapping("/question/delete")
    public String deleteQuestion(@RequestParam Long id, 
                                @RequestParam Long quizId,
                                HttpSession session) {
        String redirect = checkSession(session);
        if (redirect != null) return redirect;
        
        questionRepo.deleteById(id);
        return "redirect:/teacher/quiz/questions?quizId=" + quizId;
    }
}