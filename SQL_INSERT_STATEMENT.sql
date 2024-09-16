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