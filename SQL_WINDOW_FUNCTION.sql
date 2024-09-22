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