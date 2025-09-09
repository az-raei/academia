--Part 1: Subqueries and Advanced WHERE clauses

SELECT emp_name
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id
WHERE dept_name = 'Marketing';

SELECT emp_name, salary
FROM Employees
WHERE Employees.salary > (SELECT AVG(salary) FROM Employees);

SELECT emp_name
FROM Employees
JOIN Assignments a ON Employees.emp_id = a.emp_id
JOIN Projects p ON p.proj_id = a.proj_id
WHERE p.proj_name = 'Project Phoenix';

SELECT e.emp_name
FROM Employees e
LEFT JOIN Assignments a ON e.emp_id = a.emp_id
WHERE proj_id IS NULL;

SELECT e.emp_name
FROM Employees e
WHERE e.salary > (
SELECT MIN(e_marketing.salary)
FROM Employees e_marketing
JOIN Departments d_marketing 
ON e_marketing.dept_id = d_marketing.dept_id
WHERE d_marketing.dept_name = 'Marketing'
);

SELECT e.emp_name
FROM Employees e
WHERE e.salary > (
SELECT MAX(e_marketing.salary)
FROM Employees e_marketing
JOIN Departments d_marketing 
ON e_marketing.dept_id = d_marketing.dept_id
WHERE d_marketing.dept_name = 'Marketing'
);

--Part 2: Date Functions, NULLs, and Pattern Matching

SELECT emp_name, hire_date
FROM Employees
WHERE strftime('%Y', hire_date) = '2023';

SELECT emp_name
FROM Employees
WHERE manager_id IS NULL;

SELECT emp_name
FROM Employees
WHERE emp_name LIKE '% Smith'
OR emp_name LIKE '% Williams';

SELECT emp_name
FROM Employees
WHERE hire_date >= date('now','-2 years');

--Part 3: Correlated Subqueries and Set Operations

SELECT d.dept_name, e.emp_name, e.salary
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id
WHERE e.salary = (
    SELECT MAX(e2.salary)
    FROM Employees e2
    WHERE e2.dept_id = e.dept_id
);

SELECT e.emp_name
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id
WHERE d.dept_name = 'Engineering'
AND e.emp_id NOT IN(
SELECT a.emp_id
FROM Assignments a
JOIN Projects p ON a.proj_id = p.proj_id
WHERE p.proj_name = 'Project Neptune'
);

SELECT d.dept_name
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_id, d.dept_name
HAVING AVG(e.salary) > (
SELECT AVG(salary)
FROM Employees
);

--Part 4: DDL and DML

ALTER TABLE Employees
ADD COLUMN email TEXT;

UPDATE Employees
SET email = REPLACE(LOWER(emp_name), ' ', '') || 'engineering.com'
WHERE dept_id = (
SELECT dept_id
FROM Departments
WHERE dept_name = 'Engineering'
);

CREATE TABLE HighEarners(
emp_id INTEGER PRIMARY KEY,
emp_name TEXT NOT NULL
);
INSERT INTO HighEarners(emp_id,emp_name)
SELECT emp_id, emp_name
FROM Employees
WHERE salary > 95000;