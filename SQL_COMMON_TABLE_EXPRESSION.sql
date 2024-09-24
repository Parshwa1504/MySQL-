use employees;

/*
MYSQL COMMON TABLE EXPRESSIONS : IN SQL EVERY QUERY AND SOMETIMES PART OF A QUERY OR SUBQUERY PRODUCE A RESULT OF A TEMPORARY DATABASE.
A COMMON TABLE EXPRESSION IS A TOOL FOR OBTAINING SUCH TEMPORARY RESULT SETS THAT EXIST WITHIN THE EXECUSION OF A GIVEN QUERY. 

SYNTAX : 

WITH cte_name AS  ( SELECT ......... FROM .......)
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

-- WE CAN ALSO USE COUNT() FUNCTION IN PLACE OF SUM() FUNCTION TO GET THE NO_OF_FEMALE_salaries_above_avg :

WITH cte AS (SELECT AVG(s.salary) AS avg_salary FROM salaries s)
SELECT 
SUM(CASE WHEN s.salary > c.avg_salary THEN 1 ELSE 0 END) AS no_of_female_salaries_above_avg_with_SUM ,
COUNT(CASE WHEN s.salary > c.avg_salary THEN s.salary ELSE NULL END) AS no_of_female_salaries_above_avg_with_COUNT,
COUNT(s.salary) AS total_no_of_salary 
FROM 
salaries s 
JOIN employees e ON s.emp_no = e.emp_no 
AND e.gender = 'F'
CROSS JOIN
cte c;

-- SO AS WE CAN SEE ABOVE CTE CAN BE REUSED MULTIPLE TIMES WITHIN A MYSQL STATEMENT .

/*
Use a CTE (a Common Table Expression) and a SUM() function in the SELECT statement in a query to find out
 how many male employees have never signed a contract with a salary value higher than or equal to the all-time company salary average.
*/

WITH cte_male AS ( SELECT AVG(s.salary) AS avg_salary FROM salaries s )
SELECT 
SUM(CASE WHEN s.salary < cm.avg_salary THEN 1 ELSE 0 END) AS no_of_male_salaries_below_avg_with_SUM ,
COUNT(s.salary) AS no_of_male_salaries
FROM
salaries s JOIN employees e on s.emp_no = e.emp_no 
AND e.gender = 'M'
CROSS JOIN
cte_male cm;

/*
Use a CTE (a Common Table Expression) and (at least one) COUNT() function in the SELECT statement of a query to find out
 how many male employees have never signed a contract with a salary value higher than or equal to the all-time company salary average.
*/

WITH cte_male AS ( SELECT AVG(s.salary) AS avg_salary FROM salaries s )
SELECT 
COUNT(CASE WHEN s.salary < cm.avg_salary THEN s.salary ELSE NULL END) AS no_of_male_salaries_below_avg_with_COUNT ,
COUNT(s.salary) AS no_of_male_salaries
FROM
salaries s JOIN employees e on s.emp_no = e.emp_no 
AND e.gender = 'M'
CROSS JOIN
cte_male cm;

/*
Use MySQL joins (and don’t use a Common Table Expression) in a query to find out
how many male employees have never signed a contract with a salary value higher than or equal to the all-time company salary average
 (i.e. to obtain the same result as in the previous exercise).
*/

SELECT 
COUNT(CASE WHEN s.salary < cm.avg_salary THEN s.salary ELSE NULL END) AS no_of_male_salaries_below_avg_with_COUNT ,
COUNT(s.salary) AS no_of_male_salaries
FROM
salaries s JOIN employees e on s.emp_no = e.emp_no 
AND e.gender = 'M'
JOIN
( SELECT AVG(s.salary) AS avg_salary FROM salaries s ) cm;

/*
Use a cross join in a query to find out how many male employees have never signed a contract
 with a salary value higher than or equal to the all-time company salary average (i.e. to obtain the same result as in the previous exercise).
*/

SELECT 
COUNT(CASE WHEN s.salary < cm.avg_salary THEN s.salary ELSE NULL END) AS no_of_male_salaries_below_avg_with_COUNT ,
COUNT(s.salary) AS no_of_male_salaries
FROM
salaries s JOIN employees e on s.emp_no = e.emp_no 
AND e.gender = 'M'
CROSS JOIN
( SELECT AVG(s.salary) AS avg_salary FROM salaries s ) cm;

/*
USING MULTIPLE SUBCLAUSE IN A WITH CLAUSE : COMMON TABLE EXPRESSIONS CAN HAVE MULTIPLE SUBCLAUSES .
WE CAN NOT HAVE MULTIPLE WITH CLASUSE WITHIN THE SAME MYSQL QUERY . WE CAN USE NUMEROUS SUBCLAUSES .

SYNTAX: 

WITH cte_name_1  AS ( SELECT ......... FROM .......) ,
cte_name_2 AS (SELECT .......... FROM .............)
SELECT
...........
FROM 
..........
cte_name_1 c1 
JOIN
cte_name_2 c2 ;
*/

-- HOW MANY FEMALE EMPLOYEES HIGHEST CONTRACT SALARY VALUES WERE HIGHER THAN ALL TIME COMPANY SALARY AVERAGE ACROSS ALL GENDERS 
-- NOTE : THE HIGHEST SALARY VALUE OF AN EMPLOYEE MAY NOT HAVE BERN HIGHER THAN THE ALL TIME COMPANY AVERAGE SO WE WILL ONLY BE INTERESTED IN THE REST OF THE CASES OF OUR TASK.
-- SUBCLAUSE 1 : A CTE COMPUTING THE ALL TIME AVERAGE 
-- SUBCLAUSE 2 : A CTE TO OBTAIN A LIST CONTAINING THE HIGHEST CONTRACT SALARY VALUES OF ALL FEMALE EMPLOYEES.

-- FIRST WE WILL WRITE THE CODE WHICH WE WILL ADD IN THE TWO SUBCLAUSE :

SELECT AVG(s.salary) AS avg_salary FROM salaries s;

SELECT 
    s.emp_no, MAX(s.salary) AS Max_salary
FROM
    salaries s
GROUP BY s.emp_no;

-- NOW WE WILL ADD ABOVE TWO CODES IN TWO SUBCLAUSE : 

WITH cte1 AS (SELECT AVG(salary) AS avg_salary FROM salaries ), 
cte2 AS 
(SELECT
 s.emp_no , MAX(s.salary) AS Max_salary FROM salaries s 
 JOIN employees e ON s.emp_no = e.emp_no 
 AND e.gender = 'F'
 GROUP BY s.emp_no
)
SELECT 
SUM(CASE WHEN c2.Max_salary > c1.avg_salary THEN 1 ELSE 0 END) AS no_of_female_max_salary_contracts_above_avg_salary,
COUNT(e.emp_no) AS Total_no_of_female_salary_contracts
FROM employees e
JOIN 
cte2 c2 ON c2.emp_no = e.emp_no
CROSS JOIN
cte1 c1;

/*
HOW MANY FEMALE EMPLOYEES HIGHEST CONTRACT SALARY VALUES WERE HIGHER THAN THE ALL TIME COMPANY SALARY AVERAGE ( ACROSS ALL GENDERS ) 
IN ABOVE CODE WE GOT THIS OUTPUT USING SUM() FUNCTION BUT WE CAN ALSO GET THIS USING COUNT() FUNCTION HERE IS THE CODE BELOW: 
*/

WITH cte1 AS (SELECT AVG(salary) AS avg_salary FROM salaries ), 
cte2 AS 
(SELECT
 s.emp_no , MAX(s.salary) AS Max_salary FROM salaries s 
 JOIN employees e ON s.emp_no = e.emp_no 
 AND e.gender = 'F'
 GROUP BY s.emp_no
)
SELECT 
COUNT(CASE WHEN c2.Max_salary > c1.avg_salary THEN c2.Max_salary ELSE NULL END) AS no_of_female_max_salary_contracts_above_avg_salary_with_count,
COUNT(e.emp_no) AS Total_no_of_female_salary_contracts
FROM employees e
JOIN 
cte2 c2 ON c2.emp_no = e.emp_no
CROSS JOIN
cte1 c1;

-- WE CAN TRY TO OBTAIN RELEVANT PERCENTAGE VALUE FOR THE ABOVE CODE AND ALSO WE CAN DISPLAY IT BETTER USING ROUND() FUNCTION WE CAN ADD ANY STRING TO A VLAUE BY CONCAT() FUNCTION  :

WITH cte1 AS (SELECT AVG(salary) AS avg_salary FROM salaries ), 
cte2 AS 
(SELECT
 s.emp_no , MAX(s.salary) AS Max_salary FROM salaries s 
 JOIN employees e ON s.emp_no = e.emp_no 
 AND e.gender = 'F'
 GROUP BY s.emp_no
)
SELECT 
COUNT(CASE WHEN c2.Max_salary > c1.avg_salary THEN c2.Max_salary ELSE NULL END) AS no_of_female_max_salary_contracts_above_avg_salary_with_count,
COUNT(e.emp_no) AS Total_no_of_female_salary_contracts,
CONCAT(ROUND((COUNT(CASE WHEN c2.Max_salary > c1.avg_salary THEN c2.Max_salary ELSE NULL END) /(COUNT(e.emp_no)) )*100 , 2) , '%') AS '% percentage'
FROM employees e
JOIN 
cte2 c2 ON c2.emp_no = e.emp_no
CROSS JOIN
cte1 c1;

/*
Use two common table expressions and a SUM() function in the SELECT statement of a query to obtain the number of male employees
 whose highest salaries have been below the all-time average.
*/

WITH cte_1 AS (	 SELECT AVG(s.salary) AS avg_salary FROM salaries s) ,
 cte_2 AS
 (SELECT s.emp_no , MAX(s.salary) AS max_salary FROM salaries s JOIN employees e ON s.emp_no = e.emp_no AND e.gender = 'M' GROUP BY s.emp_no)
 SELECT 
 SUM(CASE WHEN c2.max_salary < c1.avg_salary THEN 1 ELSE 0 END),
 COUNT(e.emp_no)
 FROM employees e
 JOIN cte_2 c2 ON e.emp_no = c2.emp_no 
 CROSS JOIN
 cte_1 c1 ;

/*
Use two common table expressions and a COUNT() function in the SELECT statement of a query to obtain the number of male employees
 whose highest salaries have been below the all-time average.
*/

WITH cte_1 AS (	 SELECT AVG(s.salary) AS avg_salary FROM salaries s) ,
 cte_2 AS
 (SELECT s.emp_no , MAX(s.salary) AS max_salary FROM salaries s JOIN employees e ON s.emp_no = e.emp_no AND e.gender = 'M' GROUP BY s.emp_no)
 SELECT 
 COUNT(CASE WHEN c2.max_salary < c1.avg_salary THEN c2.max_salary ELSE NULL END),
 COUNT(e.emp_no)
 FROM employees e
 JOIN cte_2 c2 ON e.emp_no = c2.emp_no 
 CROSS JOIN
 cte_1 c1 ;
 
 /*
 Does the result from the previous exercise change
 if you used the Common Table Expression (CTE) for the male employees' highest salaries in a FROM clause, as opposed to in a join?
 
 ANS : NO THE RESULT DOES NOT CHANGE AS WE CAN DIRECTLY USE FROM RATHER THAN USING EMPLOYEES TABLE TO JOIN C2 BUT FOR THE GOOD PRACTICE WE SHOULD ALWAYS JOIN 
 CTE WITH DIFFERENT TABLES IN THE DATABASE  
 */
 
 /*
 REFERRING TO COMMON TABLE EXPRESSION IN A WITH CLAUSE : WE CAN USE MULTIPLE CTES IN A QUERY REFERENCING THEM NUMEROUS TIME .
 WE CAN REFER TO A CTE DEFINED EARLIER WITHIN A WITH CLAUSE . WE CAN NOT REFER TO A ONE THAT HAS BEEN DEFINED AFTER .
 */

-- task : RETRIEVE THE HIGHEST CONTRACT SALARY VALUES OF ALL EMPLOYEES HIRED IN 2000 OR LATER : 

 WITH cte_1 AS (SELECT * FROM employees e WHERE e.hire_date >= '2000-01-01'),
 cte_2 AS (
SELECT c1.emp_no , MAX(s.salary) AS max_salary FROM salaries s JOIN cte_1 c1 ON s.emp_no = c1.emp_no GROUP BY s.emp_no ) -- WE HAVE JOINED C1 AND SALARIES TABLE IN THIS STEP
SELECT * FROM cte_2 c2;

-- THE SECOND CTE IN A QUERY CAN REFERENCE THE FIRST ONR BUT THIS IS NOT TRUE VICA VERSA.

/*
Considering the salary contracts signed by female employees in the company, how many have been signed for a value below the average? 
Store the output in a column named no_f_salaries_below_avg. 
In a second column named total_no_of_salary_contracts, provide the total number of contracts signed by all employees in the company.
Use the salary column from the salaries table and the gender column from the employees table. Match the two tables on the employee number column (emp_no).
*/


WITH cte AS (
    SELECT AVG(salary) AS avg_salary FROM salaries
),
cte2 AS (
    SELECT COUNT(salary) AS total_no_of_salary_contracts FROM salaries
)
SELECT
    SUM(CASE WHEN s.salary < c.avg_salary THEN 1 ELSE 0 END) AS no_f_salaries_below_avg,
    (SELECT total_no_of_salary_contracts FROM cte2) AS total_no_of_salary_contracts
FROM salaries s
JOIN employees e ON s.emp_no = e.emp_no AND e.gender = 'F'
JOIN cte c;

