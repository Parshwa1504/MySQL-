
-- LECTURE: MySQL Triggers


# In this lesson, we will introduce you to MySQL triggers.

# By definition, a MySQL trigger is a type of stored program, associated with a table, 
# that will be activated automatically once a specific event related to the table of association occurs. 

# This event must be related to one of the following three DML statements: INSERT, UPDATE, or DELETE. 
# Therefore, triggers are a powerful and handy tool that professionals love to use where database consistency 
# and integrity are concerned.

# Moreover, to any of these DML statements, one of two types of triggers can be assigned – a “before”, or an “after” trigger.

# In other words, a trigger is a MySQL object that can “trigger” a specific action or calculation ‘before’ or ‘after’ an INSERT, 
# UPDATE, or DELETE statement has been executed. For instance, a trigger can be activated before a new record is inserted into a table, 
# or after a record has been updated.

# Perfect! Let’s execute some code.  

# First, in case you are just starting Workbench, select “Employees” as your default database.
USE employees;

# Then, execute a COMMIT statement, because the triggers we are about to create will make some changes to 
# the state of the data in our database. At the end  we will ROLLBACK up to the moment of this COMMIT.  
COMMIT;

# We said triggers are a type of stored program. Well, one could say the syntax resembles that of stored procedures, couldn’t they?

# BEFORE INSERT
DELIMITER $$

CREATE TRIGGER before_salaries_insert
BEFORE INSERT ON salaries
FOR EACH ROW
BEGIN 
	IF NEW.salary < 0 THEN 
		SET NEW.salary = 0; 
	END IF; 
END $$

DELIMITER ;

# After stating we want to CREATE a TRIGGER and then indicating its name, we must indicate its type and the name of the table 
# to which it will be applied. In this case, we devised a “before” trigger, which will be activated whenever new data is inserted 
# in the “Salaries” table. 

# Great!

# Then, an interesting phrase follows – “for each row”. It designates that before the trigger is activated, MySQL will perform a 
# check for a change of the state of the data on all rows. In our case, a change in the data of the “Salaries” table will be caused 
# by the insertion of a new record. 

# Within the BEGIN-END block, you can see a piece of code that is easier to understand if you just read it without focusing on 
# the syntax.

# The body of this block acts as the core of the “before_salaries_insert” trigger. Basically, it says that if the newly inserted 
# salary is of negative value, it will be set as 0.
/*
	IF NEW.salary < 0 THEN 
		SET NEW.salary = 0; 
	END IF;
*/

# From a programmer’s perspective, there are three things to note about these three lines of code.

# First, especially for those of you who are familiar with some programming, this is an example of a conditional. The IF statement 
# starts the conditional block. Then, if the condition for negative salary is satisfied, one must use the keyword THEN before showing 
# what action should follow. The operation is terminated by the END IF phrase and a semi-colon. 

# The second thing to be noted here is even more interesting. That’s the use of the keyword NEW. In general, it refers to a row that 
# has just been inserted or updated. In our case, after we insert a new record, “NEW dot salary” will refer to the value that will 
# be inserted in the “Salary” column of the “Salaries” table.

# The third part of the syntax regards the SET keyword. As you already know, it is used whenever a value has to be assigned to a 
# certain variable. Here, the variable is the newly inserted salary, and the value to be assigned is 0. 

# All right! Let’s execute this query. 
# BEFORE INSERT
DELIMITER $$

CREATE TRIGGER before_salaries_insert
BEFORE INSERT ON salaries
FOR EACH ROW
BEGIN 
	IF NEW.salary < 0 THEN 
		SET NEW.salary = 0; 
	END IF; 
END $$

DELIMITER ;

# Let’s check the values of the “Salaries” table for employee 10001.
SELECT 
    *
FROM
    salaries
WHERE
    emp_no = '10001';
    
# Now, let’s insert a new entry for employee 10001, whose salary will be a negative number.
INSERT INTO salaries VALUES ('10001', -92891, '2010-06-22', '9999-01-01');

# Let’s run the same SELECT query to see whether the newly created record has a salary of 0 dollars per year.
SELECT 
    *
FROM
    salaries
WHERE
    emp_no = '10001';
    
# You can see that the “before_salaries_insert” trigger was activated automatically. It corrected the value of minus 92,891 to 0
# we tried to insert. 

# Fantastic!

# Now, let’s look at a BEFORE UPDATE trigger. The code is similar to the one of the trigger we created above, with two 
# substantial differences.
# BEFORE UPDATE
DELIMITER $$

CREATE TRIGGER trig_upd_salary
BEFORE UPDATE ON salaries
FOR EACH ROW
BEGIN 
	IF NEW.salary < 0 THEN 
		SET NEW.salary = OLD.salary; 
	END IF; 
END $$

DELIMITER ;

# First, we indicated that this will be a BEFORE UPDATE trigger.  
/*
BEFORE UPDATE ON salaries
*/

# Second, in the IF conditional statement, instead of setting the new value to 0, we are basically telling MySQL to keep the old value. 
# Technically, this is achieved by setting the NEW value in the “Salary” column to be equal to the OLD one. This is a good example of 
# when the OLD keyword needs to be used.
/*
	IF NEW.salary < 0 THEN 
		SET NEW.salary = OLD.salary; 
	END IF;
*/

# Create the “before_salaries_update” trigger by executing the above statement. 

# Then, run the following UPDATE statement, with which we will modify the salary value of employee 10001 with another positive value.
UPDATE salaries 
SET 
    salary = 98765
WHERE
    emp_no = '10001'
        AND from_date = '2010-06-22';
        
# Execute the following SELECT statement to see that the record has been successfully updated.
SELECT 
    *
FROM
    salaries
WHERE
    emp_no = '10001'
        AND from_date = '2010-06-22';
        
# Now, let’s run another UPDATE statement, with which we will try to modify the salary earned by 10001 with a negative value, minus 50,000.
UPDATE salaries 
SET 
    salary = - 50000
WHERE
    emp_no = '10001'
        AND from_date = '2010-06-22';
        
# Let’s run the same SELECT statement to check if the salary value was adjusted.
SELECT 
    *
FROM
    salaries
WHERE
    emp_no = '10001'
        AND from_date = '2010-06-22';
        
# No, it wasn’t. Everything remained intact. So, we can conclude that only an update with a salary higher than zero dollars per year 
# would be implemented.


# All right. For the moment, you know you have created only two triggers. But how could you prove that to someone who is seeing your 
# script for the first time?
# Well, in the ‘info’ section of the “employees” database, you can find a tab related to triggers. When you click on its name, 
# MySQL will show you the name, the related event, table, timing, and other characteristics regarding each trigger currently in use.  
 
# Awesome!

# Let’s introduce you to another interesting fact about MySQL. You already know there are pre-defined system variables, but system 
# functions exist too! 
# System functions can also be called built-in functions. 
# Often applied in practice, they provide data related to the moment of the execution of a certain query.

# For instance, SYSDATE() delivers the date and time of the moment at which you have invoked this function.
SELECT SYSDATE();

# Another frequently employed function, “Date Format”, assigns a specific format to a given date. For instance, the following query 
# could extract the current date, quoting the year, the month, and the day. 
SELECT DATE_FORMAT(SYSDATE(), '%y-%m-%d') as today;

# Of course, there are many other ways in which you could format a date; what we showed here was just an example.
# So, using system functions seems cool, doesn’t it?

# Wonderful! You already know how to work with the syntax that allows you to create triggers. 

# As an exercise, try to understand the following query. Technically, it regards the creation of a more complex trigger. 
#It is of the size that professionals often have to deal with.

/*
Imagine there's a new employee that has been promoted to a manager in the company. Assume that company-wise, this means their annual salary should immediately become $20,000 higher
than the highest annual salary they'd ever earned until that moment. As an analyst, you'd correctly expect this information to be immediately reflected as a new record
in the "department manager" table. Our task here will be a level deeper than that, so to speak. Therefore, you'd rather have to think from the perspective
of a database administrator who has to create a trigger that will apply several modifications to the "salaries" table once the relevant record in the "department manager" table
has been inserted. More precisely, our sub-tasks are, make sure that the end date of the previously highest salary contract of that employee is the one from the execution of the INSERT statement.
Please note that here we're also assuming that the highest salary of an employee is always the latest salary in their history. Insert a new record in the "salaries" table
about the same employee that reflects their next contract as a manager. In other words, let that record have the following characteristics. A start date the same as the new "from date"
from the newly inserted record in "department manager", a salary equal to $20,000 higher than their highest-ever salary, and let that be a contract of indefinite duration.
You can display that as a contract ending on the 1st of January in the year 9999. And if you wonder why we chose the 1st of January as opposed to the 31st of December 9999,
it's just to comply with the value that has already been used across the database to indicate indefinite duration.
*/


DELIMITER $$

CREATE TRIGGER trig_ins_dept_mng
AFTER INSERT ON dept_manager
FOR EACH ROW
BEGIN
	DECLARE v_curr_salary int;
    
    SELECT 
		MAX(salary)
	INTO v_curr_salary FROM
		salaries
	WHERE
		emp_no = NEW.emp_no;

	IF v_curr_salary IS NOT NULL THEN
		UPDATE salaries 
		SET 
			to_date = SYSDATE()
		WHERE
			emp_no = NEW.emp_no and to_date = NEW.to_date;

		INSERT INTO salaries 
			VALUES (NEW.emp_no, v_curr_salary + 20000, NEW.from_date, NEW.to_date);
    END IF;
END $$

DELIMITER ;

# After you are sure you have understood how this query works, please execute it and then run the following INSERT statement.  
INSERT INTO dept_manager VALUES ('111534', 'd009', date_format(sysdate(), '%y-%m-%d'), '9999-01-01');

# SELECT the record of employee number 111534 in the ‘dept_manager’ table, and then in the ‘salaries’ table to see how the output was affected. 
SELECT 
    *
FROM
    dept_manager
WHERE
    emp_no = 111534;
    
SELECT 
    *
FROM
    salaries
WHERE
    emp_no = 111534;

# Conceptually, this was an ‘after’ trigger that automatically added $20,000 to the salary of the employee who was just promoted as a manager. 
# Moreover, it set the start date of her new contract to be the day on which you executed the insert statement.

# Finally, to restore the data in the database to the state from the beginning of this lecture, execute the following ROLLBACK statement. 
ROLLBACK;

# End.

/* 
Create a trigger that checks if the hire date of an employee is higher than the current date. 
If true, set this date to be the current date. Format the output appropriately (YY-MM-DD).
*/

Commit;

DROP TRIGGER IF EXISTS t_hire_date;

DELIMITER $$
CREATE TRIGGER t_hire_date
BEFORE INSERT ON employees
FOR each row

BEGIN 



IF NEW.hire_date > date_format(sysdate(),'%y-%m-%d') THEN
	SET NEW.hire_date = date_format(sysdate(),'%y-%m-%d') ;
END IF;
END $$

DELIMITER ;

SELECT * from employees ORDER BY emp_no DESC LIMIT 10;

INSERT employees VALUES ('999904', '1970-01-31', 'John', 'Johnson', 'M', '2025-01-01');  

SELECT  
    *  
FROM  
    employees
ORDER BY emp_no DESC;

rollback;

/* 
SQL INDEX : WHEN SATA IS TAKEN FROM A COLUMN OF THE TABLE AND IS STORED IN CERTAIN ORDER IN DISTINCT PLACE IT'S CALLED INDEX.

SYNTAX: 

CREATE INDEX index_name 
ON table_name ( column_1 , column_2 ............);

*/

SELECT first_name , last_name FROM employees WHERE hire_date > '2000-01-01';  -- speed of output after the use of index was very fast. 

CREATE INDEX i_hire_date 
ON employees(hire_date);

-- composite index : syntax is same as the indexes it's for multiple columns that's it.

CREATE INDEX i_name
ON employees(first_name , last_name);

-- to see the list of index in a column we have write below code: 

SHOW INDEXES FROM employees;             -- SHOW INDEXES FROM table_name; 

-- Drop the ‘i_hire_date’ index.

ALTER TABLE employees
DROP INDEX i_hire_date;

/*
Select all records from the ‘salaries’ table of people whose salary is higher than $89,000 per annum.
Then, create an index on the ‘salary’ column of that table, and check if it has sped up the search of the same SELECT statement.
*/

SELECT * FROM salaries WHERE salary > 89000;

DELIMITER $$ 

CREATE INDEX i_salary ON salaries(salary);
DELIMITER ;
/* 
Case statement : it's used within  a select statemnet when we want to return a specific value based on some condition .

syntax: 

SELECT COLUMN_NAME(S)
CASE condition_field
WHEN condition_field_value_1 THEN result_1
WHEN condition_field_value_2 THEN result_2...........
ELSE
END AS
FROM table_name;

*/ 

SELECT 
emp_no , 
first_name,
last_name,
CASE 
WHEN gender = 'M' THEN 'MALE'
ELSE 'FEMALE'
END AS gender
FROM employees;

-- IF() construct : 

SELECT
emp_no,
first_name,
last_name,
if(gender = 'M' , 'MALE' , 'female') as gender
from employees;

-- WITH CASE WE CAN HAVE MULTIPLE CONDITIONAL EXPRESSION BUT WITH IF WE CAN HAVE ONLY ONE CONDITIONAL EXPRESSION.

/*
Similar to the exercises done in the lecture, obtain a result set containing the employee number, first name, and last name of all employees with a number higher than 109990. 
Create a fourth column in the query, indicating whether this employee is also a manager, according to the data provided in the dept_manager table, or a regular employee.
*/

SELECT 
e.emp_no,
e.first_name,
e.last_name,
CASE
WHEN dm.emp_no is not null THEN  'MANAGER'
ELSE 'Employee'
END as is_manager
FROM employees e LEFT JOIN dept_manager dm ON e.emp_no = dm.emp_no 
WHERE e.emp_no > 109990;

/*
Extract a dataset containing the following information about the managers: employee number, first name, and last name.
 Add two columns at the end – one showing the difference between the maximum and minimum salary of that employee, and
 another one saying whether this salary raise was higher than $30,000 or NOT.

If possible, provide more than one solution
*/

SELECT dm.emp_no , e.first_name , e.last_name , MAX(s.salary) - MIN(s.salary) AS salary_difference  ,
CASE
WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'THE SALARY  RAISE WAS HIGHER THAN 30000'
ELSE 'THE SALARY  RAISE WAS NOT HIGHER THAN 30000'
END AS salary_hike
FROM employees e JOIN dept_manager dm ON e.emp_no = dm.emp_no JOIN salaries s on dm.emp_no = s.emp_no
GROUP BY e.emp_no , e.first_name , e.last_name
ORDER BY e.emp_no;

/*
Extract the employee number, first name, and last name of the first 100 employees, and add a fourth column, 
called “current_employee” saying “Is still employed” if the employee is still working in the company, or “Not an employee anymore” if they aren’t.

Hint: You’ll need to use data from both the ‘employees’ and the ‘dept_emp’ table to solve this exercise. 
*/

SELECT e.emp_no , e.first_name, e.last_name , 
CASE 
WHEN MAX(de.to_date) > sysdate() THEN 'Is still employed'
else 'Not an employee anymore'
END as emp_status
FROM employees e JOIN dept_emp de ON e.emp_no = de.emp_no 
group by e.emp_no
LIMIT 100;



