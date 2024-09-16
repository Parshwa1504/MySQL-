/*
MYSQL Agregate function :
[1] COUNT()  
*/

SELECT * FROM salaries ORDER BY salary DESC LIMIT 10;

SELECT COUNT(salary) FROM salaries;
SELECT COUNT(*) FROM salaries ; -- For the null values we use COUNT(*).

SELECT COUNT(DISTINCT salary) FROM salaries;

SELECT COUNT(DISTINCT from_date) FROM  salaries; 

-- How many departments are there in the “employees” database? Use the ‘dept_emp’ table to answer the question.

SELECT COUNT(DISTINCT dept_no) AS department_number FROM dept_emp;

/* 
[2] SUM() 
*/

SELECT SUM(salary) FROM salaries;

-- What is the total amount of money spent on salaries for all contracts starting after the 1st of January 1997?

SELECT 
     SUM(salary)
FROM
    salaries
WHERE
    from_date > '1997-01-01'; 
    
/* 
[3] MAX() AND MIN()  
*/
SELECT MAX(salary) FROM salaries ;
SELECT MIN(salary) FROM salaries ;

-- 1. Which is the lowest employee number in the database?
-- 2. Which is the highest employee number in the database?

SELECT MAX(emp_no) FROM employees;
SELECT MIN(emp_no) FROM employees;

/* 
[4] AVG() 
*/

SELECT AVG(salary) FROM salaries; 

-- What is the average annual salary paid to employees who started after the 1st of January 1997?

SELECT AVG(salary) FROM salaries WHERE from_date > '1997-01-01';  

/* 
[5] ROUND()
*/

SELECT ROUND(AVG(salary)) FROM salaries ;         -- OUTPUT 63761
SELECT ROUND(AVG(salary) , 2) FROM salaries ;  -- OUTPUT 63761.20 

-- Round the average amount of money spent on salaries for all contracts that started after the 1st of January 1997 to a precision of cents.

SELECT ROUND(AVG(salary) , 2) FROM salaries WHERE from_date > '1997-01-01'; 

/* 
[6] IF NULL() AND COALESCE() :  
*/
    
SELECT 
    dept_name,
    IFNULL(dept_name,                         -- is in dept_name value = NULL then it will print 'Department name not provided' or else it will print dept_name only
            'Department name not provided')
FROM
    departments_dup; 
    
SELECT 
    dept_name,
    dept_no,
    COALESCE(dept_manager, dept_name, 'N/A') AS dept_manager  -- IF it finds null value it will check dept_name if there is also null value then it will pint N/A and
                                                               -- if there is value in the table then it will print that value in the dept_manager.
FROM
    departments_dup
ORDER BY dept_no ASC;
    
/* 
Select the department number and name from the ‘departments_dup’ table and
 add a third column where you name the department number (‘dept_no’) as ‘dept_info’. If ‘dept_no’ does not have a value, use ‘dept_name’.
 
 Modify the code obtained from the previous exercise in the following way.
 Apply the IFNULL() function to the values from the first and second column, so that ‘N/A’ is displayed whenever a department number has no value,
 and ‘Department name not provided’ is shown if there is no value for ‘dept_name’.
*/    

  SELECT dept_no , 
  dept_name ,
  coalesce(dept_info, dept_no , dept_name) AS dept_info
  FROM departments_dup ;

 SELECT 
 ifnull(dept_no , 'N/A') AS dept_no, 
  IFNULL(dept_name,'Department name not provided') as dept_name ,
  coalesce(dept_info, dept_no , dept_name) AS dept_info
  FROM departments_dup ;


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