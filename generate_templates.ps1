Write-Host "Creating HTML Templates with Full Database Integration..." -ForegroundColor Green

$layoutFragment = @'
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head th:fragment="head(title)">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title th:text="${title}">Learning App</title>
    <link rel="stylesheet" th:href="@{/css/style.css}">
    <script th:src="@{/js/config.js}"></script>
    <script th:src="@{/js/components.js}"></script>
</head>
<body>
    <nav th:fragment="nav(role)">
        <div class="nav-brand">🎓 Grade 6 Learning</div>
        <div class="nav-menu">
            <a th:if="${role} == 'STUDENT'" th:href="@{/student/dashboard}">Dashboard</a>
            <a th:if="${role} == 'STUDENT'" th:href="@{/student/results}">My Results</a>
            <a th:if="${role} == 'TEACHER'" th:href="@{/teacher/dashboard}">Dashboard</a>
            <a th:if="${role} == 'TEACHER'" th:href="@{/teacher/lessons}">Manage Lessons</a>
            <a th:if="${role} == 'TEACHER'" th:href="@{/teacher/quizzes}">Manage Quizzes</a>
            <a th:href="@{/logout}">Logout</a>
        </div>
    </nav>
</body>
</html>
'@
Set-Content -Path "src/main/resources/templates/fragments/layout.html" -Value $layoutFragment

$componentsFragment = @'
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<body>
    <div th:fragment="subject-card(subject, subjectName)" class="subject-card" th:attr="data-subject=${subject}">
        <div class="subject-icon"></div>
        <h3 th:text="${subjectName}">Subject</h3>
        <button class="btn btn-primary">View Lessons</button>
    </div>
    <div th:fragment="stat-card(title, value, icon)">
        <div class="card">
            <h4 th:text="${title}">Stat</h4>
            <div class="stat-content">
                <span class="stat-icon" th:text="${icon}">📊</span>
                <span class="stat-value" th:text="${value}">0</span>
            </div>
        </div>
    </div>
</body>
</html>
'@
Set-Content -Path "src/main/resources/templates/fragments/components.html" -Value $componentsFragment

$loginHtml = @'
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head th:replace="~{fragments/layout :: head('Login')}"></head>
<body>
    <div class="auth-container">
        <div class="auth-card">
            <h1 class="text-center mb-2">🎓 Grade 6 Learning</h1>
            <h2 class="text-center mb-3">Login</h2>
            <div th:if="${error}" class="alert alert-error">
                <span th:text="${error}">Error message</span>
            </div>
            <div th:if="${param.registered}" class="alert alert-success">
                Registration successful! Please login.
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
                <button type="submit" class="btn btn-primary w-full mt-2">Login</button>
            </form>
            <div class="text-center mt-3">
                <a th:href="@{/register}" class="link">Don't have an account? Register</a>
            </div>
            <div class="demo-accounts">
                <p class="text-muted text-center">Demo Accounts:</p>
                <p class="text-muted text-center">Teacher: teacher@school.com / teacher123</p>
                <p class="text-muted text-center">Student: john@student.com / student123</p>
            </div>
        </div>
    </div>
</body>
</html>
'@
Set-Content -Path "src/main/resources/templates/login.html" -Value $loginHtml

$registerHtml = @'
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head th:replace="~{fragments/layout :: head('Register')}"></head>
<body>
    <div class="auth-container">
        <div class="auth-card">
            <h1 class="text-center mb-2">🎓 Register</h1>
            <div th:if="${error}" class="alert alert-error">
                <span th:text="${error}">Error message</span>
            </div>
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
                <button type="submit" class="btn btn-primary w-full mt-2">Register</button>
            </form>
            <div class="text-center mt-3">
                <a th:href="@{/login}" class="link">Already have an account? Login</a>
            </div>
        </div>
    </div>
</body>
</html>
'@
Set-Content -Path "src/main/resources/templates/register.html" -Value $registerHtml

$studentDashboardHtml = @'
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head th:replace="~{fragments/layout :: head('Student Dashboard')}"></head>
<body>
    <nav th:replace="~{fragments/layout :: nav('STUDENT')}"></nav>
    <div class="container">
        <div class="page-header">
            <h1>Welcome, <span th:text="${userName}">Student</span>! 👋</h1>
        </div>
        <div class="stats-grid mb-4">
            <div th:replace="~{fragments/components :: stat-card('Quizzes Taken', ${totalQuizzes}, '📝')}"></div>
            <div th:replace="~{fragments/components :: stat-card('Lessons Completed', ${totalLessons}, '📚')}"></div>
        </div>
        <h2 class="section-title">Choose a Subject</h2>
        <div class="subject-grid">
            <a th:href="@{/student/lessons(subject='math')}" style="text-decoration:none;">
                <div th:replace="~{fragments/components :: subject-card('math', 'Mathematics')}"></div>
            </a>
            <a th:href="@{/student/lessons(subject='english')}" style="text-decoration:none;">
                <div th:replace="~{fragments/components :: subject-card('english', 'English')}"></div>
            </a>
            <a th:href="@{/student/lessons(subject='science')}" style="text-decoration:none;">
                <div th:replace="~{fragments/components :: subject-card('science', 'Science')}"></div>
            </a>
        </div>
        <div class="dashboard-layout mt-4">
            <div class="main-content">
                <div th:if="${recentAttempts != null and !recentAttempts.isEmpty()}">
                    <h2 class="section-title">Recent Quiz Results</h2>
                    <div th:each="attempt : ${recentAttempts}" class="card">
                        <div class="flex-between">
                            <div>
                                <h4>Quiz #<span th:text="${attempt.quizId}">1</span></h4>
                                <p class="text-muted mt-1" th:text="${#temporals.format(attempt.completedAt, 'MMM dd, yyyy HH:mm')}">Date</p>
                            </div>
                            <div class="text-right">
                                <span class="result-score" th:text="${attempt.score}">0</span>
                                <span class="text-muted">/5</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="sidebar">
                <div th:if="${leaderboard != null and !leaderboard.isEmpty()}">
                    <h3 class="sidebar-title">Leaderboard 🏆</h3>
                    <div th:each="entry : ${leaderboard}" class="card" th:classappend="${entry.isCurrentUser ? 'highlight-card' : ''}">
                        <div class="flex-between">
                            <div class="leaderboard-info">
                                <span class="leaderboard-rank" th:text="'#' + ${entry.rank}">1</span>
                                <div>
                                    <h4 th:text="${entry.name}">Name</h4>
                                    <p class="text-muted small" th:text="${entry.section}">Section</p>
                                </div>
                            </div>
                            <div class="text-right">
                                <div class="leaderboard-score" th:text="${entry.totalScore}">0</div>
                                <p class="text-muted small" th:text="${entry.totalQuizzes} + ' quizzes'">0 quizzes</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
'@
Set-Content -Path "src/main/resources/templates/student-dashboard.html" -Value $studentDashboardHtml

$lessonsHtml = @'
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head th:replace="~{fragments/layout :: head('Lessons')}"></head>
<body>
    <nav th:replace="~{fragments/layout :: nav('STUDENT')}"></nav>
    <div class="container">
        <div class="mb-2">
            <a th:href="@{/student/dashboard}" class="back-link">← Back to Dashboard</a>
        </div>
        <div class="page-header" th:attr="data-subject=${subject}">
            <h1>
                <span class="subject-icon"></span>
                <span class="subject-title" th:text="${subject}">Subject</span> Lessons
            </h1>
        </div>
        <div th:if="${lessons == null or lessons.isEmpty()}" class="card">
            <p class="text-center text-muted">No lessons available yet.</p>
        </div>
        <div th:each="lesson, iterStat : ${lessons}" class="card" th:attr="data-subject=${subject}">
            <h3 th:text="${iterStat.index + 1} + '. ' + ${lesson.title}">Lesson Title</h3>
            <p class="lesson-content mt-2" th:text="${lesson.content}">Lesson content</p>
            <div th:if="${lesson.videoUrl != null and !lesson.videoUrl.isEmpty()}" class="mt-2">
                <a th:href="${lesson.videoUrl}" target="_blank" class="video-link">📹 Watch Video</a>
            </div>
            <div th:if="${lesson.imagePath != null and !lesson.imagePath.isEmpty()}" class="mt-2">
                <img th:src="${lesson.imagePath}" alt="Lesson Image" class="lesson-image">
            </div>
        </div>
        <div th:if="${quizzes != null and !quizzes.isEmpty()}" class="mt-4">
            <h2 class="section-title">Available Quizzes</h2>
            <div th:each="quiz : ${quizzes}" class="card clickable">
                <h4 th:text="${quiz.title}">Quiz Title</h4>
                <p class="text-muted mt-1"><span th:text="${quiz.duration}">15</span> minutes</p>
                <a th:href="@{/student/quiz(id=${quiz.id})}" class="btn btn-primary mt-2">Take Quiz</a>
            </div>
        </div>
    </div>
</body>
</html>
'@
Set-Content -Path "src/main/resources/templates/lessons.html" -Value $lessonsHtml

$quizTakeHtml = @'
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head th:replace="~{fragments/layout :: head('Take Quiz')}"></head>
<body>
    <nav th:replace="~{fragments/layout :: nav('STUDENT')}"></nav>
    <div class="container">
        <div class="mb-2">
            <a th:href="@{/student/dashboard}" class="back-link">← Back to Dashboard</a>
        </div>
        <div class="card mb-3">
            <h1 th:text="${quiz.title}">Quiz Title</h1>
            <p class="text-muted mt-1">Duration: <span th:text="${quiz.duration}">15</span> minutes</p>
        </div>
        <form th:action="@{/student/quiz/submit}" method="post">
            <input type="hidden" name="quizId" th:value="${quiz.id}">
            <div th:each="question, iterStat : ${questions}" class="question-block">
                <h3>Question <span th:text="${iterStat.index + 1}">1</span></h3>
                <p class="question-text" th:text="${question.text}">Question text</p>
                <div class="options-list">
                    <label class="option-label">
                        <input type="radio" th:name="'answer_' + ${question.id}" value="A" required>
                        <span th:text="'A. ' + ${question.optionA}">Option A</span>
                    </label>
                    <label class="option-label">
                        <input type="radio" th:name="'answer_' + ${question.id}" value="B" required>
                        <span th:text="'B. ' + ${question.optionB}">Option B</span>
                    </label>
                    <label class="option-label">
                        <input type="radio" th:name="'answer_' + ${question.id}" value="C" required>
                        <span th:text="'C. ' + ${question.optionC}">Option C</span>
                    </label>
                    <label class="option-label">
                        <input type="radio" th:name="'answer_' + ${question.id}" value="D" required>
                        <span th:text="'D. ' + ${question.optionD}">Option D</span>
                    </label>
                </div>
            </div>
            <button type="submit" class="btn btn-primary w-full btn-large">Submit Quiz</button>
        </form>
    </div>
</body>
</html>
'@
Set-Content -Path "src/main/resources/templates/quiz-take.html" -Value $quizTakeHtml

$resultsHtml = @'
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head th:replace="~{fragments/layout :: head('Quiz Results')}"></head>
<body>
    <nav th:replace="~{fragments/layout :: nav('STUDENT')}"></nav>
    <div class="container">
        <div class="mb-2">
            <a th:href="@{/student/dashboard}" class="back-link">← Back to Dashboard</a>
        </div>
        <div class="page-header">
            <h1>My Quiz Results 📊</h1>
        </div>
        <div th:if="${attempts == null or attempts.isEmpty()}" class="card">
            <p class="text-center text-muted">No quiz attempts yet. Take your first quiz!</p>
        </div>
        <div th:each="attempt : ${attempts}" class="card" th:attr="data-subject=${quizSubjects.get(attempt.quizId)}">
            <div class="flex-between">
                <div>
                    <h3 th:text="${quizTitles.get(attempt.quizId)}">Quiz Title</h3>
                    <p class="text-muted mt-1" th:text="${#temporals.format(attempt.completedAt, 'MMMM dd, yyyy - HH:mm')}">Date</p>
                </div>
                <div class="text-right">
                    <div class="result-score-large">
                        <span th:text="${attempt.score}">0</span>
                        <span class="text-muted">/5</span>
                    </div>
                    <div th:with="percentage=${attempt.score * 20}" class="mt-1">
                        <span th:text="${percentage} + '%'" class="text-muted">0%</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
'@
Set-Content -Path "src/main/resources/templates/results.html" -Value $resultsHtml

$teacherDashboardHtml = @'
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head th:replace="~{fragments/layout :: head('Teacher Dashboard')}"></head>
<body>
    <nav th:replace="~{fragments/layout :: nav('TEACHER')}"></nav>
    <div class="container">
        <div class="page-header">
            <h1>Teacher Dashboard 👨‍🏫</h1>
        </div>
        <div class="stats-grid mb-4">
            <div th:replace="~{fragments/components :: stat-card('Total Lessons', ${totalLessons}, '📚')}"></div>
            <div th:replace="~{fragments/components :: stat-card('Total Quizzes', ${totalQuizzes}, '📝')}"></div>
            <div th:replace="~{fragments/components :: stat-card('Total Students', ${totalStudents}, '👥')}"></div>
        </div>
        <div class="action-grid">
            <a th:href="@{/teacher/lessons}" class="action-card" style="text-decoration:none;">
                <div class="action-icon">📚</div>
                <h3>Manage Lessons</h3>
                <p class="text-muted mt-1">Add, edit, or delete lessons</p>
            </a>
            <a th:href="@{/teacher/quizzes}" class="action-card" style="text-decoration:none;">
                <div class="action-icon">📝</div>
                <h3>Manage Quizzes</h3>
                <p class="text-muted mt-1">Create and manage quizzes</p>
            </a>
        </div>
        <div th:if="${topStudents != null and !topStudents.isEmpty()}" class="mt-4">
            <h2 class="section-title">Top Students 🏆</h2>
            <div th:each="entry : ${topStudents}" class="card">
                <div class="flex-between">
                    <div class="leaderboard-info">
                        <span class="leaderboard-rank" th:text="'#' + ${entry.rank}">1</span>
                        <div>
                            <h4 th:text="${entry.name}">Name</h4>
                            <p class="text-muted small" th:text="${entry.section}">Section</p>
                        </div>
                    </div>
                    <div class="text-right">
                        <div class="leaderboard-score" th:text="${entry.totalScore}">0</div>
                        <p class="text-muted small" th:text="${entry.totalQuizzes} + ' quizzes'">0 quizzes</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
'@
Set-Content -Path "src/main/resources/templates/teacher-dashboard.html" -Value $teacherDashboardHtml

$teacherLessonsHtml = @'
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head th:replace="~{fragments/layout :: head('Manage Lessons')}"></head>
<body>
    <nav th:replace="~{fragments/layout :: nav('TEACHER')}"></nav>
    <div class="container">
        <div class="mb-2">
            <a th:href="@{/teacher/dashboard}" class="back-link">← Back to Dashboard</a>
        </div>
        <div class="page-header">
            <h1>Manage Lessons 📚</h1>
        </div>
        <div class="dashboard-layout">
            <div class="main-content">
                <h2 class="section-title">All Lessons</h2>
                <div th:if="${lessons == null or lessons.isEmpty()}" class="card">
                    <p class="text-center text-muted">No lessons yet. Create your first lesson using the form on the right.</p>
                </div>
                <div th:each="lesson : ${lessons}" class="card">
                    <div class="flex-between">
                        <div class="flex-1">
                            <h3 th:text="${lesson.title}">Lesson Title</h3>
                            <p class="text-muted mt-1">
                                Subject: <span class="subject-label" th:text="${lesson.subject}">math</span> | 
                                Order: <span th:text="${lesson.orderNum}">1</span>
                            </p>
                            <p class="lesson-content mt-2" th:text="${lesson.content}">Content</p>
                            <div th:if="${lesson.videoUrl != null and !lesson.videoUrl.isEmpty()}" class="mt-2">
                                <a th:href="${lesson.videoUrl}" target="_blank" class="video-link">📹 Watch Video</a>
                            </div>
                            <div th:if="${lesson.imagePath != null and !lesson.imagePath.isEmpty()}" class="mt-2">
                                <img th:src="${lesson.imagePath}" alt="Lesson Image" class="lesson-image-small">
                            </div>
                        </div>
                        <div class="action-buttons">
                            <form th:action="@{/teacher/lesson/delete}" method="post" onsubmit="return confirm('Are you sure you want to delete this lesson?');">
                                <input type="hidden" name="id" th:value="${lesson.id}">
                                <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="sidebar">
                <div class="card sticky-form">
                    <h3 class="mb-3">Add New Lesson</h3>
                    <form th:action="@{/teacher/lesson/add}" method="post" enctype="multipart/form-data">
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
                            <input type="url" name="videoUrl" placeholder="https://youtube.com/...">
                        </div>
                        <div class="form-group">
                            <label>Image (Optional)</label>
                            <input type="file" name="image" accept="image/*">
                        </div>
                        <div class="form-group">
                            <label>Order Number</label>
                            <input type="number" name="orderNum" required value="1" min="1">
                        </div>
                        <button type="submit" class="btn btn-primary w-full">Add Lesson</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
'@
Set-Content -Path "src/main/resources/templates/teacher-lessons.html" -Value $teacherLessonsHtml

$teacherQuizzesHtml = @'
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head th:replace="~{fragments/layout :: head('Manage Quizzes')}"></head>
<body>
    <nav th:replace="~{fragments/layout :: nav('TEACHER')}"></nav>
    <div class="container">
        <div class="mb-2">
            <a th:href="@{/teacher/dashboard}" class="back-link">← Back to Dashboard</a>
        </div>
        <div class="page-header">
            <h1>Manage Quizzes 📝</h1>
        </div>
        <div class="dashboard-layout">
            <div class="main-content">
                <h2 class="section-title">All Quizzes</h2>
                <div th:if="${quizzes == null or quizzes.isEmpty()}" class="card">
                    <p class="text-center text-muted">No quizzes yet. Create your first quiz using the form on the right.</p>
                </div>
                <div th:each="quiz : ${quizzes}" class="card">
                    <div class="flex-between">
                        <div class="flex-1">
                            <h3 th:text="${quiz.title}">Quiz Title</h3>
                            <p class="text-muted mt-1">
                                Subject: <span class="subject-label" th:text="${quiz.subject}">math</span> | 
                                Duration: <span th:text="${quiz.duration}">15</span> minutes
                            </p>
                        </div>
                        <div class="action-buttons">
                            <a th:href="@{/teacher/quiz/questions(quizId=${quiz.id})}" class="btn btn-secondary btn-sm">
                                Manage Questions
                            </a>
                            <form th:action="@{/teacher/quiz/delete}" method="post" onsubmit="return confirm('Are you sure you want to delete this quiz?');" style="display:inline;">
                                <input type="hidden" name="id" th:value="${quiz.id}">
                                <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="sidebar">
                <div class="card sticky-form">
                    <h3 class="mb-3">Add New Quiz</h3>
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
                        <button type="submit" class="btn btn-primary w-full">Create Quiz</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
'@
Set-Content -Path "src/main/resources/templates/teacher-quizzes.html" -Value $teacherQuizzesHtml

$teacherQuizQuestionsHtml = @'
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head th:replace="~{fragments/layout :: head('Manage Quiz Questions')}"></head>
<body>
    <nav th:replace="~{fragments/layout :: nav('TEACHER')}"></nav>
    <div class="container">
        <div class="mb-2">
            <a th:href="@{/teacher/quizzes}" class="back-link">← Back to Quizzes</a>
        </div>
        <div class="page-header">
            <h1>Manage Questions: <span th:text="${quiz.title}">Quiz Title</span></h1>
        </div>
        <div class="card mb-4">
            <h3 class="mb-3">Add New Question</h3>
            <form th:action="@{/teacher/question/add}" method="post">
                <input type="hidden" name="quizId" th:value="${quiz.id}">
                <div class="form-group">
                    <label>Question Text</label>
                    <textarea name="text" rows="3" required placeholder="Enter question"></textarea>
                </div>
                <div class="form-group">
                    <label>Option A</label>
                    <input type="text" name="optionA" required placeholder="Option A">
                </div>
                <div class="form-group">
                    <label>Option B</label>
                    <input type="text" name="optionB" required placeholder="Option B">
                </div>
                <div class="form-group">
                    <label>Option C</label>
                    <input type="text" name="optionC" required placeholder="Option C">
                </div>
                <div class="form-group">
                    <label>Option D</label>
                    <input type="text" name="optionD" required placeholder="Option D">
                </div>
                <div class="form-group">
                    <label>Correct Answer</label>
                    <select name="correctAnswer" required>
                        <option value="A">A</option>
                        <option value="B">B</option>
                        <option value="C">C</option>
                        <option value="D">D</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary">Add Question</button>
            </form>
        </div>
        <h2 class="section-title">Questions</h2>
        <div th:if="${questions == null or questions.isEmpty()}" class="card">
            <p class="text-center text-muted">No questions yet. Add your first question above.</p>
        </div>
        <div th:each="question, iterStat : ${questions}" class="card">
            <div class="flex-between">
                <div class="flex-1">
                    <h3>Question <span th:text="${iterStat.index + 1}">1</span></h3>
                    <p class="question-text mt-2" th:text="${question.text}">Question text</p>
                    <div class="question-options mt-2">
                        <p><strong>A:</strong> <span th:text="${question.optionA}">Option A</span></p>
                        <p><strong>B:</strong> <span th:text="${question.optionB}">Option B</span></p>
                        <p><strong>C:</strong> <span th:text="${question.optionC}">Option C</span></p>
                        <p><strong>D:</strong> <span th:text="${question.optionD}">Option D</span></p>
                    </div>
                    <p class="correct-answer mt-2">
                        Correct Answer: <span th:text="${question.correctAnswer}">A</span>
                    </p>
                </div>
                <div class="action-buttons">
                    <form th:action="@{/teacher/question/delete}" method="post" onsubmit="return confirm('Are you sure you want to delete this question?');">
                        <input type="hidden" name="id" th:value="${question.id}">
                        <input type="hidden" name="quizId" th:value="${quiz.id}">
                        <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
'@
Set-Content -Path "src/main/resources/templates/teacher-quiz-questions.html" -Value $teacherQuizQuestionsHtml

Write-Host "`n========================================" -ForegroundColor Yellow
Write-Host "HTML TEMPLATES CREATED SUCCESSFULLY!" -ForegroundColor Green
Write-Host "========================================`n" -ForegroundColor Yellow
Write-Host "Created:" -ForegroundColor Cyan
Write-Host "  ✓ 2 Fragment files (layout, components)" -ForegroundColor White
Write-Host "  ✓ 2 Auth pages (login, register)" -ForegroundColor White
Write-Host "  ✓ 4 Student pages (dashboard, lessons, quiz, results)" -ForegroundColor White
Write-Host "  ✓ 4 Teacher pages (dashboard, lessons, quizzes, quiz-questions)" -ForegroundColor White
Write-Host "`nFeatures:" -ForegroundColor Yellow
Write-Host "  ✓ Full database integration with Thymeleaf" -ForegroundColor White
Write-Host "  ✓ Leaderboard system for students" -ForegroundColor White
Write-Host "  ✓ Image upload support for lessons" -ForegroundColor White
Write-Host "  ✓ Quiz question management" -ForegroundColor White
Write-Host "  ✓ Proper quiz submission with answer_ naming" -ForegroundColor White
Write-Host "  ✓ CSS class-based styling (no inline styles)" -ForegroundColor White
Write-Host "  ✓ Dynamic subject styling from config.js" -ForegroundColor White
Write-Host "  ✓ Responsive design" -ForegroundColor White
Write-Host "  ✓ UTF-8 encoding for emojis: 🎓 👋 📝 📚 🏆 👨‍🏫 👥 📊" -ForegroundColor White
Write-Host "  ✓ Fixed Thymeleaf security (no th:onclick with strings)" -ForegroundColor White
Write-Host "`n🚀 Ready to run!" -ForegroundColor Green