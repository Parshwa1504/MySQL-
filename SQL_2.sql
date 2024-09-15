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




  



 

