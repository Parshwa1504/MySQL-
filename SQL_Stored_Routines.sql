/* 
STORED ROUTINE : A SQL STATEMENT OR SET OF SQL STATEMENT THAT CAN BE STORED ON DATABASE SERVER. 
2 TYPES OF STORED ROUTINE : 1] stored procedure   2] function : (user defined functions) 

1] stores procedures : 
syntax : 

DELIMETER $$         
CREATE PROCEDURES procedure_name (param_1 , param_2)   -- A PROCEDURE CAN BE CREATED WITHOUT PARAMETERS
BEGIN
           -- QUERY WHICH WE HAVE TO STORE
END$$
DELIMITER ;

TO CALL OR INVOKE THE STORD PROCEDURE WE WILL APLLY THIS QUERY

CALL database_name.procedure_name();
CALL procedure_name();   

IF WE WANT REMOVE A PROCEDURE STORD THE WE WILL WRITE BELOW QUERY :
DROP PROCEDURE procedure_name; 
 
*/

-- A NON PARAMETRIC PROCEDURE THAT WHENEVER APPLIED WILL RETURN US FIRST 1000 ROWS FROM EMPLOYEES TABLE. 

USE employees ;

drop procedure IF EXISTS select_employee;

DELIMITER $$ 
CREATE PROCEDURE select_employee()
BEGIN

SELECT * FROM employees ORDER BY emp_no LIMIT 1000 ; 

END$$
DELIMITER ;

CALL select_employee();

-- Create a procedure that will provide the average salary of all employees. Then, call the procedure.

DROP PROCEDURE IF EXISTS avg_salary;

DELIMITER $$
CREATE PROCEDURE avg_salary()
BEGIN

SELECT AVG(salary) FROM salaries ORDER BY emp_no ;

END$$
DELIMITER ;

CALL avg_salary();

DROP PROCEDURE select_employee;
DROP PROCEDURE avg_salary;
-- we can create a stored procedure using SQL workbench to see how it's done watch 226 .

/* 
 STORED PROCEDURE WITH INPUT PARAMETERS : 
 syntax:
 
 DROP PROCEDURE IF EXISTS procedure_name();
 
 DELIMITER $$
 CREATE PROCEDURE procedure_name(IN parameters)  -- HERE IN IS INPUT(NAME) AND PARAMETERS(DATA TYPE)
 BEGIN 
            QUERY;
 END$$
 DELIMITER ;
*/

-- WE WANT TO HAVE AN PROGRAM THAT RETURNS NAME , SALARY , START DATE AND END DATE . 

DROP PROCEDURE IF EXISTS emp_salary;

DELIMITER $$
CREATE PROCEDURE emp_salary(IN p_emp_no int)
BEGIN

SELECT e.first_name , e.last_name , s.salary , s.from_date  , s.to_date
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no 
WHERE e.emp_no = p_emp_no;  
--  The WHERE e.emp_no = p_emp_no; condition in your stored procedure is used to filter the results so 
-- that the query only returns the salary information for the specific employee whose employee number (emp_no) is passed as a parameter (p_emp_no) when the procedure is called.
-- This condition filters the rows in the employees and salaries tables to only include those where the emp_no matches the value of p_emp_no.
-- By doing this, the query only returns the records related to the specific employee you are interested in.

END$$
DELIMITER ;

CALL emp_salary();

-- procedures with one input parameters can be used with aggregate functions too . 

DROP PROCEDURE IF EXISTS emp_avg_salary;


DELIMITER $$
CREATE PROCEDURE emp_avg_salary(IN p_emp_no int)
BEGIN

SELECT e.first_name , e.last_name , AVG(s.salary) 
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no 
WHERE e.emp_no = p_emp_no
GROUP BY e.first_name , e.last_name ;
--  The WHERE e.emp_no = p_emp_no; condition in your stored procedure is used to filter the results so 
-- that the query only returns the salary information for the specific employee whose employee number (emp_no) is passed as a parameter (p_emp_no) when the procedure is called.
-- This condition filters the rows in the employees and salaries tables to only include those where the emp_no matches the value of p_emp_no.
-- By doing this, the query only returns the records related to the specific employee you are interested in.

END$$
DELIMITER ;

CALL emp_avg_salary(11300);

/*  STORED PROCEDURE WITH IN AND OUT (2) parameters : 
syntax : 

DROP PROCEDURE IF EXISTS procedure_name(IN parameter , out parameter);
 -- output parameter represent output value of the operation executed by the query of the stored procedure. 
 
 DELIMITER $$
 CREATE PROCEDURE procedure_name(IN parameters)  -- HERE IN IS INPUT(NAME) AND PARAMETERS(DATA TYPE)
 BEGIN 
            QUERY;
 END$$
 DELIMITER ;
 
 NOTE : EVERY TIME WE CREATE A IN AND OUT PARAMETER PROCEDURE WE HAVE TO USE SELECT INTO STRUCTURE.

*/

DROP PROCEDURE IF EXISTS emp_avg_salary_out;


DELIMITER $$
CREATE PROCEDURE emp_avg_salary_out(IN p_emp_no INT,OUT p_avg_salary DECIMAL(10,2) )
BEGIN

SELECT AVG(s.salary) INTO p_avg_salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no 
WHERE e.emp_no = p_emp_no
GROUP BY e.first_name , e.last_name ;
--  The WHERE e.emp_no = p_emp_no; condition in your stored procedure is used to filter the results so 
-- that the query only returns the salary information for the specific employee whose employee number (emp_no) is passed as a parameter (p_emp_no) when the procedure is called.
-- This condition filters the rows in the employees and salaries tables to only include those where the emp_no matches the value of p_emp_no.
-- By doing this, the query only returns the records related to the specific employee you are interested in.

END$$
DELIMITER ;

CALL emp_avg_salary(11300);