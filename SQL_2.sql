USE employees;
/* 
[1]  SELECT STATEMENT : allows to extract a fraction of the entire data set.
syntax:

SELECT column_1,column_2.....column_n
FROM table_name;

*/

SELECT 
    first_name , last_name    -- for extracting first_name and last_name column from the employees table
FROM
    employees;
    
    SELECT * FROM employees;     -- for selecting the all columns from the employees table we use * 
    
    /* 
    Select the information from the “dept_no” column of the “departments” table.

	Select all data from the “departments” table.
    */
    
    SELECT dept_no FROM departments ;
    SELECT * FROM departments;
    
    /*
   [2]
   WHERE CLAUSE IN SELECT STATEMENT : Allows us to set up a condition upon which we will specify what part of the data we want to retrieve from the database.
   
   syntax:
    
    SELECT column_1 , column_2 .... column_n
    FROM table_name
    WHERE condition;
    
    */
    
    SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis';
    
    /* 
    Select all people from the “employees” table whose first name is “Elvis”.
    */
    
    SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Elvis';  -- here = is a equal operator
    
    /* 
    [3] AND operator in WHERE clause : ALLOWS logically combine two statements in the condition code block
    
    syntax:
    
    SELECT column_1 , column_2 ...... column_n
    FROM table_name
    WHERE condition_1 AND condition_2;
    
    */
    
    SELECT * FROM employees WHERE first_name = 'Denis' AND gender = 'M';
    
    /* 
    Retrieve a list with all female employees whose first name is Kellie. 
    */
    
    SELECT * FROM employees WHERE first_name = 'Kellie' AND gender = 'F';
    
    /* 
   [4]   OR OPERATOR:
    
    Syntax:
    
    SELECT column_1 , column_2 ...... column_n
    FROM table_name
    WHERE condition_1 OR condition_2;
    */
    
    SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis'
        OR first_name = 'Elvis';
    
    /* 
    Retrieve a list with all employees whose first name is either Kellie or Aruna.
    */
    
    SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Kellie'
        OR first_name = 'Aruna';
    
    -- OPERATOR PRECIDANCE [ AND > OR ] SQL Will start by reading the condition around the AND operator. USE parenthisis'()' to resolve the issue.
    
    SELECT * FROM employees WHERE first_name = 'Denis' AND ( gender = 'M' OR gender = 'F');
    
    /* 
    Retrieve a list with all female employees whose first name is either Kellie or Aruna.
    */
    SELECT 
    *
FROM
    employees
WHERE
    gender = 'F'
        AND (first_name = 'Kellie'
        OR first_name = 'Aruna');
        
/* 
[5]  IN , NOT IN  operator :  Allows SQL to return the names written in parentheses if they exist in our table.
*/ 

SELECT * FROM employees WHERE first_name IN ('Cathie' , 'Mark' , 'Nathon');
SELECT * FROM employees WHERE first_name NOT IN ('Cathie' , 'Mark' , 'Nathon');

/* 
Use the IN operator to select all individuals from the “employees” table, whose first name is either “Denis”, or “Elvis”.
Extract all records from the ‘employees’ table, aside from those with employees named John, Mark, or Jacob.
*/

SELECT * FROM employees WHERE first_name IN ('Denis' , 'Elvis');
SELECT * FROM employees WHERE first_name NOT IN ('JOHN' , 'MARK' , 'JACOB');

/* 
[6] LIKE NOT LIKE operator : Implemented technique is called pattern matching . to find or fetch any pattern from the data we use this operator. 
*/

SELECT * FROM employees WHERE first_name LIKE ( 'MAR%'); -- FOR all the string starting with mar
SELECT * FROM employees WHERE first_name LIKE ( '%MAR'); -- For all the string ending with mar.
SELECT * FROM employees WHERE first_name LIKE ( '%MAR%'); -- FOR all the string which have mar in somewhere middle in the word.

SELECT * FROM employees WHERE first_name LIKE ( 'MAR_'); -- HERE _ IS FOR THE SINGLE CHARACTER IT WILL FETCH THE DATA WHICH HAVE SINGLE CHARACTER AFTER MAR IN THE TABLE.
SELECT * FROM employees WHERE first_name LIKE ( '_MAR');
SELECT * FROM employees WHERE first_name LIKE ( '_MAR_');

-- FOR NOT LIKE IT WILL BE OPPOSITE OF LIKE OPERATOR:

SELECT * FROM employees WHERE first_name NOT LIKE ( 'MAR%'); -- FOR all the string starting with mar
SELECT * FROM employees WHERE first_name NOT LIKE ( '%MAR'); -- For all the string ending with mar.
SELECT * FROM employees WHERE first_name NOT LIKE ( '%MAR%'); -- FOR all the string which have mar in somewhere middle in the word.

/* 
Working with the “employees” table, use the LIKE operator to select the data about all individuals,
 whose first name starts with “Mark”; specify that the name can be succeeded by any sequence of characters.

Retrieve a list with all employees who have been hired in the year 2000.

Retrieve a list with all employees whose employee number is written with 5 characters, and starts with “1000”. 
*/

SELECT * FROM employees WHERE first_name LIKE ( 'MARK%');
SELECT * FROM employees WHERE hire_date LIKE ('%2000%');
SELECT * FROM employees WHERE emp_no LIKE ('1000_');

/* 
Extract all individuals from the ‘employees’ table whose first name contains “Jack”.

Once you have done that, extract another list containing the names of employees that do not contain “Jack”.
*/

SELECT * FROM employees WHERE first_name LIKE ('%JACK%') ;
SELECT * FROM employees WHERE first_name NOT LIKE ('%JAKE%');

/* 
[7] 
BETWEEN...AND & NOT BETWEEN .... AND Operator : helps ud designate the interval to which a given value belongs. 
in not between....and operator it will fetch the value which is not in the interval laso it will not include the value which is mentioned in the interval .

*/

SELECT * FROM employees WHERE hire_date between '1990-01-01' AND '2000-01-01';
SELECT * FROM employees WHERE hire_date NOT between '1990-01-01' AND '2000-01-01';

/* 
Select all the information from the “salaries” table regarding contracts from 66,000 to 70,000 dollars per year.

Retrieve a list with all individuals whose employee number is not between ‘10004’ and ‘10012’.

Select the names of all departments with numbers between ‘d003’ and ‘d006’.
*/

SELECT * FROM salaries WHERE  salary between '66000' AND '70000';
SELECT * FROM employees WHERE emp_no between '10004' and '10012';
SELECT dept_name FROM departments WHERE dept_no between  'd003' and 'd006';

/* 
[8] 
IS NOT NULL / IS NULL Operator : used to extract values that are not null or null.

syntaxt:

SELECT column_1 , column_2 ........ cloumn_n
FROM table_name
WHERE column_name IS NOT NULL / IS NULL ;

*/

SELECT * FROM employees WHERE first_name IS NULL;     -- WILL GIVE ALL THE VALUES OF RECORD WHERE THE  FIRST NAME IS NULL
SELECT * FROM employees WHERE first_name IS NOT NULL;  -- WILL GIVE THE VALUES OF RECORD WHERE THE FIRST NAME IS NOT NULL

-- Select the names of all departments whose department number value is not null.

SELECT dept_name FROM departments WHERE dept_no IS NOT NULL;

/*
Execution of comparision operators : 1] WHERE first_name = 'MIKE'
2] WHERE first_name != 'Mike'
3] WHERE hire_date >= '2000-01-01'
4] WHERE hire_date <= '2000-01-01'

Retrieve a list with data about all female employees who were hired in the year 2000 or after.

Hint: If you solve the task correctly, SQL should return 7 rows.

Extract a list with all employees’ salaries higher than $150,000 per annum.
 */
 SELECT * FROM employees WHERE hire_date >= '2000-01-01' AND gender = 'F';
 SELECT * FROM salaries WHERE  salary > 150000 ;
 
 /* 
[9] SELECT DISTINCT : STATEMENT WILL SHOW ONLY DISTINCT DATA VALUES 
 
 SYNTAXT : 
 SELECT DISTINCT column_1 , column_2 ........ column_n
 FROM table_name;
 */
 
 SELECT DISTINCT gender FROM employees; 
 
 /*
 Obtain a list with all different “hire dates” from the “employees” table.

Expand this list and click on “Limit to 1000 rows”. This way you will set the limit of output rows displayed back to the default of 1000.

In the next lecture, we will show you how to manipulate the limit rows count. 
 */ 
 
 SELECT hire_date FROM employees ;
 
 /* 
 [10] Aggregate Function : applied on multiple rows of a single column of a table and returns an output of a single value.
 
 (i) COUNT () : Counts the number of non null records in the field . we can use reserved word DISTINCT to get no of distinct value in the field.
 syntax:
 
 SELECT COUNT(column_name) FROM table_name;
 */
 
 SELECT COUNT(emp_no) FROM employees;              -- To get total number of employees value in emp_no which is not null.
 SELECT COUNT(first_name) FROM employees;
 SELECT COUNT(DISTINCT first_name) FROM employees; -- To get how many distinct first_name is there in the field first_name from table employees
 
 /* 
 How many annual contracts with a value higher than or equal to $100,000 have been registered in the salaries table?

How many managers do we have in the “employees” database? Use the star symbol (*) in your code to solve this exercise.
 */
 
 SELECT COUNT(salary) FROM salaries;
 SELECT COUNT(salary) FROM salaries WHERE salary > 100000;
 SELECT COUNT(*) FROM dept_manager;
 
/* 
[11]
ORDER BY CLAUSE : to fetch the value in ascending or descending order .
syntax : 

SELECT * FROM table_name ORDER BY column_name ASC/DSC;      ASC : ASCENDING ORDER , DESC : DESCENDING ORDER 
*/ 

SELECT * FROM employees ORDER BY first_name ASC;
SELECT * FROM employees ORDER BY emp_no DESC;
SELECT * FROM employees ORDER BY first_name , last_name ASC;

/* 
Select all data from the “employees” table, ordering it by “hire date” in descending order.
*/
SELECT * FROM employees ORDER BY hire_date DESC;

/* 
[12]
GROUP BY CLAUSE : Results can be grouped ACCOERDING to a specific field or fields.Whenever there is an aggregate function then we  should add group clause.
syntax:

SELECT column_name
FROM table_name              -- ALWAYS REMEMBER THE ORDER OF THIS SYNTAX
WHERE condition
GROUP BY column_name
ORDER BY column_name;
 
*/

SELECT 
    first_name, COUNT(first_name)
FROM
    employees
GROUP BY first_name            -- by this only distinct value of first name will be selected.it's essential as whenever we havee an aggregate function we have to use it 
ORDER BY first_name ASC;

-- ALIAS NAME : USED TO RENAME A SECTION FROM  YOUR QUERY .

SELECT 
    first_name, COUNT(first_name) as names_count   -- using as we can change the name of the column in output from count(first_name) to names_count.
FROM
    employees
GROUP BY first_name           
ORDER BY first_name ASC;

/*                      VERY GOOD QUESTION 
Write a query that obtains two columns. The first column must contain annual salaries higher than 80,000 dollars. 
The second column, renamed to “emps_with_same_salary”, must show the number of employees contracted to that salary.
 Lastly, sort the output by the first column.
*/

SELECT 
    salary, COUNT(emp_no) AS emps_with_same_salary
FROM
    salaries
WHERE
    salary > 80000
GROUP BY salary 
ORDER BY salary  ASC;

/* 
[13]
HAVING CLAUSE : Refines the output from records that do not stisfy a certain condition : it's frequently used with GROUP BY . 
AFTER HAVING you can have a condition with the AGGREGATE FINCTION while WHERE cannot use aggregate functions within it's conditions.

syntax:

SELECT column_name
FROM table_name
WHERE conditions
GROUP BY column_name
HAVING conditions
ORDER BY column_name;

*/

SELECT 
    first_name, COUNT(first_name) AS name_count
FROM
    employees
GROUP BY first_name
HAVING COUNT(first_name) > 250  -- When we have to put condition on an aggregate function then we will use having .
ORDER BY first_name;

/*                            VERY GOOOD 

Select all employees whose average salary is higher than $120,000 per annum.
Hint: You should obtain 101 records.
Compare the output you obtained with the output of the following two queries:

SELECT
    *, AVG(salary)
FROM
    salaries
WHERE
    salary > 120000
GROUP BY emp_no
ORDER BY emp_no;
SELECT
    *, AVG(salary)
FROM
    salaries
GROUP BY emp_no
HAVING AVG(salary) > 120000;
*/

SELECT 
    emp_no, AVG(salary)
FROM
    salaries
GROUP BY emp_no
HAVING AVG(salary) > 120000
ORDER BY emp_no;        

SELECT first_name , COUNT(first_name) as names_count
FROM employees
WHERE hire_date > '1999-01-01'
GROUP BY first_name
HAVING COUNT(first_name) < 200
ORDER BY first_name;

/* 
Select the employee numbers of all individuals who have signed more than 1 contract after the 1st of January 2000.

Hint: To solve this exercise, use the “dept_emp” table.
*/
SELECT emp_no , COUNT(from_date)
FROM dept_emp
WHERE from_date > '2000-01-01'
GROUP BY emp_no
HAVING count(from_date) > 1
ORDER BY emp_no;

/* 
[14]
LIMIT CLAUSE
SYNTAX: 

SELECT column_name(s)
FROM table_name
WHERE conditions
GROUP BY column_name(s)
HAVING conditions
ORDER BY column_name(s)
LIMIT number;

*/

SELECT * FROM salaries ORDER BY salary DESC LIMIT 10;
SELECT * FROM salaries ORDER BY emp_no DESC LIMIT 10;

-- Select the first 100 rows from the ‘dept_emp’ table. 

SELECT * FROM dept_emp LIMIT 100;

/* 
[15] INSERT INTO STATEMENT 

Syntax : INSERT INTO table_name ( column_1 , cloumn_2 ..... column_n)
		VALUE (valur_1 , value_2 ........ value_n);
 WE MUST PUT THE VALUES IN THE EXACT  ORDER WE HAVE LISTED THE COLUMN NAMES.     
*/

INSERT INTO employees
(
emp_no,
birth_date,
first_name,
last_name,
gender,
hire_date
) VALUES
(
999999,
'2003-04-15',
'PARSHWA',
'GANDHI',
'M',
'2003-04-15'
);

SELECT * FROM employees ORDER BY emp_no DESC LIMIT 10; -- T o check that inserted value is there in table or not.

INSERT INTO employees
VALUES
(
    999903,
    '1977-09-14',
    'Johnathan',
    'Creek',
    'M',
    '1999-01-01'
);

/* 
Select ten records from the “titles” table to get a better idea about its content.

Then, in the same table, insert information about employee number 999903. State that he/she is a “Senior Engineer”, who has started working in this position on October 1st, 1997.

At the end, sort the records from the “titles” table in descending order to check if you have successfully inserted the new record.
*/

SELECT * FROM titles LIMIT 10 ;
INSERT INTO titles
(
emp_no,
title,
from_date
)VALUES
(
999903,
'Senior Engineer',
'1997-10-01'
);

SELECT * FROM titles ORDER BY emp_no DESC LIMIT 10;

/* 
Insert information about the individual with employee number 999903 into the “dept_emp” table.
 He/She is working for department number 5, and has started work on  October 1st, 1997; her/his contract is for an indefinite period of time.

Hint: Use the date ‘9999-01-01’ to designate the contract is for an indefinite period.
*/

INSERT INTO dept_emp
(
emp_no,
dept_no,
from_date,
to_date
)VALUES
(
999903,
'd005',
'1997-10-01',
'9999-01-01'
);

/* INSERT INTO STATEMENT:
SYNTAX:

INSERT INTO table_name(column_1 , column_2 ........... column_n)
SELECT column_1 , column_2 .........column_n
WHERE condition;

*/

CREATE  TABLE departments_dup 
(
	dept_no CHAR(4) NOT NULL,
    dept_name VARCHAR(40) NOT NULL
    );
    
SELECT * FROM  departments_dup;

INSERT INTO departments_dup
(
dept_no,
dept_name
)SELECT * FROM departments;

select * from departments_dup ORDER BY dept_no; 
-- using INSERT INTO SELECT STATEMENT WE CAN COPY CONTENT OF ONE TABLE AND INSERT IT IN ANOTHER TABLE WITH OR WITHOUT ANY CONDITION.   

/* 
Create a new department called “Business Analysis”. Register it under number ‘d010’.

Hint: To solve this exercise, use the “departments” table.
*/
INSERT INTO departments
(
dept_no,
dept_name
)VALUES
(
'd010',
'Business Analysis'
);

SELECT * FROM departments ORDER BY dept_no ;


/* 
UPDATE STATEMENT : used to update the value of existing records in a table .
Syntax:

UPDATE table_name
SET column_1 = value_1 , column_2 = value_2 , column_3 = value_3 .....
WHERE conditions;
*/

USE employees;

SELECT * FROM employees WHERE emp_no = 999901;

UPDATE employees
SET 
emp_no = 999901,
birth_date = '1990-12-31',
first_name = 'Stella',
last_name = 'Parkinson',
gender = 'F' 
WHERE emp_no = 999999;

USE employees;

/*
COMMIT AND ROLLBACK FUNCTION : 
 */
 
 SELECT * FROM departments_dup ORDER BY dept_no;
 
 COMMIT;
 
UPDATE departments_dup
SET 
dept_no = 'd011',
dept_name = 'Quality Control'; 

ROLLBACK;   -- It will go to the previous commit statement state.

COMMIT;

-- Change the “Business Analysis” department name to “Data Analysis”.
-- Hint: To solve this exercise, use the “departments” table.

 SELECT * FROM departments ORDER BY dept_no;
 
 UPDATE departments
 SET dept_name = 'DATA ANALYSIS'
 WHERE dept_no = 'd010';
 
 /* 
 DELETE STATEMENT : Removes records from a database
 syntax :
 
 DELETE FROM table_name
 WHERE conditions;
 
 */

COMMIT;

SELECT * FROM employees WHERE emp_no = 999903;
SELECT * FROM titles WHERE emp_no = 999903;

DELETE FROM employees
WHERE emp_no = 999903;

ROLLBACK;

COMMIT;
 
-- Remove the department number 10 record from the “departments” table.

SELECT * FROM departments ORDER BY dept_no;

DELETE FROM departments
WHERE dept_no = 'd010';

ROLLBACK;

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



