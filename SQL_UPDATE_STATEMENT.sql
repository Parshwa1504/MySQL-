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