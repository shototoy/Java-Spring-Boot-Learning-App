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
