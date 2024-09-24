use employees;

/*
MYSQL COMMON TABLE EXPRESSIONS : IN SQL EVERY QUERY AND SOMETIMES PART OF A QUERY OR SUBQUERY PRODUCE A RESULT OF A TEMPORARY DATABASE.
A COMMON TABLE EXPRESSION IS A TOOL FOR OBTAINING SUCH TEMPORARY RESULT SETS THAT EXIST WITHIN THE EXECUSION OF A GIVEN QUERY. 

SYNTAX : 

WITH cte_name ( SELECT ......... FROM .......)
SELECT
...........
FROM 
..........
cte_name ;

*/

-- HOW MANY SALARY CONTRACTS SIGNED BY FEMALE EMPLOYEES HAVE BEEN VALUES ABOVE THE ALL TIME AVERAGE CONTRACT SALARY VALUE OF THE COMPANY
-- WE NEED TWO KIND OF DATASETS 1] A LIST OF ALL CONTRACTS SIGNED BY FEMALE EMPLOYEES FROM THE COMPANY'S HISTORY
-- 2] A SINGLE ALL TIME AVERAGE SALARY VALUE. 
-- WITH THE USE CTE WE CAN USE A SINGLE QUERY TO MAKE THE REQUIRED COMPARISION BETWEEN EACH RELEVANT CONTRACT SALARY VALUE AND THE ALL TIME AVERAGE.

-- NOW WE WILL UNDERSTAND HOW CTE WORKS DOING THE ABOVE EXERCISE : 

-- FIRST WE NEED TO FIND ALL TIME AVERAGE SALARY:

SELECT AVG(s.salary) AS avg_salary FROM salaries s ;

-- NOW WE WILL CONVERT IT INTO CTE :   WITH cte AS (SELECT AVG(s.salary) AS avg_salary FROM salaries s)

-- JOINING CTE TO THE SALARIES TABLE : 
 
 WITH cte AS (SELECT AVG(s.salary) AS avg_salary FROM salaries s)
 SELECT * FROM salaries s 
 JOIN cte c;
 
 -- AS WE NEED DATA FOR ONLY FEMALE EMPLOYEES SO WE WILL ADD THE ABOVE QUERY WITH EMPLOYEES TABLE AND FETCH THE DATA ONLY FOR FEMALE EMPLOYEES : 
 
  WITH cte AS (SELECT AVG(s.salary) AS avg_salary FROM salaries s)
 SELECT * FROM salaries s JOIN employees e ON s.emp_no = e.emp_no 
 AND  
 e.gender = 'F'
 JOIN cte c;
 
 -- NOW WE HAVE TO USE CROSS JOIN FOR CTE AS The CROSS JOIN is correct in this case because 
 -- it allows the single avg_salary value to be accessible for comparison across all rows in the salaries table.
 -- An INNER JOIN requires matching conditions between tables, which doesn't apply here.
 
WITH cte AS (SELECT AVG(s.salary) AS avg_salary FROM salaries s)
 SELECT * FROM salaries s JOIN employees e ON s.emp_no = e.emp_no 
 AND  
 e.gender = 'F'
 CROSS JOIN cte c;

-- HERE WE NEED TO DISPLAY THE DATA THAT HAVE FEMALE EMPLOYEES HAVE BEEN VALUES ABOVE THE ALL TIME AVERAGE CONTRACT SALARY VALUE OF THE COMPANY SO WE WILL USE SUM FUNCTION AND 
-- IN SUM FUNCTION WE WILL USE CASE STATEMENT ( same as if and else statement ) if salary is less than avg salary then it will sum +1 or else it will add +0 .
-- also we will display total no of salaries of female employees using count function .  

WITH cte AS (SELECT AVG(s.salary) AS avg_salary FROM salaries s)
SELECT 
SUM(CASE WHEN s.salary > c.avg_salary THEN 1 ELSE 0 END) AS no_of_female_salaries_above_avg ,
COUNT(s.salary) AS total_no_of_salary 
FROM 
salaries s 
JOIN employees e ON s.emp_no = e.emp_no 
AND e.gender = 'F'
CROSS JOIN
cte c;

