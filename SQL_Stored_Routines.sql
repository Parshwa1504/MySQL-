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

/* 
Create a procedure called ‘emp_info’ that uses as parameters the first and the last name of an individual, and returns their employee number.
*/

SELECT DISTINCT e.emp_no , e.first_name , e.last_name FROM employees e;
DROP PROCEDURE IF EXISTS emp_info;

DELIMITER $$
CREATE PROCEDURE emp_info(IN p_first_name CHAR(20) , IN p_last_name CHAR(20) , OUT p_emp_no INT)
BEGIN

SELECT e.emp_no INTO p_emp_no FROM employees e WHERE e.first_name = p_first_name AND e.last_name = p_last_name ;

END$$
DELIMITER ;

CALL emp_info(Tzvetan ,Zielinski);

/* 
Variables : WHEN STRUCTURE OF THE PROGRAM IS SATISFIED IT WILL BE APPLIED TO THE DATABASE.THE INPUT VALUE IS "argument" and the output value is stored in "Variable". 
 
TO CREATE A VARIABLE WHOES VALUE IS EQUAL TO THE OUTCOME OF THE CALCULATION WE HAVE TO FOOLOW BELOW THREE STEPS : 
1] CREATE A VARIABLE :  SET variable_name = 0 ;   (name starts from @V_....)
2] call the procedure ;  CALL procedure_name(INPUT, variable_name);  -> extract a value that will be assigned to the variable.
3] ask to display the value of the variable.    SELECT variable_name;

 */
 
 SET @V_avg_salary = 0 ;
 CALL emp_avg_salary_out(11300 , @V_avg_salary);
 SELECT @V_avg_salary;

/* 
Create a variable, called ‘v_emp_no’, where you will store the output of the procedure you created in the last exercise.
Call the same procedure, inserting the values ‘Aruna’ and ‘Journel’ as a first and last name respectively.
Finally, select the obtained output.
*/

SET @V_emp_no = 0 ;
CALL emp_info('Aruna','Journel',@V_emp_no);
SELECT @V_emp_no;

/*
USER DEFINED FUNCTION : 
SYNTAX :

DROP FUNCTION function_name;

DELIMITER $$
CREATE FUNCTION function_name(parameter_name datatyp) RETURN datatype(only of outpu)
BEGIN

DECLARE variable_name data_type(of input)                     -- MAIN CHANGE
query
RETURN variable_name                                         -- MAIN CHANGE

END$$
DELIMITER ;

SELECT function_name(user input);
*/

DROP FUNCTION IF EXISTS f_emp_avg_salary;

DELIMITER $$
CREATE FUNCTION F_emp_avg_salary( p_emp_no INT) RETURNS DECIMAL(10,2)
DETERMINISTIC                                    -- BECAUSE THERE WAS ERROR TO SOLVE THAT ERROR WE HAVE TO ADD DETERMINISTIC IN THIS QUERY.
BEGIN

DECLARE V_avg_salary DECIMAL(10,2);

SELECT AVG(s.salary) INTO V_avg_salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no 
WHERE e.emp_no = p_emp_no
GROUP BY e.first_name , e.last_name ;

RETURN V_avg_salary;
END$$
DELIMITER ;

SELECT F_emp_avg_salary(11300);           -- to call the function on input 11300

/*                                      VERY GOOD QUESTION 
Create a function called ‘emp_info’ that takes for parameters the first and last name of an employee, and returns the salary from the newest contract of that employee.
Hint: In the BEGIN-END block of this program, you need to declare and use two variables – v_max_from_date that will be of the DATE type,
 and v_salary, that will be of the DECIMAL (10,2) type.
Finally, select this function.
*/

DROP FUNCTION IF EXISTS f_emp_info;

DELIMITER $$
CREATE FUNCTION f_emp_info ( p_first_name VARCHAR(255), p_last_name VARCHAR(255) ) RETURNS DECIMAL(10,2) 
DETERMINISTIC
BEGIN

DECLARE V_max_from_date DATE;
DECLARE V_salary DECIMAL(10,2);

SELECT MAX(s.from_date) INTO v_max_from_date FROM employees e JOIN salaries s ON e.emp_no = s.emp_no 
WHERE e.first_name = p_first_name AND e.last_name = p_last_name ;

SELECT AVG(s.salary) INTO v_salary FROM employees e JOIN salaries s ON e.emp_no = s.emp_no
WHERE e.first_name = p_first_name AND e.last_name = p_last_name AND s.from_date = V_max_from_date;

RETURN V_salary;
END$$
DELIMITER ;

SELECT f_emp_info('Aruna', 'Journel');

