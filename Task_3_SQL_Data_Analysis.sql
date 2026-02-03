-- ================================
-- SQL Data Analysis Internship
-- TASK 3 : Advanced SQL Queries
-- ================================

-- Assumed Tables:
-- students(StudentID, Name, ...)
-- courses(id, name)
-- enrollments(student_id, course_id, grade)

-- 1. Top student per course
SELECT 
    c.name AS course_name,
    s.Name AS student_name,
    e.grade AS top_grade
FROM Enrollments e
JOIN Students s ON e.student_id = s.StudentID
JOIN Courses c ON e.course_id = c.id
WHERE (e.course_id, e.grade) IN (
    SELECT course_id, MAX(grade)
    FROM Enrollments
    GROUP BY course_id
);

-- 2. Pass rate per course (grade >= 40)
SELECT 
    c.name AS course_name,
    ROUND(
        SUM(CASE WHEN e.grade >= 40 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS pass_rate_percentage
FROM Enrollments e
JOIN Courses c ON e.course_id = c.id
GROUP BY c.name;

-- 3. Overall topper across all courses
SELECT 
    s.Name AS student_name,
    AVG(e.grade) AS average_marks
FROM Enrollments e
JOIN Students s ON e.student_id = s.StudentID
GROUP BY s.Name
ORDER BY average_marks DESC
LIMIT 1;

-- 4. Students enrolled in multiple courses
SELECT 
    s.Name AS student_name,
    COUNT(e.course_id) AS total_courses
FROM Enrollments e
JOIN Students s ON e.student_id = s.StudentID
GROUP BY s.Name
HAVING COUNT(e.course_id) > 1;
