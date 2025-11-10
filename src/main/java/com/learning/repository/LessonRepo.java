package com.learning.repository;
import com.learning.model.Lesson;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
@Repository
public interface LessonRepo extends JpaRepository<Lesson, Long> {
    List<Lesson> findBySubjectOrderByOrderNum(String subject);
}
