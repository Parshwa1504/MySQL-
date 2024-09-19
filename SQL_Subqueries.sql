USE employees;

/* 
SUBqueries : query embedded in a query.
*/
-- [1] WITH IN nested inside WHERE : 

SELECT e.first_name , e.last_name
FROM employees e
WHERE e.emp_no IN (SELECT d.emp_no FROM dept_manager d );  -- it will display all the manager's firstname and lastname .

-- Extract the information about all department managers who were hired between the 1st of January 1990 and the 1st of January 1995.

SELECT e.*
FROM employees e 
WHERE e.hire_date > '1990-01-01' && e.hire_date < '1995-01-01' &&  e.emp_no IN ( SELECT d.emp_no FROM dept_manager d );

-- [2] EXIST AND NOTEXISTS subqueries : checks whether certain row values are found within subqueries .

SELECT e.first_name , e.last_name 
FROM employees e 
WHERE exists (
SELECT dm.emp_no FROM dept_manager dm WHERE e.emp_no = dm.emp_no)
ORDER BY e.emp_no;

-- Select the entire information for all employees whose job title is “Assistant Engineer”. Hint: To solve this exercise, use the 'employees' table.

SELECT 
    e.*
FROM
    employees e
WHERE
    EXISTS( SELECT 
            *
        FROM
            titles t
        WHERE
            t.title = 'Assistant Engineer' && e.emp_no = t.emp_no)
ORDER BY e.emp_no;

/* ASSIGN Employee no 110022 as manager to all employees from 110001 to 110020 and assign 110039 as manager to all employees from 110021 to 110040*/

SELECT 
    A.*
FROM
    (SELECT 
        e.emp_no AS Employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    employees e
                WHERE
                    e.emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS A 
UNION SELECT 
    B.*
FROM
    (SELECT 
        e.emp_no AS Employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    employees e
                WHERE
                    e.emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS B;
    
    /* 
    Starting your code with “DROP TABLE”, create a table called “emp_manager” 
    (emp_no – integer of 11, not null; dept_no – CHAR of 4, null; manager_no – integer of 11, not null). 
    */
  DROP TABLE IF exists emp_manager;
  
  CREATE TABLE emp_manager
  (
  emp_no int(11) NOT NULL,
  dept_no CHAR(4) NULL ,
  manager_no int(11) NOT NULL 
  );
  
  SELECT * FROM emp_manager;
  
  /* 
  Fill emp_manager with data about employees, the number of the department they are working in, and their managers.
Your query skeleton must be:

Insert INTO emp_manager SELECT
U.*
FROM
                 (A)
UNION (B) UNION (C) UNION (D) AS U;

A and B should be the same subsets used in the last lecture (SQL Subqueries Nested in SELECT and FROM). 
In other words, assign employee number 110022 as a manager to all employees from 10001 to 10020 (this must be subset A),
 and employee number 110039 as a manager to all employees from 10021 to 10040 (this must be subset B).

Use the structure of subset A to create subset C, where you must assign employee number 110039 as a manager to employee 110022.
Following the same logic, create subset D. Here you must do the opposite - assign employee 110022 as a manager to employee 110039.
Your output must contain 42 rows.
  */
  
  
  INSERT INTO emp_manager
SELECT 
    u.*
FROM
    (SELECT 
        a.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS a UNION SELECT 
        b.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS b UNION SELECT 
        c.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110022
    GROUP BY e.emp_no) AS c UNION SELECT 
        d.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110039
    GROUP BY e.emp_no) AS d) as u;
   
      SELECT * FROM emp_manager;
   
   /* 
   SELF JOIN : It's applied when a table mist join it self.if we wnat to combine certain row of a table with other row of the same tablr yoou need a self join.
   */
   
   -- task : from employee_manager table extract the data of employees who are manager as well
   
   use employees;
   SELECT * FROM emp_manager;
    
   SELECT DISTINCT e1.* FROM emp_manager e1 JOIN emp_manager e2 ON e1.emp_no = e2.manager_no;  -- METHOD 1 WHERE WE FILTER BOTH E1 AND E2 IN JOIN.
   
   SELECT e1.* FROM emp_manager e1 join  emp_manager e2 on e1.emp_no = e2.manager_no WHERE e2.emp_no in ( select manager_no FROM emp_manager ) ;  
   -- METHOD 2 WHERE WE FILTER E1 OR E2 IN JOIN AND ANOTHER OEN IN WHERE CLAUSE.

/* 
SQL VIEWS : A VIRTUAL TABLE WHOSE CONTENTS ARE OBTAINED FROM AN EXISTING TABLE OR TABLES CALLED BASE TABLES.THE VIEW ITSELF DOES NOT CONTAIN ANY REAL DATA THE DATA IS PHYSICALLY STORED IN THE BASE TABLE.
*/   
 
select * from dept_emp; 
 
CREATE OR REPLACE VIEW V_dept_emp_latest AS
SELECT  emp_no , dept_no , MAX(from_date) as From_date , MAX(to_date) as To_date 
FROM dept_emp 
GROUP BY emp_no;

/* 
Create a view that will extract the average salary of all managers registered in the database. Round this value to the nearest cent.
If you have worked correctly, after executing the view from the “Schemas” section in Workbench, you should obtain the value of 66924.27.
*/


CREATE OR REPLACE VIEW V_average_salary as
SELECT  t.title , ROUND(AVG(s.salary) , 2) FROM salaries s 
JOIN titles t ON s.emp_no = t.emp_no 
WHERE t.title = 'manager';
