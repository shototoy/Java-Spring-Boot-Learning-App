Write-Host "Creating directory structure..." -ForegroundColor Green
New-Item -ItemType Directory -Force -Path "src/main/java/com/learning/model" | Out-Null
New-Item -ItemType Directory -Force -Path "src/main/java/com/learning/repository" | Out-Null
New-Item -ItemType Directory -Force -Path "src/main/java/com/learning/controller" | Out-Null
New-Item -ItemType Directory -Force -Path "src/main/resources/static/css" | Out-Null
New-Item -ItemType Directory -Force -Path "src/main/resources/static/js" | Out-Null
New-Item -ItemType Directory -Force -Path "src/main/resources/static/uploads" | Out-Null
New-Item -ItemType Directory -Force -Path "src/main/resources/templates/fragments" | Out-Null

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
    @Column(name = "video_url")
    private String videoUrl;
    @Column(name = "order_num")
    private Integer orderNum;
    @Column(name = "image_path")
    private String imagePath;
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
    public String getImagePath() { return imagePath; }
    public void setImagePath(String imagePath) { this.imagePath = imagePath; }
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
    @Column(name = "quiz_id")
    private Long quizId;
    private String text;
    @Column(name = "option_a")
    private String optionA;
    @Column(name = "option_b")
    private String optionB;
    @Column(name = "option_c")
    private String optionC;
    @Column(name = "option_d")
    private String optionD;
    @Column(name = "correct_answer")
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
    @Column(name = "student_id")
    private Long studentId;
    @Column(name = "quiz_id")
    private Long quizId;
    private Integer score;
    @Column(name = "completed_at")
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
    @Column(name = "student_id")
    private Long studentId;
    @Column(name = "lesson_id")
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

$leaderboardEntryContent = @"
package com.learning.model;
public class LeaderboardEntry {
    private Long id;
    private String name;
    private String section;
    private Integer totalQuizzes;
    private Integer totalScore;
    private Double avgScore;
    private Integer rank;
    private Boolean isCurrentUser;
    public LeaderboardEntry() {}
    public LeaderboardEntry(Long id, String name, String section, Integer totalQuizzes, Integer totalScore, Double avgScore) {
        this.id = id;
        this.name = name;
        this.section = section;
        this.totalQuizzes = totalQuizzes;
        this.totalScore = totalScore;
        this.avgScore = avgScore;
    }
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getSection() { return section; }
    public void setSection(String section) { this.section = section; }
    public Integer getTotalQuizzes() { return totalQuizzes; }
    public void setTotalQuizzes(Integer totalQuizzes) { this.totalQuizzes = totalQuizzes; }
    public Integer getTotalScore() { return totalScore; }
    public void setTotalScore(Integer totalScore) { this.totalScore = totalScore; }
    public Double getAvgScore() { return avgScore; }
    public void setAvgScore(Double avgScore) { this.avgScore = avgScore; }
    public Integer getRank() { return rank; }
    public void setRank(Integer rank) { this.rank = rank; }
    public Boolean getIsCurrentUser() { return isCurrentUser; }
    public void setIsCurrentUser(Boolean isCurrentUser) { this.isCurrentUser = isCurrentUser; }
}
"@
Set-Content -Path "src/main/java/com/learning/model/LeaderboardEntry.java" -Value $leaderboardEntryContent

$userRepoContent = @"
package com.learning.repository;
import com.learning.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.util.List;
@Repository
public interface UserRepo extends JpaRepository<User, Long> {
    User findByEmail(String email);
    List<User> findByRole(String role);
    @Query(value = "SELECT u.id, u.name, u.section, COUNT(qa.id) as totalQuizzes, COALESCE(SUM(qa.score), 0) as totalScore, COALESCE(ROUND(AVG(qa.score), 2), 0) as avgScore FROM users u LEFT JOIN quiz_attempts qa ON u.id = qa.student_id WHERE u.role = 'STUDENT' GROUP BY u.id, u.name, u.section ORDER BY totalScore DESC, avgScore DESC", nativeQuery = true)
    List<Object[]> findLeaderboard();
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

$authControllerContent = @'
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
    public String home(HttpSession session) {
        if (session.getAttribute("userId") != null) {
            String role = (String) session.getAttribute("userRole");
            if ("STUDENT".equals(role)) {
                return "redirect:/student/dashboard";
            } else if ("TEACHER".equals(role)) {
                return "redirect:/teacher/dashboard";
            }
        }
        return "redirect:/login";
    }
    @GetMapping("/login")
    public String login(HttpSession session) {
        if (session.getAttribute("userId") != null) {
            return "redirect:/";
        }
        return "login";
    }
    @PostMapping("/login")
    public String doLogin(@RequestParam String email, @RequestParam String password, HttpSession session, Model model) {
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            model.addAttribute("error", "Email and password are required");
            return "login";
        }
        User user = userRepo.findByEmail(email.trim());
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
        model.addAttribute("error", "Invalid email or password");
        return "login";
    }
    @GetMapping("/register")
    public String register(HttpSession session) {
        if (session.getAttribute("userId") != null) {
            return "redirect:/";
        }
        return "register";
    }
    @PostMapping("/register")
    public String doRegister(@RequestParam String name, @RequestParam String email, @RequestParam String password, @RequestParam String role, @RequestParam(required = false) String section, Model model) {
        if (name == null || name.trim().isEmpty() || email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty() || role == null || role.trim().isEmpty()) {
            model.addAttribute("error", "All required fields must be filled");
            return "register";
        }
        if (userRepo.findByEmail(email.trim()) != null) {
            model.addAttribute("error", "Email already registered");
            return "register";
        }
        User user = new User();
        user.setName(name.trim());
        user.setEmail(email.trim());
        user.setPassword(password);
        user.setRole(role);
        user.setSection(section != null ? section.trim() : null);
        userRepo.save(user);
        return "redirect:/login?registered=true";
    }
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
'@
Set-Content -Path "src/main/java/com/learning/controller/AuthController.java" -Value $authControllerContent

$studentControllerContent = @'
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
        List<LeaderboardEntry> entries = new ArrayList<>();
        int rank = 1;
        LeaderboardEntry currentUserEntry = null;
        for (Object[] row : results) {
            LeaderboardEntry entry = new LeaderboardEntry(
                ((Number) row[0]).longValue(),
                (String) row[1],
                (String) row[2],
                row[3] != null ? ((Number) row[3]).intValue() : 0,
                row[4] != null ? ((Number) row[4]).intValue() : 0,
                row[5] != null ? ((Number) row[5]).doubleValue() : 0.0
            );
            entry.setRank(rank++);
            entry.setIsCurrentUser(entry.getId().equals(userId));
            if (entry.getIsCurrentUser()) {
                currentUserEntry = entry;
            }
            entries.add(entry);
        }
        List<LeaderboardEntry> displayList = entries.stream().limit(3).collect(Collectors.toList());
        if (currentUserEntry != null && currentUserEntry.getRank() > 3) {
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
'@
Set-Content -Path "src/main/java/com/learning/controller/StudentController.java" -Value $studentControllerContent

$teacherControllerContent = @'
package com.learning.controller;
import com.learning.model.*;
import com.learning.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import jakarta.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
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
        List<Object[]> results = userRepo.findLeaderboard();
        List<LeaderboardEntry> topStudents = new ArrayList<>();
        int rank = 1;
        for (Object[] row : results) {
            if (rank > 3) break;
            LeaderboardEntry entry = new LeaderboardEntry(
                ((Number) row[0]).longValue(),
                (String) row[1],
                (String) row[2],
                row[3] != null ? ((Number) row[3]).intValue() : 0,
                row[4] != null ? ((Number) row[4]).intValue() : 0,
                row[5] != null ? ((Number) row[5]).doubleValue() : 0.0
            );
            entry.setRank(rank++);
            topStudents.add(entry);
        }
        model.addAttribute("totalLessons", totalLessons);
        model.addAttribute("totalQuizzes", totalQuizzes);
        model.addAttribute("totalStudents", totalStudents);
        model.addAttribute("topStudents", topStudents);
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
    public String addLesson(@RequestParam String subject, @RequestParam String title, @RequestParam String content, @RequestParam(required = false) String videoUrl, @RequestParam Integer orderNum, @RequestParam(required = false) MultipartFile image, HttpSession session) {
        String redirect = checkSession(session);
        if (redirect != null) return redirect;
        Lesson lesson = new Lesson();
        lesson.setSubject(subject);
        lesson.setTitle(title);
        lesson.setContent(content);
        lesson.setVideoUrl(videoUrl);
        lesson.setOrderNum(orderNum);
        if (image != null && !image.isEmpty()) {
            try {
                String filename = System.currentTimeMillis() + "_" + image.getOriginalFilename();
                String uploadDir = "src/main/resources/static/uploads/";
                File dir = new File(uploadDir);
                if (!dir.exists()) dir.mkdirs();
                File dest = new File(uploadDir + filename);
                image.transferTo(dest);
                lesson.setImagePath("/uploads/" + filename);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        lessonRepo.save(lesson);
        return "redirect:/teacher/lessons";
    }
    @PostMapping("/lesson/edit")
    public String editLesson(@RequestParam Long id, @RequestParam String subject, @RequestParam String title, @RequestParam String content, @RequestParam(required = false) String videoUrl, @RequestParam Integer orderNum, @RequestParam(required = false) MultipartFile image, HttpSession session) {
        String redirect = checkSession(session);
        if (redirect != null) return redirect;
        Lesson lesson = lessonRepo.findById(id).orElse(null);
        if (lesson != null) {
            lesson.setSubject(subject);
            lesson.setTitle(title);
            lesson.setContent(content);
            lesson.setVideoUrl(videoUrl);
            lesson.setOrderNum(orderNum);
            if (image != null && !image.isEmpty()) {
                try {
                    String filename = System.currentTimeMillis() + "_" + image.getOriginalFilename();
                    String uploadDir = "src/main/resources/static/uploads/";
                    File dir = new File(uploadDir);
                    if (!dir.exists()) dir.mkdirs();
                    File dest = new File(uploadDir + filename);
                    image.transferTo(dest);
                    lesson.setImagePath("/uploads/" + filename);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
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
    public String addQuiz(@RequestParam String subject, @RequestParam String title, @RequestParam Integer duration, HttpSession session) {
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
    public String addQuestion(@RequestParam Long quizId, @RequestParam String text, @RequestParam String optionA, @RequestParam String optionB, @RequestParam String optionC, @RequestParam String optionD, @RequestParam String correctAnswer, HttpSession session) {
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
    public String deleteQuestion(@RequestParam Long id, @RequestParam Long quizId, HttpSession session) {
        String redirect = checkSession(session);
        if (redirect != null) return redirect;
        questionRepo.deleteById(id);
        return "redirect:/teacher/quiz/questions?quizId=" + quizId;
    }
}
'@
Set-Content -Path "src/main/java/com/learning/controller/TeacherController.java" -Value $teacherControllerContent

$propertiesContent = @"
spring.datasource.url=jdbc:mysql://localhost:3306/learning_db
spring.datasource.username=root
spring.datasource.password=
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
spring.jpa.hibernate.naming.physical-strategy=org.hibernate.boot.model.naming.PhysicalNamingStrategyStandardImpl
server.port=8080
spring.servlet.multipart.max-file-size=10MB
spring.servlet.multipart.max-request-size=10MB
spring.thymeleaf.cache=false
spring.thymeleaf.prefix=classpath:/templates/
spring.thymeleaf.suffix=.html
"@
Set-Content -Path "src/main/resources/application.properties" -Value $propertiesContent

Write-Host "All Java files, models, repositories, and controllers created!" -ForegroundColor Green
Write-Host "Project structure ready with all features!" -ForegroundColor Cyan