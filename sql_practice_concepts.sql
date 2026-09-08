-- SQL Practice Concepts: Beginner to Advanced

-- 1. Create tables
CREATE TABLE departments (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department_id INT,
    salary DECIMAL(10, 2),
    email VARCHAR(150) UNIQUE,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

-- 2. Insert data
INSERT INTO departments (id, name)
VALUES (1, 'IT'), (2, 'Finance');

INSERT INTO employees (id, name, department_id, salary, email)
VALUES
    (1, 'Anita', 1, 65000, 'anita@example.com'),
    (2, 'Rahul', 2, 55000, 'rahul@example.com');

-- 3. Select, filter, sort, and limit
SELECT name, salary
FROM employees
WHERE salary > 50000
ORDER BY salary DESC;

SELECT DISTINCT department_id
FROM employees;

-- 4. Filtering operators
SELECT *
FROM employees
WHERE salary BETWEEN 40000 AND 80000
  AND name LIKE 'A%';

SELECT *
FROM employees
WHERE department_id IN (1, 2)
  AND email IS NOT NULL;

-- 5. Update and delete
UPDATE employees
SET salary = 70000
WHERE name = 'Anita';

DELETE FROM employees
WHERE id = 2;

-- 6. Aggregate functions
SELECT
    department_id,
    COUNT(*) AS employee_count,
    AVG(salary) AS average_salary,
    MIN(salary) AS minimum_salary,
    MAX(salary) AS maximum_salary,
    SUM(salary) AS total_salary
FROM employees
GROUP BY department_id
HAVING AVG(salary) > 50000;

-- 7. Joins
SELECT e.name, d.name AS department_name, e.salary
FROM employees AS e
INNER JOIN departments AS d
    ON e.department_id = d.id;

SELECT e.name, d.name AS department_name
FROM employees AS e
LEFT JOIN departments AS d
    ON e.department_id = d.id;

-- 8. Subquery
SELECT name, salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);

-- 9. Conditional logic
SELECT
    name,
    CASE
        WHEN salary >= 80000 THEN 'High'
        WHEN salary >= 50000 THEN 'Medium'
        ELSE 'Low'
    END AS salary_level
FROM employees;

-- 10. Common Table Expression (CTE)
WITH department_average AS (
    SELECT department_id, AVG(salary) AS average_salary
    FROM employees
    GROUP BY department_id
)
SELECT *
FROM department_average
WHERE average_salary > 50000;

-- 11. Window function
SELECT
    name,
    department_id,
    salary,
    RANK() OVER (
        PARTITION BY department_id
        ORDER BY salary DESC
    ) AS salary_rank
FROM employees;

-- 12. View
CREATE VIEW high_paid_employees AS
SELECT name, salary
FROM employees
WHERE salary > 80000;

-- 13. Index
CREATE INDEX idx_employee_department
ON employees(department_id);

-- 14. Transaction example
BEGIN;

UPDATE employees
SET salary = salary + 1000
WHERE department_id = 1;

COMMIT;

-- 15. Set operators
SELECT email FROM employees
UNION
SELECT email FROM employees;

-- 16. Data definition commands
-- ALTER TABLE employees ADD COLUMN hire_date DATE;
-- TRUNCATE TABLE employees;
-- DROP TABLE employees;

-- Important concepts to study:
-- Primary keys, foreign keys, constraints, normalization, joins,
-- subqueries, CTEs, window functions, transactions, indexes,
-- EXPLAIN plans, views, stored procedures, security, and SQL injection prevention.
