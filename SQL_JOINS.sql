--                                                        SQL   JIONS 

 /*
If you currently have the ‘departments_dup’ table set up, use DROP COLUMN to remove the ‘dept_manager’ column from the ‘departments_dup’ table.
Then, use CHANGE COLUMN to change the ‘dept_no’ and ‘dept_name’ columns to NULL.

Then, insert a record whose department name is “Public Relations”.
Delete the record(s) related to department number two.
Insert two new records in the “departments_dup” table. Let their values in the “dept_no” column be “d010” and “d011”.
 */

 COMMIT;
 
 USE employees;
 SELECT * FROM departments_dup ORDER BY dept_no;

ALTER TABLE departments_dup
CHANGE COLUMN dept_no dept_no CHAR(4) NULL;

ALTER TABLE departments_dup
CHANGE COLUMN dept_name dept_name VARCHAR(40) NULL;
 
 INSERT INTO departments_dup
 (
 dept_name
 )VALUES
 (
 'Public Relations'
 );
 
 DELETE FROM departments_dup
 WHERE dept_no = 'd002';
 
 INSERT INTO departments_dup
 (
 dept_no
 )VALUES
 (
 'd010'
 ); 
 
  INSERT INTO departments_dup
 (
 dept_no
 )VALUES
 (
 'd011'
 ); 
 
 -- Create and fill in the ‘dept_manager_dup’ table, using the following code:
 
 DROP TABLE IF EXISTS dept_manager_dup;
 
CREATE TABLE dept_manager_dup (
  emp_no int(11) NOT NULL,
  dept_no char(4) NULL,
  from_date date NOT NULL,
  to_date date NULL
  );

INSERT INTO dept_manager_dup
select * from dept_manager;

INSERT INTO dept_manager_dup (emp_no, from_date)
VALUES                (999904, '2017-01-01'),
                                (999905, '2017-01-01'),
                               (999906, '2017-01-01'),
                               (999907, '2017-01-01');
DELETE FROM dept_manager_dup
WHERE
    dept_no = 'd001';

SELECT * FROM dept_manager_dup ORDER BY dept_no;  

/* 
 [1]  INNER JOINS 
 Syntax:
 
 SELECT table_1.column_name(s) , table_2.column_name(s)
 FROM table_1
 INNER JOIN table_2 ON table_1.column_name = table_2.column_name;
 
 fundamental coding practice used by profesionals:
 
  SELECT t1.column_name(s) , t2.column_name(s)
 FROM table_1 t1
 INNER JOIN table_2 t2 ON t1.column_name = t2.column_name;
 
 */
 
 SELECT d.dept_no , d.dept_name , m.emp_no
 FROM departments_dup d
 INNER JOIN dept_manager_dup m ON d.dept_no = m.dept_no
 ORDER BY d.dept_no;
 
 -- Extract a list containing information about all managers’ employee number, first and last name, department number, and hire date. 
 
 SELECT e.emp_no , e.first_name , e.last_name , e.hire_date , d.dept_no
 FROM employees e
 INNER JOIN dept_manager d ON e.emp_no = d.emp_no 
 ORDER BY e.emp_no ;
 
 -- TO AVOID DUPLICATE RECORDS WE SHOULD ADD GROUP BY FUNCTION IN OUR QUERY : 

 SELECT e.emp_no , e.first_name , e.last_name , e.hire_date , d.dept_no
 FROM employees e
 INNER JOIN dept_manager d ON e.emp_no = d.emp_no 
 GROUP BY e.emp_no
 ORDER BY e.emp_no ; 
 
 /* 
 LEFT JOIN : IT WILL JOIN ALL MATCHING VALUE OF THE TWO TABLES AND ALL VALUES FROM THE LEFT (1ST) TABLE THAT MATCH NO VALUES FROM THE RIGHT (2ND) TABLE 
 SYNTAX:
 
 SELECT t1.column_name(s) , t2.column_name(s)
 FROM table_1 t1
 LEFT JOIN table_2 t2 ON t1.column_name = t2.column_name;
 */
 
 SELECT m.emp_no , m.dept_no , d.dept_name
 FROM dept_manager_dup m
 LEFT JOIN departments_dup d ON m.dept_no = d.dept_no
 ORDER BY m.dept_no;
 
 -- when working with left joins the order in which you join tables matters in inner join it does not matter.
 
 SELECT d.dept_no , d.dept_name , m.emp_no
 FROM departments_dup d
 LEFT JOIN dept_manager_dup m ON d.dept_no = m.dept_no
 ORDER BY d.dept_no;                                       -- this output will be different as we changes the table order
 
 -- if we want to  get the null part of the join result then : 
 
 SELECT m.emp_no , m.dept_no , d.dept_name
 FROM dept_manager_dup m
 LEFT JOIN departments_dup d ON m.dept_no = d.dept_no
 WHERE dept_name IS NULL
 ORDER BY m.dept_no;                               -- it will display the result where dept_name is null .
 
 /*
 Join the 'employees' and the 'dept_manager' tables to return a subset of all the employees whose last name is Markovitch. 
 See if the output contains a manager with that name.  

Hint: Create an output containing information corresponding to the following fields: ‘emp_no’, ‘first_name’, ‘last_name’, ‘dept_no’, ‘from_date’.
 Order by 'dept_no' descending, and then by 'emp_no'.
 */
 
 SELECT e.emp_no , e.last_name , m.dept_no
 FROM employees e
 LEFT JOIN dept_manager m ON e.emp_no = m.emp_no
 WHERE last_name = 'Markovitch'
 ORDER BY m.dept_no;
 
/* 
Extract a list containing information about all managers’ employee number, first and last name, department number, and hire date.
 Use the old type of join syntax to obtain the result.
*/

SELECT d.emp_no ,  d.dept_no , e.first_name , e.last_name , e.hire_date , e.hire_date 
FROM employees e 
RIGHT JOIN dept_manager d ON e.emp_no = d.emp_no
ORDER BY d.dept_no;

SELECT
    e.emp_no,
    e.first_name,
    e.last_name,
    dm.dept_no,
    e.hire_date
FROM
    employees e,
    dept_manager dm
WHERE
    e.emp_no = dm.emp_no;

/* JOIN AND WHERE USED TOGATHER : JOIN is used for connecting two tables 
WHERE is used for defining the conditions.
*/

SELECT e.emp_no , e.first_name , e.last_name , s.salary
FROM employees e
INNER JOIN salaries s ON e.emp_no = s.emp_no
WHERE salary > 145000
ORDER BY emp_no ;

set @@global.sql_mode := replace(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '');

-- Select the first and last name, the hire date, and the job title of all employees whose first name is “Margareta” and have the last name “Markovitch”.

SELECT  e.emp_no , e.first_name , e.last_name , e.hire_date , t.title 
FROM employees e
LEFT JOIN titles t ON e.emp_no = t.emp_no
WHERE (e.first_name,e.last_name) = ('Margareta' , 'Markovitch')
ORDER BY e.emp_no ;

/* CROSS JOIN : IT WILL TAKE THE VALUES FROM  A CERTAIN TABLE AND CONNECT THEM WITH ALL THE VALUES FROM THE TABLE WE WNAT TO JOIN IT WITH . 
SYNTAX : 

SELECT t1 * , t2 * 
FROM table_name t1
CROSS JOIN table_name t2
ORDER BY t1.column_name , t2.column_name; 

*/

SELECT * FROM departments;
SELECT * FROM dept_manager;
    
DELETE FROM departments 
WHERE dept_no = 'd010';

SELECT d.* , dm.*
FROM  dept_manager dm
CROSS JOIN departments d
WHERE dm.dept_no != d.dept_no   -- FOR not showing the department no in which emp is currently working.
ORDER BY dm.emp_no , d.dept_no;

-- Use a CROSS JOIN to return a list with all possible combinations between managers from the dept_manager table and department number 9.

SELECT d.* , dm.*
FROM  dept_manager dm
CROSS JOIN departments d
WHERE  d.dept_no = 'd009'   
ORDER BY dm.emp_no , d.dept_no;

-- Return a list with the first 10 employees with all the departments they can be assigned to.

SELECT * FROM employees ;

SELECT e.* , d.*
FROM employees e
CROSS JOIN departments d 
WHERE e.emp_no < 10011
ORDER BY e.emp_no , d.dept_no; 

-- Using aggregate function with joins : 

USE employees;

SELECT e.gender , AVG(s.salary) AS average_salary
FROM employees e 
JOIN salaries s ON e.emp_no = s.emp_no
GROUP BY gender;

-- JOIN IN MORE THAN TWO TABLES:

SELECT e.first_name , e.last_name , e.hire_date , m.from_date , d.dept_name , d.dept_no
FROM employees e 
JOIN dept_manager m ON e.emp_no = m.emp_no
JOIN departments d ON m.dept_no = d.dept_no
ORDER BY d.dept_no;

-- Select all managers’ first and last name, hire date, job title, start date, and department name. GOOD question understand we only wants title with manager.

SELECT e.first_name , e.last_name , e.hire_date , t.title , dm.from_date , d.dept_name
FROM employees e 
JOIN titles t ON e.emp_no = t.emp_no
JOIN dept_manager dm ON t.emp_no = dm.emp_no
JOIN departments d ON dm.dept_no = d.dept_no
WHERE t.title = 'Manager'
ORDER BY first_name;

-- retrieve a table with average salary and dept_name

SELECT d.dept_name , AVG(salary) as average_salary
FROM departments d
JOIN dept_manager dm ON d.dept_no = dm.dept_no
JOIN salaries s ON dm.emp_no = s.emp_no
GROUP BY dept_name                     
ORDER BY average_salary desc;

-- How many male and how many female managers do we have in the ‘employees’ database?

SELECT e.gender , COUNT(t.emp_no) as no_of_managers
FROM employees e 
JOIN titles t ON e.emp_no = t.emp_no
WHERE t.title = 'Manager'
GROUP BY e.gender;

/* 
UNION AND UNION ALL STATEMENT : Used to combine a few selected statements in a single out put

syntax: 

SELECT N columns
FROM table_1
UNION ALL SELECT          -- When using union use union in place of union all .
N columns 
FROM table_2;
*/

USE employees;
DROP TABLE IF exists employees_dup;

CREATE TABLE employees_dup
(
emp_no INT,
birth_date DATE,
first_name VARCHAR(20),
last_name VARCHAR(20),
gender enum('M','F'),
hire_date DATE
);

INSERT INTO employees_dup
SELECT e.* FROM employees e LIMIT 20;

SELECT * FROM employees_dup;

INSERT INTO employees_dup 
(
emp_no,
birth_date,
first_name,
last_name,
gender,
hire_date
)VALUES
(
10001,
'1953-09-02',
'Georgi',
'Facello',
'M',
'1986-06-26');

-- UNION ALL : IT WILL DISPLAY ALL VALUES INCLUDING DUPLICATE VALUES.

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    NULL AS dept_no,
    NULL AS from_date
FROM
    employees_dup e
WHERE
    e.emp_no = 10001 
UNION ALL SELECT 
    NULL AS emp_no,
    NULL AS first_name,
    NULL AS last_name,
    d.dept_no,
    d.from_date
FROM
    dept_manager d;

-- FOR UNION : it will not display duplicate values.

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    NULL AS dept_no,
    NULL AS from_date
FROM
    employees_dup e
WHERE
    e.emp_no = 10001 
UNION  SELECT 
    NULL AS emp_no,
    NULL AS first_name,
    NULL AS last_name,
    d.dept_no,
    d.from_date
FROM
    dept_manager d;
    
-- Go forward to the solution and execute the query. What do you think is the meaning of the minus sign before subset A in the last row (ORDER BY -a.emp_no DESC)? 

SELECT 
    *
FROM
    (SELECT 
        e.emp_no,
            e.first_name,
            e.last_name,
            NULL AS dept_no,
            NULL AS from_date
    FROM
        employees e
    WHERE
        last_name = 'Denis' UNION SELECT 
        NULL AS emp_no,
            NULL AS first_name,
            NULL AS last_name,
            dm.dept_no,
            dm.from_date
    FROM
        dept_manager dm) AS a
ORDER BY  -a.emp_no DESC;
