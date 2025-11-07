package com.learning;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
interface UserRepo extends JpaRepository<User, Long> {
    User findByEmail(String email);
    List<User> findByRole(String role);
}

@Repository
interface LessonRepo extends JpaRepository<Lesson, Long> {
    List<Lesson> findBySubjectOrderByOrderNum(String subject);
}

@Repository
interface QuizRepo extends JpaRepository<Quiz, Long> {
    List<Quiz> findBySubject(String subject);
}

@Repository
interface QuestionRepo extends JpaRepository<Question, Long> {
    List<Question> findByQuizId(Long quizId);
}

@Repository
interface QuizAttemptRepo extends JpaRepository<QuizAttempt, Long> {
    List<QuizAttempt> findByStudentId(Long studentId);
    List<QuizAttempt> findByStudentIdOrderByCompletedAtDesc(Long studentId);
}

@Repository
interface ProgressRepo extends JpaRepository<Progress, Long> {
    List<Progress> findByStudentId(Long studentId);
    Progress findByStudentIdAndLessonId(Long studentId, Long lessonId);
}
