--4 Write a SQL query to find all students majoring in ’Computer Science’

SELECT * FROM Students WHERE major = 'Computer Science';
EXPLAIN QUERY PLAN SELECT * FROM Students WHERE major = 'Computer Science';

--6 Complex Join Query: Write a SQL query to find the first name, last name, and course name for all students enrolled in a course from the ’Humanities’ department

SELECT s.first_name, s.last_name, c.course_name 
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE c.department = 'Humanities';

EXPLAIN QUERY PLAN SELECT s.first_name, s.last_name, c.course_name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE c.department = 'Humanities';