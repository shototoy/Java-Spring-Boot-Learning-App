Write-Host "Creating directory structure..." -ForegroundColor Green

New-Item -ItemType Directory -Force -Path "src/main/java/com/learning/model" | Out-Null
New-Item -ItemType Directory -Force -Path "src/main/java/com/learning/repository" | Out-Null
New-Item -ItemType Directory -Force -Path "src/main/java/com/learning/controller" | Out-Null
New-Item -ItemType Directory -Force -Path "src/test/java" | Out-Null
New-Item -ItemType Directory -Force -Path "src/main/resources/static/css" | Out-Null
New-Item -ItemType Directory -Force -Path "src/main/resources/static/js" | Out-Null
New-Item -ItemType Directory -Force -Path "src/main/resources/static/images" | Out-Null
New-Item -ItemType Directory -Force -Path "src/main/resources/templates/fragments" | Out-Null

Write-Host "Directories created!" -ForegroundColor Green
Write-Host "Creating Java files WITHOUT Lombok..." -ForegroundColor Cyan

$appContent = @"
package com.learning;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class App {
    public static void main(String[] args) {
        SpringApplication.run(App.class, args);
    }
}
"@
Set-Content -Path "src/main/java/com/learning/App.java" -Value $appContent

$userContent = @"
package com.learning.model;

import jakarta.persistence.*;

@Entity
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private String email;
    private String password;
    private String role;
    private String section;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    public String getSection() { return section; }
    public void setSection(String section) { this.section = section; }
}
"@
Set-Content -Path "src/main/java/com/learning/model/User.java" -Value $userContent

$lessonContent = @"
package com.learning.model;

import jakarta.persistence.*;

@Entity
@Table(name = "lessons")
public class Lesson {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String subject;
    private String title;
    @Column(length = 5000)
    private String content;
    private String videoUrl;
    private Integer orderNum;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getSubject() { return subject; }
    public void setSubject(String subject) { this.subject = subject; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public String getVideoUrl() { return videoUrl; }
    public void setVideoUrl(String videoUrl) { this.videoUrl = videoUrl; }
    public Integer getOrderNum() { return orderNum; }
    public void setOrderNum(Integer orderNum) { this.orderNum = orderNum; }
}
"@
Set-Content -Path "src/main/java/com/learning/model/Lesson.java" -Value $lessonContent

$quizContent = @"
package com.learning.model;

import jakarta.persistence.*;

@Entity
@Table(name = "quizzes")
public class Quiz {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String subject;
    private String title;
    private Integer duration;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getSubject() { return subject; }
    public void setSubject(String subject) { this.subject = subject; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public Integer getDuration() { return duration; }
    public void setDuration(Integer duration) { this.duration = duration; }
}
"@
Set-Content -Path "src/main/java/com/learning/model/Quiz.java" -Value $quizContent

$questionContent = @"
package com.learning.model;

import jakarta.persistence.*;

@Entity
@Table(name = "questions")
public class Question {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private Long quizId;
    private String text;
    private String optionA;
    private String optionB;
    private String optionC;
    private String optionD;
    private String correctAnswer;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Long getQuizId() { return quizId; }
    public void setQuizId(Long quizId) { this.quizId = quizId; }
    public String getText() { return text; }
    public void setText(String text) { this.text = text; }
    public String getOptionA() { return optionA; }
    public void setOptionA(String optionA) { this.optionA = optionA; }
    public String getOptionB() { return optionB; }
    public void setOptionB(String optionB) { this.optionB = optionB; }
    public String getOptionC() { return optionC; }
    public void setOptionC(String optionC) { this.optionC = optionC; }
    public String getOptionD() { return optionD; }
    public void setOptionD(String optionD) { this.optionD = optionD; }
    public String getCorrectAnswer() { return correctAnswer; }
    public void setCorrectAnswer(String correctAnswer) { this.correctAnswer = correctAnswer; }
}
"@
Set-Content -Path "src/main/java/com/learning/model/Question.java" -Value $questionContent

$quizAttemptContent = @"
package com.learning.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "quiz_attempts")
public class QuizAttempt {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private Long studentId;
    private Long quizId;
    private Integer score;
    private LocalDateTime completedAt;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Long getStudentId() { return studentId; }
    public void setStudentId(Long studentId) { this.studentId = studentId; }
    public Long getQuizId() { return quizId; }
    public void setQuizId(Long quizId) { this.quizId = quizId; }
    public Integer getScore() { return score; }
    public void setScore(Integer score) { this.score = score; }
    public LocalDateTime getCompletedAt() { return completedAt; }
    public void setCompletedAt(LocalDateTime completedAt) { this.completedAt = completedAt; }
}
"@
Set-Content -Path "src/main/java/com/learning/model/QuizAttempt.java" -Value $quizAttemptContent

$progressContent = @"
package com.learning.model;

import jakarta.persistence.*;

@Entity
@Table(name = "progress")
public class Progress {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private Long studentId;
    private Long lessonId;
    private Integer completion;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Long getStudentId() { return studentId; }
    public void setStudentId(Long studentId) { this.studentId = studentId; }
    public Long getLessonId() { return lessonId; }
    public void setLessonId(Long lessonId) { this.lessonId = lessonId; }
    public Integer getCompletion() { return completion; }
    public void setCompletion(Integer completion) { this.completion = completion; }
}
"@
Set-Content -Path "src/main/java/com/learning/model/Progress.java" -Value $progressContent

$userRepoContent = @"
package com.learning.repository;

import com.learning.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface UserRepo extends JpaRepository<User, Long> {
    User findByEmail(String email);
    List<User> findByRole(String role);
}
"@
Set-Content -Path "src/main/java/com/learning/repository/UserRepo.java" -Value $userRepoContent

$lessonRepoContent = @"
package com.learning.repository;

import com.learning.model.Lesson;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface LessonRepo extends JpaRepository<Lesson, Long> {
    List<Lesson> findBySubjectOrderByOrderNum(String subject);
}
"@
Set-Content -Path "src/main/java/com/learning/repository/LessonRepo.java" -Value $lessonRepoContent

$quizRepoContent = @"
package com.learning.repository;

import com.learning.model.Quiz;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface QuizRepo extends JpaRepository<Quiz, Long> {
    List<Quiz> findBySubject(String subject);
}
"@
Set-Content -Path "src/main/java/com/learning/repository/QuizRepo.java" -Value $quizRepoContent

$questionRepoContent = @"
package com.learning.repository;

import com.learning.model.Question;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface QuestionRepo extends JpaRepository<Question, Long> {
    List<Question> findByQuizId(Long quizId);
}
"@
Set-Content -Path "src/main/java/com/learning/repository/QuestionRepo.java" -Value $questionRepoContent

$quizAttemptRepoContent = @"
package com.learning.repository;

import com.learning.model.QuizAttempt;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface QuizAttemptRepo extends JpaRepository<QuizAttempt, Long> {
    List<QuizAttempt> findByStudentId(Long studentId);
    List<QuizAttempt> findByStudentIdOrderByCompletedAtDesc(Long studentId);
}
"@
Set-Content -Path "src/main/java/com/learning/repository/QuizAttemptRepo.java" -Value $quizAttemptRepoContent

$progressRepoContent = @"
package com.learning.repository;

import com.learning.model.Progress;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface ProgressRepo extends JpaRepository<Progress, Long> {
    List<Progress> findByStudentId(Long studentId);
    Progress findByStudentIdAndLessonId(Long studentId, Long lessonId);
}
"@
Set-Content -Path "src/main/java/com/learning/repository/ProgressRepo.java" -Value $progressRepoContent

$authControllerContent = @"
package com.learning.controller;

import com.learning.model.User;
import com.learning.repository.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;

@Controller
public class AuthController {
    
    @Autowired
    private UserRepo userRepo;
    
    @GetMapping("/")
    public String home() {
        return "redirect:/login";
    }
    
    @GetMapping("/login")
    public String login() {
        return "login";
    }
    
    @PostMapping("/login")
    public String doLogin(@RequestParam String email, 
                         @RequestParam String password, 
                         HttpSession session,
                         Model model) {
        User user = userRepo.findByEmail(email);
        if (user != null && user.getPassword().equals(password)) {
            session.setAttribute("userId", user.getId());
            session.setAttribute("userRole", user.getRole());
            session.setAttribute("userName", user.getName());
            
            if ("STUDENT".equals(user.getRole())) {
                return "redirect:/student/dashboard";
            } else if ("TEACHER".equals(user.getRole())) {
                return "redirect:/teacher/dashboard";
            }
        }
        model.addAttribute("error", "Invalid credentials");
        return "login";
    }
    
    @GetMapping("/register")
    public String register() {
        return "register";
    }
    
    @PostMapping("/register")
    public String doRegister(@RequestParam String name,
                            @RequestParam String email,
                            @RequestParam String password,
                            @RequestParam String role,
                            @RequestParam(required = false) String section) {
        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);
        user.setRole(role);
        user.setSection(section);
        userRepo.save(user);
        return "redirect:/login";
    }
    
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
"@
Set-Content -Path "src/main/java/com/learning/controller/AuthController.java" -Value $authControllerContent

$studentControllerContent = @"
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
"@
Set-Content -Path "src/main/java/com/learning/controller/StudentController.java" -Value $studentControllerContent

$teacherControllerContent = @"
package com.learning.controller;

import com.learning.model.*;
import com.learning.repository.*;
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
"@
Set-Content -Path "src/main/java/com/learning/controller/TeacherController.java" -Value $teacherControllerContent

Write-Host "Java files created (WITHOUT Lombok)!" -ForegroundColor Green
Write-Host "Creating resource files..." -ForegroundColor Cyan

$propertiesContent = @"
spring.datasource.url=jdbc:mysql://localhost:3306/learning_db
spring.datasource.username=root
spring.datasource.password=
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true

server.port=8080

spring.thymeleaf.cache=false
spring.thymeleaf.prefix=classpath:/templates/
spring.thymeleaf.suffix=.html
"@
Set-Content -Path "src/main/resources/application.properties" -Value $propertiesContent

$configJsContent = @"
const SUBJECTS = {
    math: {
        name: "Mathematics",
        icon: "📐",
        color: "#3B82F6",
        bg: "#EFF6FF"
    },
    english: {
        name: "English",
        icon: "📚",
        color: "#10B981",
        bg: "#ECFDF5"
    },
    science: {
        name: "Science",
        icon: "🔬",
        color: "#8B5CF6",
        bg: "#F5F3FF"
    }
};
"@
Set-Content -Path "src/main/resources/static/js/config.js" -Value $configJsContent

$componentsJsContent = @"
document.addEventListener('DOMContentLoaded', () => {
    document.querySelectorAll('[data-subject]').forEach(el => {
        const subject = el.dataset.subject;
        const config = SUBJECTS[subject];
        
        if (!config) return;
        
        const icon = el.querySelector('.subject-icon');
        if (icon) icon.textContent = config.icon;
        
        if (el.classList.contains('subject-card')) {
            el.style.borderColor = config.color;
            el.style.background = config.bg;
        }
        
        const btn = el.querySelector('.btn');
        if (btn) btn.style.background = config.color;
        
        const header = el.querySelector('h3, h4');
        if (header) header.style.color = config.color;
    });
});
"@
Set-Content -Path "src/main/resources/static/js/components.js" -Value $componentsJsContent

$cssContent = @"
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
    background: #f8fafc;
    color: #334155;
}

nav {
    background: white;
    padding: 1rem 2rem;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.nav-brand {
    font-weight: 700;
    font-size: 1.2rem;
    color: #3B82F6;
}

.nav-menu a {
    margin-left: 1.5rem;
    text-decoration: none;
    color: #64748b;
    font-weight: 500;
}

.container {
    max-width: 1200px;
    margin: 2rem auto;
    padding: 0 1rem;
}

.form-group {
    margin-bottom: 1rem;
}

.form-group label {
    display: block;
    margin-bottom: 0.5rem;
    font-weight: 500;
}

.form-group input, .form-group select, .form-group textarea {
    width: 100%;
    padding: 0.75rem;
    border: 1px solid #cbd5e1;
    border-radius: 6px;
    font-size: 1rem;
}

.btn {
    padding: 0.75rem 1.5rem;
    border: none;
    border-radius: 6px;
    font-size: 1rem;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.2s;
}

.btn-primary {
    background: #3B82F6;
    color: white;
}

.card {
    background: white;
    border-radius: 8px;
    padding: 1.5rem;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    margin-bottom: 1rem;
}

.subject-card {
    text-align: center;
    cursor: pointer;
    transition: transform 0.2s;
    border: 2px solid;
}

.subject-card:hover {
    transform: translateY(-4px);
}

.subject-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 1.5rem;
}
"@
Set-Content -Path "src/main/resources/static/css/style.css" -Value $cssContent

Write-Host "Resource files created!" -ForegroundColor Green
Write-Host "Creating HTML template files..." -ForegroundColor Cyan

$htmlFiles = @(
    "login.html",
    "register.html",
    "student-dashboard.html",
    "lessons.html",
    "quiz-take.html",
    "results.html",
    "teacher-dashboard.html",
    "teacher-lessons.html",
    "teacher-quizzes.html"
)

foreach ($file in $htmlFiles) {
    $htmlTemplate = @"
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>$($file -replace '.html','')</title>
    <link rel="stylesheet" th:href="@{/css/style.css}">
    <script th:src="@{/js/config.js}"></script>
    <script th:src="@{/js/components.js}"></script>
</head>
<body>
    <h1>$($file -replace '.html','')</h1>
</body>
</html>
"@
    Set-Content -Path "src/main/resources/templates/$file" -Value $htmlTemplate
}

$layoutFragment = @"
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head th:fragment="head(title)">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title th:text="`${title}">App</title>
    <link rel="stylesheet" th:href="@{/css/style.css}">
    <script th:src="@{/js/config.js}"></script>
    <script th:src="@{/js/components.js}"></script>
</head>
<body>
    <nav th:fragment="nav(role)">
        <div class="nav-brand">🎓 Grade 6 Learning</div>
        <div class="nav-menu">
            <a th:if="`${role} == 'STUDENT'" th:href="@{/student/dashboard}">Dashboard</a>
            <a th:if="`${role} == 'TEACHER'" th:href="@{/teacher/dashboard}">Dashboard</a>
            <a th:href="@{/logout}">Logout</a>
        </div>
    </nav>
</body>
</html>
"@
Set-Content -Path "src/main/resources/templates/fragments/layout.html" -Value $layoutFragment

$componentsFragment = @"
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<body>
    <div th:fragment="subject-card(subject)" 
         class="subject-card" 
         th:attr="data-subject=`${subject}">
        <div class="subject-icon"></div>
        <h3 th:text="`${subject}">Subject</h3>
        <button class="btn btn-primary">Select</button>
    </div>
</body>
</html>
"@
Set-Content -Path "src/main/resources/templates/fragments/components.html" -Value $componentsFragment

Write-Host "HTML template files created!" -ForegroundColor Green
Write-Host "`n========================================" -ForegroundColor Yellow
Write-Host "FILE STRUCTURE CREATED SUCCESSFULLY!" -ForegroundColor Green
Write-Host "WITHOUT LOMBOK - Plain Java!" -ForegroundColor Magenta
Write-Host "========================================`n" -ForegroundColor Yellow
Write-Host "Created:" -ForegroundColor Cyan
Write-Host "  ✓ 6 Model files (with manual getters/setters)" -ForegroundColor White
Write-Host "  ✓ 6 Repository files" -ForegroundColor White
Write-Host "  ✓ 3 Controller files" -ForegroundColor White
Write-Host "  ✓ 11 HTML template files" -ForegroundColor White
Write-Host "  ✓ 3 Static files (CSS + JS)" -ForegroundColor White
Write-Host "`nNext Steps:" -ForegroundColor Yellow
Write-Host "  1. Update pom.xml (remove Lombok)" -ForegroundColor White
Write-Host "  2. Delete old model files" -ForegroundColor White
Write-Host "  3. Run this script" -ForegroundColor White
Write-Host "  4. Clean and Build in NetBeans" -ForegroundColor White
Write-Host "  5. Run the application!" -ForegroundColor White
Write-Host "`n🚀 Ready to run without Lombok!" -ForegroundColor Green