--3

CREATE TABLE Students (
StudentID INT PRIMARY KEY,
FirstName VARCHAR(30) NOT NULL,
LastName VARCHAR(30) NOT NULL,
DISCIPLINE VARCHAR(5)
);

CREATE TABLE Faculty(
FacultyID INT PRIMARY KEY,
FirstName VARCHAR(30) NOT NULL,
LastName VARCHAR(30) NOT NULL,
Department VARCHAR(5)
);

--4

INSERT INTO Students(StudentID, FirstName, LastName, DISCIPLINE) VALUES (12340530, 'Jay', 'Vijay', 'CSE');
INSERT INTO Students(StudentID, FirstName, LastName, DISCIPLINE) VALUES (12340540, 'Vineet', 'Krish', 'CSE');
INSERT INTO Students(StudentID, FirstName, LastName, DISCIPLINE) VALUES (12340560, 'Divij', 'Rathod', 'DSAI');
INSERT INTO Students(StudentID, FirstName, LastName, DISCIPLINE) VALUES (12340600, 'Dhanvijay', 'Nair', 'DSAI');

INSERT INTO Faculty(FacultyID, FirstName, LastName, Department) VALUES (12340540, 'Vineet', 'Krish', 'CSE');
INSERT INTO Faculty(FacultyID, FirstName, LastName, Department) VALUES (12, 'Vineet', 'Murray', 'DSAI');
INSERT INTO Faculty(FacultyID, FirstName, LastName, Department) VALUES (14, 'Vijay', 'Rath', 'CSE');
INSERT INTO Faculty(FacultyID, FirstName, LastName, Department) VALUES (18, 'Rana', 'Rathod', 'CSE');
INSERT INTO Faculty(FacultyID, FirstName, LastName, Department) VALUES (20, 'Dhanvijay', 'Roy', 'DSAI');

--5

SELECT * FROM Students WHERE DISCIPLINE = 'CSE';
--12340530|Jay|Vijay|CSE
--12340540|Vineet|Krish|CSE
SELECT * FROM Faculty WHERE Department = 'CSE';
--12340540|Vineet|Krish|CSE
--14|Vijay|Rath|CSE
--18|Rana|Rathod|CSE

--6

SELECT FirstName LastName FROM Students;
--Jay
--Vineet
--Divij
--Dhanvijay
SELECT LastName, Department FROM Faculty;
--Krish|CSE
--Murray|DSAI
--Rath|CSE
--Rathod|CSE
--Roy|DSAI

--7

SELECT DISTINCT FirstName FROM Students 
UNION 
SELECT DISTINCT FirstName FROM Faculty;
--Dhanvijay
--Divij
--Jay
--Rana
--Vijay
--Vineet
SELECT DISTINCT LastName FROM Students 
UNION 
SELECT DISTINCT LastName FROM Faculty;
--Krish
--Murray
--Nair
--Rath
--Rathod
--Roy
--Vijay

--8

SELECT DISTINCT FirstName FROM Students 
INTERSECT 
SELECT DISTINCT FirstName FROM Faculty;
--Dhanvijay
--Vineet
SELECT DISTINCT LastName FROM Students 
INTERSECT 
SELECT DISTINCT LastName FROM Faculty;
--Krish
--Rathod