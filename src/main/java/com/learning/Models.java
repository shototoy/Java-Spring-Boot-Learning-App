package com.learning;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "users")
class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private String email;
    private String password;
    private String role;
    private String section;
}

@Data
@Entity
@Table(name = "lessons")
class Lesson {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String subject;
    private String title;
    @Column(length = 5000)
    private String content;
    private String videoUrl;
    private Integer orderNum;
}

@Data
@Entity
@Table(name = "quizzes")
class Quiz {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String subject;
    private String title;
    private Integer duration;
}

@Data
@Entity
@Table(name = "questions")
class Question {
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
}

@Data
@Entity
@Table(name = "quiz_attempts")
class QuizAttempt {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private Long studentId;
    private Long quizId;
    private Integer score;
    private LocalDateTime completedAt;
}

@Data
@Entity
@Table(name = "progress")
class Progress {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private Long studentId;
    private Long lessonId;
    private Integer completion;
}
