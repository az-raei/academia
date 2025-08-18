--lab 2

-- Part 1: Simple Retrieval (SELECT, WHERE, ORDER BY)

--1
SELECT sname,gpa FROM Students WHERE discipline = 'Physics';

--2
SELECT cname,credits FROM Courses WHERE credits = 4;

--3
SELECT cid,sid FROM Enrolled WHERE grade = 'F';

--4
SELECT sname, discipline
FROM Students
ORDER BY discipline, sname ASC;


--Part 2: Joins

--1
SELECT Students.sname
FROM Students
INNER JOIN Enrolled
ON Students.sid = Enrolled.sid
WHERE Enrolled.cid = 'CSL303';

--2
SELECT Courses.cname
FROM Students
INNER JOIN Enrolled 
ON Students.sid = Enrolled.sid
INNER JOIN Courses
ON Enrolled.cid = Courses.cid
WHERE Students.sname = 'Ben Taylor';

--3
SELECT Students.sname, Courses.cname, Enrolled.grade
FROM Students
INNER JOIN Enrolled
ON Students.sid = Enrolled.sid
INNER JOIN Courses
ON Enrolled.cid = Courses.cid;

--4
SELECT s.sname
FROM Students s
LEFT JOIN Enrolled e
ON s.sid = e.sid
WHERE e.cid IS NULL;

--5
SELECT DISTINCT s.sname
FROM Students s
JOIN Enrolled e ON s.sid = e.sid
JOIN Courses c ON e.cid = c.cid
WHERE e.grade = 'B'
AND c.credits = 3;

--Part 3: Aggregation and Grouping

--1
SELECT discipline,
COUNT(sid) AS num_stu
FROM Students
GROUP BY discipline;

--2
SELECT credits,
COUNT(cid) AS num_cou
FROM Courses
GROUP BY credits;

--3
SELECT Courses.cname,
COUNT(Enrolled.sid) AS cou_enr
FROM Courses
LEFT JOIN Enrolled
ON Courses.cid = Enrolled.cid
GROUP BY Courses.cname;

--4
SELECT cid
FROM Enrolled
WHERE grade = 'A'
GROUP BY cid
HAVING COUNT(DISTINCT sid) > 2;