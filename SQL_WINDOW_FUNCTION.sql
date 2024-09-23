/*
WINDOW FUNCTION : 
IT'S AN ADVANCED SQL TOOL PERFORMING A CALCULATION FOR EVERY RECORD IN THE DATASET USING OTHER RECORDS ASSOCIATED WITH THE SPECIFIED ONE FRON THE TABLE.
USING WINDOE FUNCTION IS SIMILLAR YET NOT IDENTICAL TO USING AGGREGATE FUNCTION.
THERE ARE TWO TYPES OF WINDOW FINCTION : 1] AGGREGATE WINDOW FUNCTION 
										 2] NONAGGREGATE WINDOE FUNCTION : I) RANKING WINDOW FUNCTION
																		   II) VALUE WINDOW FUNCTION			
SYNTAX  OF ROW_NUMBER() RANKING WINDOE FINCTION : 

SELECT 
.............. ,
ROW_NUMBER() OVER() AS......
FROM
.......... ;

WINDOW FUNCTION OVER CLAUSE : 
1] IF IN OVER CLAUSE NONE = EMPTY OVER CLAUSE THEN ROW_NUMBER() WILL PERFORM THE RELAVENT EVALUATIONS ON EVERY QUERY ROW .
2 ] IF IN OVER CLAUSE CONTAIN PARTITION BY THEN DATA WILL BE ORGANIZED INTO GROUPS/ PARTITION . OVER(PARTITION BY COLUMN_NAME) 
3]  IF IN OVER CLAUSE IF WE WANT TO GROUP IN A SPECIFIC ORDER THEEN WE WILL USE ORDER BY CLAUSE WITH PARTITION BY IN ROW_NUMBER CLAUSE SO IT WILL BE LIKE 
ROW_NUMBER(PARTITION BY ORDER BY COLUMN_NAME ASC/DESC)
4] IF YN OVER CLAUSE THERE IS ONLY ORDER BY CLAUSE IN IT THEN IT WILL ONLY ARRANGE THE VALUE ASC OR DESC ORDER.

*/

USE employees;

SELECT
 emp_no ,
 salary , 
 row_number() OVER() AS Ranking
 FROM salaries;

SELECT
 emp_no ,
 salary , 
 row_number() OVER(PARTITION BY emp_no) AS Ranking
 FROM salaries;
 
 SELECT
 emp_no ,
 salary , 
 row_number() OVER(partition by emp_no order by salary asc) AS Ranking
 FROM salaries;
 
 SELECT
 emp_no ,
 salary , 
 row_number() OVER(ORDER BY salary desc) AS Ranking
 FROM salaries;
 
 /* 
 Write a query that upon execution, assigns a row number to all managers we have information for in the "employees" database (regardless of their department).
Let the numbering disregard the department the managers have worked in. Also, let it start from the value of 1.
 Assign that value to the manager with the lowest employee number.
*/

SELECT 
e.emp_no ,
 dm.dept_no ,
 row_number() OVER(ORDER BY emp_no) AS ranking
 FROM employees e 
 JOIN dept_manager dm ON e.emp_no = dm.emp_no;
 
 /*
 Write a query that upon execution, assigns a sequential number for each employee number registered in the "employees" table.
 Partition the data by the employee's first name and order it by their last name in ascending order (for each partition).
 */
 
 SELECT 
 e.emp_no,
 e.first_name ,
 e.last_name,
 row_number() OVER(PARTITION BY e.first_name ORDER BY e.last_name ASC) AS Ranking
 FROM employees e;
 
 /* NOTE FOR USING SEVERAL WINDOE FUNCTIONS : 
 
 */
 
 /* 
 Obtain a result set containing the salary values each manager has signed a contract for. To obtain the data, refer to the "employees" database.
Use window functions to add the following two columns to the final output:
- a column containing the row number of each row from the obtained dataset, starting from 1.
- a column containing the sequential row numbers associated to the rows for each manager, 
where their highest salary has been given a number equal to the number of rows in the given partition, and their lowest - the number 1.
Finally, while presenting the output, make sure that the data has been ordered by the values in the first of the row number columns,
 and then by the salary values for each partition in ascending order.
*/

SELECT 
e.emp_no ,
 s.salary ,
 ROW_NUMBER() OVER(order by emp_no) AS row_num ,
 ROW_NUMBER() OVER(partition by emp_no order by salary ) as Salary_ranking
 FROM employees e JOIN salaries s ON e.emp_no = s.emp_no 
 JOIN dept_manager dm ON s.emp_no = dm.emp_no ;
 
 /*
 Obtain a result set containing the salary values each manager has signed a contract for. To obtain the data, refer to the "employees" database.
Use window functions to add the following two columns to the final output:
- a column containing the row numbers associated to each manager, where their highest salary has been given a number equal to the number of rows in the given partition, 
and their lowest - the number 1.
- a column containing the row numbers associated to each manager, where their highest salary has been given the number of 1, 
and the lowest - a value equal to the number of rows in the given partition.
Let your output be ordered by the salary values associated to each manager in descending order.
Hint: Please note that you don't need to use an ORDER BY clause in your SELECT statement to retrieve the desired output.
*/

SELECT 
e.emp_no ,
 s.salary ,
 ROW_NUMBER() OVER(partition by emp_no order by salary ) as Salary_ranking ,
 ROW_NUMBER() OVER(partition by emp_no order by salary desc) AS row_num 
 FROM employees e JOIN salaries s ON e.emp_no = s.emp_no 
 JOIN dept_manager dm ON s.emp_no = dm.emp_no ;
 
 -- DIFFICULTY IN UNDERSTANDING HOW TO PUT CORRECT ORDER IN THE OUTPUT;
 
 /*
 WINDOW FUNCTION ALTERNATIVE SYNTAX : 
 
 SELECT ......... ,
 ROW_NUMBER() OVER name AS ... 
 FROM ........
 WINDOW name (PARTITION NAME X ORDER BY Y )
 ;
 
 IT'S USEFUL WHEN WE HAVE A QUERY EMPLOYING SEVERAL WINDOW FUNCTION
 ALSO WHEN WE NEED TO REFER THE SAME WINDOW SPECIFICATION MULTIPLE TIMES THROUGHT A QUERY. 
 
 */
 
 SELECT e.emp_no , e.first_name ,
 ROW_NUMBER() OVER W AS Ranking 
 FROM employees e 
 WINDOW W AS (ORDER BY e.emp_no);
 
 /*
 Write a query that provides row numbers for all workers from the "employees" table, 
 partitioning the data by their first names and ordering each partition by their employee number in ascending order.
NB! While writing the desired query, do *not* use an ORDER BY clause in the relevant SELECT statement.
 At the same time, do use a WINDOW clause to provide the required window specification.
*/

SELECT e.emp_no ,
e.first_name , 
row_number() OVER W AS row_num
FROM employees e 
WINDOW W AS (partition by e.first_name order by e.emp_no);

/* 
PARTITION BY V/S GROUP BY IN WINDOW FUNCTION : 
*/

SELECT a.emp_no , MAX(a.salary) as MAX_SALARY FROM (
SELECT e.emp_no , s.salary ,
ROW_NUMBER() OVER(PARTITION BY e.emp_no ORDER BY s.salary) AS row_num
FROM  employees e JOIN salaries s ON e.emp_no = s.emp_no 
) a
GROUP BY a.emp_no;

SELECT a.emp_no , a.salary as MAX_SALARY FROM (
SELECT e.emp_no , s.salary ,
ROW_NUMBER() OVER w AS row_num
FROM  employees e JOIN salaries s ON e.emp_no = s.emp_no 
WINDOW w AS (PARTITION BY e.emp_no ORDER BY s.salary DESC)
) a
WHERE a.row_num = 1;

-- here we use WINDOW FUNCTION BY PARTITION BY CLAUSE RATHER THAN GROUP BY CLAUSE BECAUSE
-- IF WE WANT TO GAIN MAXIMUM OR MINIMUM THEN WE CAN USE BOTH GROUP CLAUSE AND PARTITION BY CLAUSE BUT 
-- IF WE WANT TO HAVE SECOND MAX OR THIRD MAX THEN WE CAN NOT DO IT BY GROUP CLAUSE BUT WE CAN DO IT BY PARTITION CLAUSE USING WINDOW FUNCTION 
-- SO THAT'S WHY WE USE PARTITION BY CLAUSE RATHER THAN GROUP CLAUSE .

/*
Find out the lowest salary value each employee has ever signed a contract for.
 To obtain the desired output, use a subquery containing a window function, as well as a window specification introduced with the help of the WINDOW keyword.
Also, to obtain the desired result set, refer only to data from the “salaries” table.
*/


SELECT a.emp_no , MIN(a.salary) as MIN_SALARY FROM (
SELECT e.emp_no , s.salary ,
ROW_NUMBER() OVER w AS row_num
FROM  salaries s JOIN employees e ON e.emp_no = s.emp_no 
WINDOW w AS (PARTITION BY e.emp_no ORDER BY s.salary )
) a
GROUP BY a.emp_no;

/*
Again, find out the lowest salary value each employee has ever signed a contract for. 
Once again, to obtain the desired output, use a subquery containing a window function.
 This time, however, introduce the window specification in the field list of the given subquery.
To obtain the desired result set, refer only to data from the “salaries” table.
*/

SELECT a.emp_no , MIN(a.salary) as MIN_SALARY FROM (
SELECT e.emp_no , s.salary ,
ROW_NUMBER() OVER (PARTITION BY e.emp_no ORDER BY s.salary ) AS row_num
FROM  salaries s JOIN employees e ON e.emp_no = s.emp_no 
) a
GROUP BY a.emp_no ;

/*
Once again, find out the lowest salary value each employee has ever signed a contract for.
 This time, to obtain the desired output, avoid using a window function. Just use an aggregate function and a subquery. 
*/

SELECT a.emp_no , MIN(a.salary) as MIN_SALARY FROM (
SELECT e.emp_no , s.salary 
FROM  salaries s JOIN employees e ON e.emp_no = s.emp_no 
) a
GROUP BY a.emp_no ;

/*
Once more, find out the lowest salary value each employee has ever signed a contract for. 
To obtain the desired output, use a subquery containing a window function, as well as a window specification introduced with the help of the WINDOW keyword.
 Moreover, obtain the output without using a GROUP BY clause in the outer query.
*/

SELECT a.emp_no , a.salary as MIN_SALARY FROM (
SELECT e.emp_no , s.salary ,
ROW_NUMBER() OVER w AS row_num
FROM  salaries s JOIN employees e ON e.emp_no = s.emp_no 
WINDOW w AS (PARTITION BY e.emp_no ORDER BY s.salary )
) a
WHERE a.row_num = 1;

/*
Find out the second-lowest salary value each employee has ever signed a contract for. 
To obtain the desired output, use a subquery containing a window function, as well as a window specification introduced with the help of the WINDOW keyword.
 Moreover, obtain the desired result set without using a GROUP BY clause in the outer query.
*/

SELECT a.emp_no , a.salary as MIN_SALARY FROM (
SELECT e.emp_no , s.salary ,
ROW_NUMBER() OVER w AS row_num
FROM  salaries s JOIN employees e ON e.emp_no = s.emp_no 
WINDOW w AS (PARTITION BY e.emp_no ORDER BY s.salary )
) a
WHERE a.row_num = 2;

/* 
MYSQL RANK() AND DENSE_RANK() WINDOW FUNCTION :
*/

SELECT s.emp_no , s.salary ,
ROW_NUMBER() OVER w AS row_num 
FROM salaries s
WHERE s.emp_no = 11839 
WINDOW w AS (PARTITION BY s.emp_no ORDER BY s.salary desc);

/*
 IN ROW_NUMBER() if values are identicle still row_numbers() will give different rank to both the identicle value so to resolve that we use RANK() . 
 RANK() will give same rank to both identicle value for example if value in 3 and 4 is same then RANK() will give rank 3 to both 3 and 4 .
 AND THERE WILL BE NO CHANGE IN SYNTAX ALSO WE JUST HAVE TO REPLACE ROW_NUMBER() WITH RANK().
 */
 
 SELECT s.emp_no , s.salary ,
RANK() OVER w AS row_num 
FROM salaries s
WHERE s.emp_no = 11839 
WINDOW w AS (PARTITION BY s.emp_no ORDER BY s.salary desc);

/*
 IN RANK() if values are identicle still RANK() will give same rank to both the identicle value but after that if the  3 and 4 have same value then RANK() WILL
 GIVE SAME RANK TO BOTH OF THEM BUT FOR 5 IT WILL GIVE 5 TH RANK IT WILL NOT CHANGE IT TO 4 SO TO RESOLVE THIS WE USE "DENSE_RANK()".
 AND THERE WILL BE NO CHANGE IN SYNTAX ALSO WE JUST HAVE TO REPLACE ROW_NUMBER() WITH DENSE_RANK().
*/

 SELECT s.emp_no , s.salary ,
DENSE_RANK() OVER w AS row_num 
FROM salaries s
WHERE s.emp_no = 11839 
WINDOW w AS (PARTITION BY s.emp_no ORDER BY s.salary desc);

/*
Write a query containing a window function to obtain all salary values that employee number 10560 has ever signed a contract for.
Order and display the obtained salary values from highest to lowest.
*/

SELECT s.emp_no , s.salary,
ROW_NUMBER() OVER W AS row_num
FROM salaries s 
WHERE s.emp_no = 10560
WINDOW W AS (PARTITION BY s.emp_no ORDER BY s.salary DESC);

/*
Write a query that upon execution, displays the number of salary contracts that each manager has ever signed while working in the company.
*/

SELECT
    dm.emp_no, (COUNT(salary)) AS no_of_salary_contracts
FROM
    dept_manager dm
        JOIN
    salaries s ON dm.emp_no = s.emp_no
GROUP BY emp_no
ORDER BY emp_no;

/*
Write a query that upon execution retrieves a result set containing all salary values that employee 10560 has ever signed a contract for.
 Use a window function to rank all salary values from highest to lowest in a way that equal salary values
 bear the same rank and that gaps in the obtained ranks for subsequent rows are allowed.
*/

SELECT s.emp_no , s.salary,
RANK() OVER W AS row_num
FROM salaries s 
WHERE s.emp_no = 10560
WINDOW W AS (PARTITION BY s.emp_no ORDER BY s.salary DESC);

/*
Write a query that upon execution retrieves a result set containing all salary values that employee 10560 has ever signed a contract for.
 Use a window function to rank all salary values from highest to lowest in a way that equal salary values 
bear the same rank and that gaps in the obtained ranks for subsequent rows are not allowed.
*/

SELECT s.emp_no , s.salary,
DENSE_RANK() OVER W AS row_num
FROM salaries s 
WHERE s.emp_no = 10560
WINDOW W AS (PARTITION BY s.emp_no ORDER BY s.salary DESC);

/*
WORKING WITH MYSQL WINDOW FUNCTION AND JOINS TOGETHER : 

1] OBTAIN THE DATA ONLY ABOUT MANAGERS FROM THE EMPLOYEES TABLE
2] PARTITION THE RELAVENT DATA BY THE DEPARTMENT WHERE THE MANAGERS HAVE WORKED IN 
3] ARANGE THE PARTIOTION BY THE MANAGER SALARY CONTRACT VALUES IN DESC ORDER
4] RANK THE MANAGERS ACCORDING TO THEIR SALARIES IN CERTAIN DEPARTMENTS 
5] DISPALY THE START AND END DATES OF EACH SALARIES CONTRACT
6] DISPLAY THE FIRST AND LAST DATE IN WHIVH AN EMPLOYEE HAS BEEN A MANGER , DATA PROVIDED IN THE DEPT_MANAGER TABLE
*/

SELECT 
d.dept_no AS dept_no,
d.dept_name AS dept_name,
dm.emp_no AS emp_no,
RANK() OVER w AS department_salary_ranking,
s.salary AS salary,
s.from_date AS salary_from_date,
s.to_date AS salary_to_date,
dm.from_date AS dept_manager_from_date,
dm.to_date AS dept_manager_to_date 
FROM 
salaries s JOIN  dept_manager dm ON  s.emp_no = dm.emp_no
AND s.from_date BETWEEN dm.from_date AND dm.to_date            -- TO ENSURE THAT DATE OF THE SALARY CONTRACT SHOULD LIE BETWEEN 
AND s.to_date BETWEEN dm.from_date AND dm.to_date              -- FISRT AND LAST DATE IN WHICH GIVEN EMPLOYEE HAS BEEN MANAGER
JOIN departments d ON dm.dept_no = d.dept_no 
WINDOW w AS (PARTITION BY d.dept_no ORDER BY s.salary desc); 

/*
Write a query that ranks the salary values in descending order of all contracts signed by employees numbered between 10500 and 10600 inclusive. 
Let equal salary values for one and the same employee bear the same rank. Also, allow gaps in the ranks obtained for their subsequent rows.
Use a join on the “employees” and “salaries” tables to obtain the desired result.
*/

SELECT 
e.emp_no,
s.salary ,
RANK() OVER w AS employee_salary_ranking
FROM 
employees e JOIN salaries s ON e.emp_no = s.emp_no 
WHERE e.emp_no >= 10500 AND e.emp_no <= 10600
WINDOW w AS (PARTITION BY e.emp_no ORDER BY s.salary desc);

/*
Write a query that ranks the salary values in descending order of the following contracts from the "employees" database:
- contracts that have been signed by employees numbered between 10500 and 10600 inclusive.
- contracts that have been signed at least 4 full-years after the date when the given employee was hired in the company for the first time.
In addition, let equal salary values of a certain employee bear the same rank. Do not allow gaps in the ranks obtained for their subsequent rows.
Use a join on the “employees” and “salaries” tables to obtain the desired result.
*/

SELECT 
e.emp_no,
s.salary ,
DENSE_RANK() OVER w AS employee_salary_ranking ,
e.hire_date,
s.from_Date ,
YEAR(s.from_date) - YEAR(e.hire_date ) AS Years_from_start 
FROM 
employees e JOIN salaries s ON e.emp_no = s.emp_no 
WHERE e.emp_no >= 10500 AND e.emp_no <= 10600 AND YEAR(s.from_date) - YEAR(e.hire_date )  >= 5  
WINDOW w AS (PARTITION BY e.emp_no ORDER BY s.salary desc);

-- HERE AS WE HAVE TO  contracts that have been signed at least 4 full-years after the date when the given employee was hired in the company for the first time.
-- BY THE USE OF YEAR() WE CAN TAKE YEAR FROM A DATE AND DO SOME ADDITION OR SUBTRACTION ON IT . SO USED YEAR() FUNCTION TO TAKE ALL THE VALUES OUT WHICH HAVE DIFFERENCE OF 4 OR LESS THEN 4 
-- BETWEEN THE HIRE_DATE AND S,FROM_DATE . 

/*
VALUE WINDOW FUNCTION : AS OPPOSED TO RANKING WINDOW FUNCTION VALUE WINDOW FUNCTIONS RETURN A VALUE THAT CAN BE FOUND IN THE DATABASE. 

1] LAG() FUNCTION : RETURNS THE VALUE FROM A SPECIFIED FIELD OF A RECORD THAT PRECCED(the value that lags the current vaue) the current row. 

syntax :

 SELECT ........... ,
LAG(column_name) OVER () AS ........ 
FROM .......... 
;

2] LEAD() : RETURNS THE VALUE FROM A SPECIFIED FIELD OF A RECORD THAT FOLLOWS(the value that leads the current value) the current row. 

syntax : IT'S SAME AS THE LAG() WE HAVE TO REPLACE LAG() with lead() only.

NOTE : The MySQL LAG() and LEAD() value window functions can have a second argument,
	   designating how many rows/steps back (for LAG()) or forth (for LEAD()) we'd like to refer to with respect to a given record.
*/

SELECT 
e.emp_no AS emp_no ,
s.salary AS salary,
LAG(s.salary) OVER w AS previous_salary,
LEAD(s.salary) OVER w AS next_salary ,
s.salary - LAG(s.salary) OVER w AS diff_salary_current_previous ,
LEAD(s.salary) OVER w - s.salary  AS diff_salary_next_current         -- IMPORTANT WE HAVE TO ADD OVER w after LEAD() or LAG() AS SHOWN IN LEFT QUERY
FROM 
employees e JOIN salaries s ON e.emp_no = s.emp_no 
WHERE e.emp_no = 10001
WINDOW w AS (ORDER BY s.salary ); 

/*
Write a query that can extract the following information from the "employees" database:
- the salary values (in ascending order) of the contracts signed by all employees numbered between 10500 and 10600 inclusive
- a column showing the previous salary from the given ordered list
- a column showing the subsequent salary from the given ordered list
- a column displaying the difference between the current salary of a certain employee and their previous salary
- a column displaying the difference between the next salary of a certain employee and their current salary
Limit the output to salary values higher than $80,000 only.
Also, to obtain a meaningful result, partition the data by employee number.
*/

SELECT 
e.emp_no AS emp_no ,
s.salary AS salary,
LAG(s.salary) OVER w AS previous_salary,
LEAD(s.salary) OVER w AS next_salary ,
s.salary - LAG(s.salary) OVER w AS diff_salary_current_previous ,
LEAD(s.salary) OVER w - s.salary  AS diff_salary_next_current         -- IMPORTANT WE HAVE TO ADD OVER w after LEAD() or LAG() AS SHOWN IN LEFT QUERY
FROM 
employees e JOIN salaries s ON e.emp_no = s.emp_no 
WHERE e.emp_no >= 10500 AND e.emp_no <= 10600 AND s.salary > 80000
WINDOW w AS (PARTITION BY e.emp_no ORDER BY s.salary ); 

/*
create a query whose result set contains data arranged by the salary values associated to each employee number (in ascending order).
 Let the output contain the following six columns:
- the employee number
- the salary value of an employee's contract (i.e. which we’ll consider as the employee's current salary)
- the employee's previous salary
- the employee's contract salary value preceding their previous salary
- the employee's next salary
- the employee's contract salary value subsequent to their next salary
Restrict the output to the first 1000 records you can obtain.
*/

SELECT 
e.emp_no AS emp_no ,
s.salary AS salary,
LAG(s.salary) OVER w AS previous_salary,
LAG(s.salary , 2) OVER w AS preceding_previous_salary ,
LEAD(s.salary) OVER w AS next_salary ,
LEAD(s.salary , 2) OVER w AS next_salary 
FROM 
employees e JOIN salaries s ON e.emp_no = s.emp_no 
WINDOW w AS (PARTITION BY e.emp_no ORDER BY s.salary )
LIMIT 1000; 

/*
AGGREGATE WINDOW FUNCTION : WINDOW FUNCTION INVOLVING THE USE OF MYSQL WINDOW FUNCTION,
*/


-- MY WEAK TOPIC WATCH 281 AND 283 AGAIN WHILE REVISING THE SQL . ALSO SOLVE EVERY EXERCISE AGAIN TO GAIN YOUR CONFIDENCE .

/*                         VERY GOOD QUESTION 
CREATE A MYSQLQUERY THAT WILL EXTRACT THE FOLLOWING INFORMATION ABOUT ALL CURRENTLY EMPLOYEED WORKERS REGISTERED IN dept_emp table:

- THEIR employee number
- THE DEPARTMENT THEY ARE WORKING in
- THE SALARY THEY ARE CURRENTLY BEING PAID ( IN LATEST CONTRACT)
- THE ALL TIME AVERAGE SALARY PAID IN THE DEPARTMENT EMPLOYEE IN CURRENTLY WORKING IN ( = USE OF A WINDOW FUNCTION TO CREATE A FIELD NAMED 
  average_salary_per_department 
  */
  
  /*
  Without using window functions but using a subquery, retrieve the employee number (emp_no), salary value (salary), start date (from_date), and end date (to_date)
  of the latest contract of all employees according to the data stored in the salaries table.
  */
  
  SELECT s1.emp_no, s.salary , s.from_date ,  s.to_date FROM salaries s JOIN 
 (  SELECT s.emp_no , MAX(s.from_date) AS from_date 
  FROM salaries s 
  GROUP BY s.emp_no ) AS s1 ON s.emp_no = s1.emp_no
  AND s.to_date > sysdate()
  WHERE s.from_date = s1.from_date;
  
  
  
  SELECT de.emp_no, de.dept_no , de.from_date ,  de.to_date FROM dept_emp  de JOIN 
 (  SELECT de.emp_no , MAX(de.from_date) AS from_date 
  FROM dept_emp de 
  GROUP BY de.emp_no ) AS de1 ON de.emp_no = de1.emp_no
  AND de.to_date > sysdate()
  WHERE de.from_date = de1.from_date;
  
-- THE DEPARTMENT THEY ARE WORKING in
-- THE ALL TIME AVERAGE SALARY PAID IN THE DEPARTMENT EMPLOYEE IN CURRENTLY WORKING

SELECT de2.emp_no , d.dept_name , s2.salary , AVG(s2.salary) OVER w AS average_salary_per_department
FROM(
  SELECT de.emp_no, de.dept_no , de.from_date ,  de.to_date FROM dept_emp  de JOIN 
 (  SELECT de.emp_no , MAX(de.from_date) AS from_date 
  FROM dept_emp de 
  GROUP BY de.emp_no ) AS de1 ON de.emp_no = de1.emp_no
  AND de.to_date > sysdate()
  WHERE de.from_date = de1.from_date)  de2
  JOIN
  (SELECT s1.emp_no, s.salary , s.from_date ,  s.to_date FROM salaries s JOIN 
 (  SELECT s.emp_no , MAX(s.from_date) AS from_date 
  FROM salaries s 
  GROUP BY s.emp_no ) AS s1 ON s.emp_no = s1.emp_no
  AND s.to_date > sysdate()
  WHERE s.from_date = s1.from_date
  ) AS s2 ON s2.emp_no = de2.emp_no 
  JOIN departments d ON d.dept_no = de2.dept_no 
  GROUP BY de2.emp_no , d.dept_name
  WINDOW w as (PARTITION by de2.dept_no)
  ORDER BY de2.emp_no;
  
  /*
  Consider the employees' contracts that have been signed after the 1st of January 2000 and terminated before the 1st of January 2002 (as registered in the "dept_emp" table).

Create a MySQL query that will extract the following information about these employees:

- Their employee number
- The salary values of the latest contracts they have signed during the suggested time period
- The department they have been working in (as specified in the latest contract they've signed during the suggested time period)
- Use a window function to create a fourth field containing the average salary paid in the department the employee was last working in during the suggested time period.
 Name that field "average_salary_per_department".

Note1: This exercise is not related neither to the query you created nor to the output you obtained while solving the exercises after the previous lecture.

Note2: Now we are asking you to practically create the same query as the one we worked on during the video lecture; 
the only difference being to refer to contracts that have been valid within the period between the 1st of January 2000 and the 1st of January 2002.

Note3: We invite you solve this task after assuming that the "to_date" values stored in the "salaries" and "dept_emp" tables are greater than the "from_date" values
 stored in these same tables. If you doubt that, you could include a couple of lines in your code to ensure that this is the case anyway!

Hint: If you've worked correctly, you should obtain an output containing 200 rows.
  */

SELECT de2.emp_no , d.dept_name , s2.salary , AVG(s2.salary) OVER w AS average_salary_per_department
FROM(
  SELECT de.emp_no, de.dept_no , de.from_date ,  de.to_date FROM dept_emp  de JOIN 
 (  SELECT de.emp_no , MAX(de.from_date) AS from_date 
  FROM dept_emp de 
  GROUP BY de.emp_no ) AS de1 ON de.emp_no = de1.emp_no
  WHERE
    de.to_date < '2002-01-01'
AND de.from_date > '2000-01-01'
AND de.from_date = de1.from_date
  )  de2
  JOIN
  (SELECT s1.emp_no, s.salary , s.from_date ,  s.to_date FROM salaries s JOIN 
 (  SELECT s.emp_no , MAX(s.from_date) AS from_date 
  FROM salaries s 
  GROUP BY s.emp_no ) AS s1 ON s.emp_no = s1.emp_no
  WHERE
    s.to_date < '2002-01-01'
AND s.from_date > '2000-01-01'
AND s.from_date = s1.from_date
  ) AS s2 ON s2.emp_no = de2.emp_no 
  JOIN departments d ON d.dept_no = de2.dept_no 
  GROUP BY de2.emp_no , d.dept_name
  WINDOW w as (PARTITION by de2.dept_no)
  ORDER BY de2.emp_no;
  
  
