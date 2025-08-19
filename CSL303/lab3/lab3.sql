--Part 1: Joins and Outer Joins

--1
SELECT C.cname AS CourseName, F.fname AS IntructorName
FROM Courses C
JOIN Faculty F ON C.instructor_fid = F.fid;

--2
FROM Students S
JOIN Enrolled E ON S.sid = E.sid
JOIN Courses C ON E.cid = C.cid
JOIN Faculty F ON C.instructor_fid = F.fid
WHERE F.fname = 'Prof. Sharma';

--3
SELECT S.sname AS StudentName, C.cname as CourseName
FROM Students S
LEFT JOIN Enrolled E ON E.sid = S.sid
JOIN Courses C ON C.cid = E.cid;

--4
SELECT F.fname AS InstructorName, C.cname AS CourseName
FROM Faculty F
LEFT JOIN Courses C ON C.instructor_fid = F.fid;

--Part 2: Advanced Conditions and Functions

--1
SELECT sname
FROM Students
WHERE LOWER(sname) LIKE '%a%';

--2
SELECT sid, sname
FROM Students
WHERE discip IS NULL;

--3
SELECT sname, registration_date
FROM Students
WHERE strftime('%Y', registration_date) = '2022';

--4
SELECT sname
FROM Students
WHERE registration_Date BETWEEN '2022-08-01' AND '2022-08-31';

--Part 3: Subqueries and Set Operations

--1
SELECT sname
FROM Students
WHERE gpa > (SELECT AVG(gpa) FROM Students);

--2
SELECT sname
FROM Students
WHERE discip = 'CSE'
EXCEPT
SELECT S.sname
FROM Students S
JOIN Enrolled E ON S.sid = E.sid
WHERE E.cid = 'CSL303';

--3
SELECT cname
FROM Courses C
WHERE EXISTS(
SELECT 1
FROM Enrolled E
WHERE E.cid = C.cid);

--4
SELECT sname
FROM Students S1
WHERE gpa =(
SELECT MAX(S2.gpa)
FROM Students S2
WHERE S2.discip = S1.discip);

--Part 4: Data Manipulation Language (DML)

--1
INSERT INTO Students(sid, sname, discip, gpa, registration_date)
VALUES(201, 'Ravi', 'EE', 8.0, '2023-09-01');

--2
UPDATE Students
SET gpa = gpa*1.10
WHERE sid IN(
SELECT E.sid
FROM Enrolled E
JOIN Courses C ON E.cid = C.cid
JOIN Faculty F ON C.instructor_fid = F.fid
WHERE E.grade = 'A'
AND C.cname = 'Databases'
AND C.cid = 'CSL303');

--3
DELETE FROM Enrolled
WHERE cid = 'MAL251';
