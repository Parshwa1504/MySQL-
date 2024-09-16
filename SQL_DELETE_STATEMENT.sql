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