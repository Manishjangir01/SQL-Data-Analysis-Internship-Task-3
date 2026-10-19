-- ============================================================
-- SQL Data Analysis Internship
-- TASK 3 : Advanced SQL Queries (JOIN, GROUP BY, HAVING, subqueries)
--
-- Self-contained: creates the tables, loads sample data and runs
-- the four queries. Safe to run more than once.
-- Works on MySQL 5.7+/8, PostgreSQL and SQLite 3.15+.
-- The sample data reproduces the results in SQL_Data_Analysis_Output.pdf.
-- ============================================================

-- ------------------------------------------------------------
-- Schema
-- ------------------------------------------------------------
DROP TABLE IF EXISTS Enrollments;
DROP TABLE IF EXISTS Courses;
DROP TABLE IF EXISTS Students;

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name      VARCHAR(50) NOT NULL,
    Age       INT
);

CREATE TABLE Courses (
    id   INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE Enrollments (
    student_id INT NOT NULL,
    course_id  INT NOT NULL,
    grade      INT NOT NULL,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Students(StudentID),
    FOREIGN KEY (course_id)  REFERENCES Courses(id)
);

-- ------------------------------------------------------------
-- Sample data (13 students, 3 courses, 18 enrollments)
-- ------------------------------------------------------------
INSERT INTO Students (StudentID, Name, Age) VALUES
(1,  'Simran', 21),
(2,  'Aman',   22),
(3,  'Riya',   20),
(4,  'Neha',   21),
(5,  'Rahul',  20),
(6,  'Pooja',  22),
(7,  'Karan',  21),
(8,  'Sneha',  20),
(9,  'Vikas',  22),
(10, 'Anjali', 21),
(11, 'Arjun',  20),
(12, 'Meera',  21),
(13, 'Ishita', 22);

INSERT INTO Courses (id, name) VALUES
(1, 'SQL'),
(2, 'Python'),
(3, 'Data Analytics');

INSERT INTO Enrollments (student_id, course_id, grade) VALUES
-- SQL (10 students, one below the pass mark)
(1, 1, 95), (2, 1, 82), (3, 1, 78), (4, 1, 88), (5, 1, 76),
(6, 1, 85), (7, 1, 90), (8, 1, 72), (9, 1, 35), (10, 1, 68),
-- Python
(1, 2, 93), (2, 2, 80), (4, 2, 85), (11, 2, 74), (12, 2, 91),
-- Data Analytics
(1, 3, 94), (3, 3, 89), (13, 3, 83);

-- ============================================================
-- Queries
-- ============================================================

-- 1. Top student per course
SELECT
    c.name  AS course_name,
    s.Name  AS student_name,
    e.grade AS top_grade
FROM Enrollments e
JOIN Students s ON e.student_id = s.StudentID
JOIN Courses  c ON e.course_id  = c.id
WHERE (e.course_id, e.grade) IN (
    SELECT course_id, MAX(grade)
    FROM Enrollments
    GROUP BY course_id
)
ORDER BY c.id;

-- 2. Pass rate per course (grade >= 40)
SELECT
    c.name AS course_name,
    ROUND(
        SUM(CASE WHEN e.grade >= 40 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS pass_rate_percentage
FROM Enrollments e
JOIN Courses c ON e.course_id = c.id
GROUP BY c.id, c.name
ORDER BY c.id;

-- 3. Overall topper across all courses (highest average grade)
SELECT
    s.Name AS student_name,
    ROUND(AVG(e.grade), 2) AS average_marks
FROM Enrollments e
JOIN Students s ON e.student_id = s.StudentID
GROUP BY s.StudentID, s.Name
ORDER BY average_marks DESC
LIMIT 1;

-- 4. Students enrolled in multiple courses
SELECT
    s.Name AS student_name,
    COUNT(e.course_id) AS total_courses
FROM Enrollments e
JOIN Students s ON e.student_id = s.StudentID
GROUP BY s.StudentID, s.Name
HAVING COUNT(e.course_id) > 1
ORDER BY total_courses, s.StudentID;
