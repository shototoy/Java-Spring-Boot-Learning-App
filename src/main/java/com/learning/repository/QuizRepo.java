package com.learning.repository;
import com.learning.model.Quiz;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
@Repository
public interface QuizRepo extends JpaRepository<Quiz, Long> {
    List<Quiz> findBySubject(String subject);
}
