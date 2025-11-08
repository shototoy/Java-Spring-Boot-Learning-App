Write-Host "Creating HTML Templates with Full Database Integration..." -ForegroundColor Green

$layoutFragment = @"
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head th:fragment="head(title)">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title th:text="`${title}">Learning App</title>
    <link rel="stylesheet" th:href="@{/css/style.css}">
    <script th:src="@{/js/config.js}"></script>
    <script th:src="@{/js/components.js}"></script>
</head>
<body>
    <nav th:fragment="nav(role)">
        <div class="nav-brand">🎓 Grade 6 Learning</div>
        <div class="nav-menu">
            <a th:if="`${role} == 'STUDENT'" th:href="@{/student/dashboard}">Dashboard</a>
            <a th:if="`${role} == 'STUDENT'" th:href="@{/student/lessons(subject='math')}">Lessons</a>
            <a th:if="`${role} == 'STUDENT'" th:href="@{/student/results}">My Results</a>
            <a th:if="`${role} == 'TEACHER'" th:href="@{/teacher/dashboard}">Dashboard</a>
            <a th:if="`${role} == 'TEACHER'" th:href="@{/teacher/lessons}">Manage Lessons</a>
            <a th:if="`${role} == 'TEACHER'" th:href="@{/teacher/quizzes}">Manage Quizzes</a>
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
    <div th:fragment="subject-card(subject, subjectName)" class="subject-card" th:attr="data-subject=`${subject}" th:onclick="|window.location.href='/student/lessons?subject=' + '`${subject}'|">
        <div class="subject-icon"></div>
        <h3 th:text="`${subjectName}">Subject</h3>
        <button class="btn btn-primary">View Lessons</button>
    </div>
    <div th:fragment="stat-card(title, value, icon)">
        <div class="card">
            <h4 th:text="`${title}">Stat</h4>
            <div style="display: flex; align-items: center; gap: 1rem; margin-top: 1rem;">
                <span style="font-size: 2rem;" th:text="`${icon}">📊</span>
                <span style="font-size: 2.5rem; font-weight: 700; color: #3B82F6;" th:text="`${value}">0</span>
            </div>
        </div>
    </div>
</body>
</html>
"@
Set-Content -Path "src/main/resources/templates/fragments/components.html" -Value $componentsFragment

$loginHtml = @"
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head th:replace="~{fragments/layout :: head('Login')}"></head>
<body>
    <div style="min-height: 100vh; display: flex; align-items: center; justify-content: center; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
        <div class="card" style="width: 400px; max-width: 90%;">
            <h1 style="text-align: center; margin-bottom: 2rem; color: #3B82F6;">🎓 Grade 6 Learning</h1>
            <h2 style="text-align: center; margin-bottom: 1.5rem;">Login</h2>
            <div th:if="${error}" style="background: #fee; color: #c33; padding: 0.75rem; border-radius: 6px; margin-bottom: 1rem;">
                <span th:text="${error}">Error message</span>
            </div>
            <form th:action="@{/login}" method="post">
                <div class="form-group">
                    <label>Email</label>
                    <input type="email" name="email" required placeholder="your@email.com">
                </div>
                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" required placeholder="Enter password">
                </div>
                <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 1rem;">Login</button>
            </form>
            <div style="text-align: center; margin-top: 1.5rem;">
                <a th:href="@{/register}" style="color: #3B82F6; text-decoration: none;">Don't have an account? Register</a>
            </div>
            <div style="margin-top: 2rem; padding-top: 1rem; border-top: 1px solid #e2e8f0;">
                <p style="font-size: 0.875rem; color: #64748b; text-align: center;">Demo Accounts:</p>
                <p style="font-size: 0.875rem; color: #64748b; text-align: center;">Teacher: teacher@school.com / teacher123</p>
                <p style="font-size: 0.875rem; color: #64748b; text-align: center;">Student: john@student.com / student123</p>
            </div>
        </div>
    </div>
</body>
</html>
"@
Set-Content -Path "src/main/resources/templates/login.html" -Value $loginHtml

$registerHtml = @"
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head th:replace="~{fragments/layout :: head('Register')}"></head>
<body>
    <div style="min-height: 100vh; display: flex; align-items: center; justify-content: center; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
        <div class="card" style="width: 400px; max-width: 90%;">
            <h1 style="text-align: center; margin-bottom: 2rem; color: #3B82F6;">🎓 Register</h1>
            <form th:action="@{/register}" method="post">
                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" name="name" required placeholder="John Doe">
                </div>
                <div class="form-group">
                    <label>Email</label>
                    <input type="email" name="email" required placeholder="your@email.com">
                </div>
                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" required placeholder="Enter password">
                </div>
                <div class="form-group">
                    <label>Role</label>
                    <select name="role" required>
                        <option value="STUDENT">Student</option>
                        <option value="TEACHER">Teacher</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Section (Students only)</label>
                    <input type="text" name="section" placeholder="Section A">
                </div>
                <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 1rem;">Register</button>
            </form>
            <div style="text-align: center; margin-top: 1.5rem;">
                <a th:href="@{/login}" style="color: #3B82F6; text-decoration: none;">Already have an account? Login</a>
            </div>
        </div>
    </div>
</body>
</html>
"@
Set-Content -Path "src/main/resources/templates/register.html" -Value $registerHtml

$studentDashboardHtml = @"
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head th:replace="~{fragments/layout :: head('Student Dashboard')}"></head>
<body>
    <nav th:replace="~{fragments/layout :: nav('STUDENT')}"></nav>
    <div class="container">
        <h1 style="margin-bottom: 2rem;">Welcome, <span th:text="${userName}">Student</span>! 👋</h1>
        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1.5rem; margin-bottom: 3rem;">
            <div th:replace="~{fragments/components :: stat-card('Quizzes Taken', ${totalQuizzes}, '📝')}"></div>
            <div th:replace="~{fragments/components :: stat-card('Lessons Completed', ${totalLessons}, '📚')}"></div>
        </div>
        <h2 style="margin-bottom: 1.5rem;">Choose a Subject</h2>
        <div class="subject-grid">
            <div th:replace="~{fragments/components :: subject-card('math', 'Mathematics')}"></div>
            <div th:replace="~{fragments/components :: subject-card('english', 'English')}"></div>
            <div th:replace="~{fragments/components :: subject-card('science', 'Science')}"></div>
        </div>
        <div th:if="${recentAttempts != null and !recentAttempts.isEmpty()}" style="margin-top: 3rem;">
            <h2 style="margin-bottom: 1.5rem;">Recent Quiz Results</h2>
            <div th:each="attempt : ${recentAttempts}" class="card">
                <div style="display: flex; justify-content: space-between; align-items: center;">
                    <div>
                        <h4>Quiz #<span th:text="${attempt.quizId}">1</span></h4>
                        <p style="color: #64748b; margin-top: 0.5rem;" th:text="${#temporals.format(attempt.completedAt, 'MMM dd, yyyy HH:mm')}">Date</p>
                    </div>
                    <div style="text-align: right;">
                        <span style="font-size: 1.5rem; font-weight: 700; color: #10B981;" th:text="${attempt.score}">0</span>
                        <span style="color: #64748b;">/</span>
                        <span style="color: #64748b;">5</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
"@
Set-Content -Path "src/main/resources/templates/student-dashboard.html" -Value $studentDashboardHtml

$lessonsHtml = @"
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head th:replace="~{fragments/layout :: head('Lessons')}"></head>
<body>
    <nav th:replace="~{fragments/layout :: nav('STUDENT')}"></nav>
    <div class="container">
        <div style="margin-bottom: 2rem;">
            <a th:href="@{/student/dashboard}" style="color: #3B82F6; text-decoration: none;">← Back to Dashboard</a>
        </div>
        <h1 style="margin-bottom: 1rem;" th:attr="data-subject=${subject}">
            <span class="subject-icon"></span>
            <span th:text="${subject}">Subject</span> Lessons
        </h1>
        <div th:if="${lessons == null or lessons.isEmpty()}" class="card">
            <p style="text-align: center; color: #64748b;">No lessons available yet.</p>
        </div>
        <div th:each="lesson, iterStat : ${lessons}" class="card" th:attr="data-subject=${subject}">
            <div style="display: flex; justify-content: space-between; align-items: start;">
                <div style="flex: 1;">
                    <h3 th:text="${iterStat.index + 1} + '. ' + ${lesson.title}">Lesson Title</h3>
                    <p style="color: #64748b; margin-top: 1rem; line-height: 1.6;" th:text="${lesson.content}">Lesson content</p>
                    <div th:if="${lesson.videoUrl != null and !lesson.videoUrl.isEmpty()}" style="margin-top: 1rem;">
                        <a th:href="${lesson.videoUrl}" target="_blank" style="color: #3B82F6; text-decoration: none;">📹 Watch Video</a>
                    </div>
                </div>
            </div>
        </div>
        <div th:if="${lessons != null and !lessons.isEmpty()}" style="margin-top: 2rem;">
            <h2 style="margin-bottom: 1rem;">Take a Quiz</h2>
            <div style="display: grid; gap: 1rem;">
                <div class="card" style="cursor: pointer;" th:onclick="|window.location.href='/student/quiz?id=1'|">
                    <h4>Quick Quiz - Test Your Knowledge</h4>
                    <p style="color: #64748b; margin-top: 0.5rem;">5 questions • 15 minutes</p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
"@
Set-Content -Path "src/main/resources/templates/lessons.html" -Value $lessonsHtml

$quizTakeHtml = @"
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head th:replace="~{fragments/layout :: head('Take Quiz')}"></head>
<body>
    <nav th:replace="~{fragments/layout :: nav('STUDENT')}"></nav>
    <div class="container">
        <div style="margin-bottom: 2rem;">
            <a th:href="@{/student/dashboard}" style="color: #3B82F6; text-decoration: none;">← Back to Dashboard</a>
        </div>
        <div class="card" style="margin-bottom: 2rem;">
            <h1 th:text="${quiz.title}">Quiz Title</h1>
            <p style="color: #64748b; margin-top: 0.5rem;">Duration: <span th:text="${quiz.duration}">15</span> minutes</p>
        </div>
        <form th:action="@{/student/quiz/submit}" method="post">
            <input type="hidden" name="quizId" th:value="${quiz.id}">
            <div th:each="question, iterStat : ${questions}" class="card" style="margin-bottom: 1.5rem;">
                <h3 style="margin-bottom: 1rem;">Question <span th:text="${iterStat.index + 1}">1</span></h3>
                <p style="font-weight: 500; margin-bottom: 1rem;" th:text="${question.text}">Question text</p>
                <div style="display: flex; flex-direction: column; gap: 0.75rem;">
                    <label style="display: flex; align-items: center; padding: 0.75rem; border: 2px solid #e2e8f0; border-radius: 6px; cursor: pointer;">
                        <input type="radio" th:name="'answers[' + ${iterStat.index} + ']'" value="A" required style="margin-right: 0.75rem;">
                        <span th:text="'A. ' + ${question.optionA}">Option A</span>
                    </label>
                    <label style="display: flex; align-items: center; padding: 0.75rem; border: 2px solid #e2e8f0; border-radius: 6px; cursor: pointer;">
                        <input type="radio" th:name="'answers[' + ${iterStat.index} + ']'" value="B" required style="margin-right: 0.75rem;">
                        <span th:text="'B. ' + ${question.optionB}">Option B</span>
                    </label>
                    <label style="display: flex; align-items: center; padding: 0.75rem; border: 2px solid #e2e8f0; border-radius: 6px; cursor: pointer;">
                        <input type="radio" th:name="'answers[' + ${iterStat.index} + ']'" value="C" required style="margin-right: 0.75rem;">
                        <span th:text="'C. ' + ${question.optionC}">Option C</span>
                    </label>
                    <label style="display: flex; align-items: center; padding: 0.75rem; border: 2px solid #e2e8f0; border-radius: 6px; cursor: pointer;">
                        <input type="radio" th:name="'answers[' + ${iterStat.index} + ']'" value="D" required style="margin-right: 0.75rem;">
                        <span th:text="'D. ' + ${question.optionD}">Option D</span>
                    </label>
                </div>
            </div>
            <button type="submit" class="btn btn-primary" style="width: 100%; padding: 1rem; font-size: 1.1rem;">Submit Quiz</button>
        </form>
    </div>
</body>
</html>
"@
Set-Content -Path "src/main/resources/templates/quiz-take.html" -Value $quizTakeHtml

$resultsHtml = @"
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head th:replace="~{fragments/layout :: head('Quiz Results')}"></head>
<body>
    <nav th:replace="~{fragments/layout :: nav('STUDENT')}"></nav>
    <div class="container">
        <div style="margin-bottom: 2rem;">
            <a th:href="@{/student/dashboard}" style="color: #3B82F6; text-decoration: none;">← Back to Dashboard</a>
        </div>
        <h1 style="margin-bottom: 2rem;">My Quiz Results 📊</h1>
        <div th:if="${attempts == null or attempts.isEmpty()}" class="card">
            <p style="text-align: center; color: #64748b;">No quiz attempts yet. Take your first quiz!</p>
        </div>
        <div th:each="attempt : ${attempts}" class="card">
            <div style="display: flex; justify-content: space-between; align-items: center;">
                <div>
                    <h3>Quiz #<span th:text="${attempt.quizId}">1</span></h3>
                    <p style="color: #64748b; margin-top: 0.5rem;" th:text="${#temporals.format(attempt.completedAt, 'MMMM dd, yyyy - HH:mm')}">Date</p>
                </div>
                <div style="text-align: right;">
                    <div style="font-size: 2rem; font-weight: 700; color: #10B981;">
                        <span th:text="${attempt.score}">0</span>
                        <span style="font-size: 1.5rem; color: #64748b;">/5</span>
                    </div>
                    <div th:with="percentage=${attempt.score * 20}" style="margin-top: 0.5rem;">
                        <span th:text="${percentage} + '%'" style="color: #64748b; font-size: 0.875rem;">0%</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
"@
Set-Content -Path "src/main/resources/templates/results.html" -Value $resultsHtml

$teacherDashboardHtml = @"
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head th:replace="~{fragments/layout :: head('Teacher Dashboard')}"></head>
<body>
    <nav th:replace="~{fragments/layout :: nav('TEACHER')}"></nav>
    <div class="container">
        <h1 style="margin-bottom: 2rem;">Teacher Dashboard 👨‍🏫</h1>
        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1.5rem; margin-bottom: 3rem;">
            <div th:replace="~{fragments/components :: stat-card('Total Lessons', ${totalLessons}, '📚')}"></div>
            <div th:replace="~{fragments/components :: stat-card('Total Quizzes', ${totalQuizzes}, '📝')}"></div>
            <div th:replace="~{fragments/components :: stat-card('Total Students', ${totalStudents}, '👥')}"></div>
        </div>
        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 1.5rem;">
            <div class="card" style="cursor: pointer;" th:onclick="|window.location.href='/teacher/lessons'|">
                <h3>📚 Manage Lessons</h3>
                <p style="color: #64748b; margin-top: 0.5rem;">Add, edit, or delete lessons</p>
            </div>
            <div class="card" style="cursor: pointer;" th:onclick="|window.location.href='/teacher/quizzes'|">
                <h3>📝 Manage Quizzes</h3>
                <p style="color: #64748b; margin-top: 0.5rem;">Create and manage quizzes</p>
            </div>
        </div>
    </div>
</body>
</html>
"@
Set-Content -Path "src/main/resources/templates/teacher-dashboard.html" -Value $teacherDashboardHtml

$teacherLessonsHtml = @"
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head th:replace="~{fragments/layout :: head('Manage Lessons')}"></head>
<body>
    <nav th:replace="~{fragments/layout :: nav('TEACHER')}"></nav>
    <div class="container">
        <div style="margin-bottom: 2rem;">
            <a th:href="@{/teacher/dashboard}" style="color: #3B82F6; text-decoration: none;">← Back to Dashboard</a>
        </div>
        <h1 style="margin-bottom: 2rem;">Manage Lessons 📚</h1>
        <div class="card">
            <h3 style="margin-bottom: 1.5rem;">Add New Lesson</h3>
            <form th:action="@{/teacher/lesson/add}" method="post">
                <div class="form-group">
                    <label>Subject</label>
                    <select name="subject" required>
                        <option value="math">Mathematics</option>
                        <option value="english">English</option>
                        <option value="science">Science</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Title</label>
                    <input type="text" name="title" required placeholder="Lesson title">
                </div>
                <div class="form-group">
                    <label>Content</label>
                    <textarea name="content" rows="5" required placeholder="Lesson content"></textarea>
                </div>
                <div class="form-group">
                    <label>Video URL (Optional)</label>
                    <input type="url" name="videoUrl" placeholder="https://youtube.com/watch?v=...">
                </div>
                <div class="form-group">
                    <label>Order Number</label>
                    <input type="number" name="orderNum" required value="1" min="1">
                </div>
                <button type="submit" class="btn btn-primary">Add Lesson</button>
            </form>
        </div>
        <h2 style="margin: 2rem 0 1rem;">All Lessons</h2>
        <div th:if="${lessons == null or lessons.isEmpty()}" class="card">
            <p style="text-align: center; color: #64748b;">No lessons yet.</p>
        </div>
        <div th:each="lesson : ${lessons}" class="card">
            <div style="display: flex; justify-content: space-between; align-items: start;">
                <div>
                    <h3 th:text="${lesson.title}">Lesson Title</h3>
                    <p style="color: #64748b; margin-top: 0.5rem;">Subject: <span th:text="${lesson.subject}">math</span> • Order: <span th:text="${lesson.orderNum}">1</span></p>
                    <p style="margin-top: 1rem; line-height: 1.6;" th:text="${lesson.content}">Content</p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
"@
Set-Content -Path "src/main/resources/templates/teacher-lessons.html" -Value $teacherLessonsHtml

$teacherQuizzesHtml = @"
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head th:replace="~{fragments/layout :: head('Manage Quizzes')}"></head>
<body>
    <nav th:replace="~{fragments/layout :: nav('TEACHER')}"></nav>
    <div class="container">
        <div style="margin-bottom: 2rem;">
            <a th:href="@{/teacher/dashboard}" style="color: #3B82F6; text-decoration: none;">← Back to Dashboard</a>
        </div>
        <h1 style="margin-bottom: 2rem;">Manage Quizzes 📝</h1>
        <div class="card">
            <h3 style="margin-bottom: 1.5rem;">Add New Quiz</h3>
            <form th:action="@{/teacher/quiz/add}" method="post">
                <div class="form-group">
                    <label>Subject</label>
                    <select name="subject" required>
                        <option value="math">Mathematics</option>
                        <option value="english">English</option>
                        <option value="science">Science</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Quiz Title</label>
                    <input type="text" name="title" required placeholder="Quiz title">
                </div>
                <div class="form-group">
                    <label>Duration (minutes)</label>
                    <input type="number" name="duration" required value="15" min="5">
                </div>
                <button type="submit" class="btn btn-primary">Create Quiz</button>
            </form>
        </div>
        <h2 style="margin: 2rem 0 1rem;">All Quizzes</h2>
        <div th:if="${quizzes == null or quizzes.isEmpty()}" class="card">
            <p style="text-align: center; color: #64748b;">No quizzes yet.</p>
        </div>
        <div th:each="quiz : ${quizzes}" class="card">
            <div style="display: flex; justify-content: space-between; align-items: center;">
                <div>
                    <h3 th:text="${quiz.title}">Quiz Title</h3>
                    <p style="color: #64748b; margin-top: 0.5rem;">Subject: <span th:text="${quiz.subject}">math</span> • Duration: <span th:text="${quiz.duration}">15</span> min</p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
"@
Set-Content -Path "src/main/resources/templates/teacher-quizzes.html" -Value $teacherQuizzesHtml

Write-Host "`n========================================" -ForegroundColor Yellow
Write-Host "HTML TEMPLATES CREATED SUCCESSFULLY!" -ForegroundColor Green
Write-Host "========================================`n" -ForegroundColor Yellow
Write-Host "Created:" -ForegroundColor Cyan
Write-Host "  ✓ 2 Fragment files (layout, components)" -ForegroundColor White
Write-Host "  ✓ 2 Auth pages (login, register)" -ForegroundColor White
Write-Host "  ✓ 4 Student pages (dashboard, lessons, quiz, results)" -ForegroundColor White
Write-Host "  ✓ 3 Teacher pages (dashboard, lessons, quizzes)" -ForegroundColor White
Write-Host "`nFeatures:" -ForegroundColor Yellow
Write-Host "  ✓ Full database integration with Thymeleaf" -ForegroundColor White
Write-Host "  ✓ Reusable fragments (nav, stat-card, subject-card)" -ForegroundColor White
Write-Host "  ✓ Dynamic subject styling from config.js" -ForegroundColor White
Write-Host "  ✓ Responsive design" -ForegroundColor White
Write-Host "  ✓ Working forms with POST/GET endpoints" -ForegroundColor White
Write-Host "`n🚀 Ready to run!" -ForegroundColor Green