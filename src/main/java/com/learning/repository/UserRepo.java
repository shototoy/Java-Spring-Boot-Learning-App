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
