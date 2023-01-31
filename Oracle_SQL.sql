-- 1 Create Statement
CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(30),
    emp_salary DECIMAL(10,2)
);

-- Describe table and show all values 
DESC Employee;
SELECT * FROM Employee;

-- Insert Values
INSERT INTO Employee VALUES (1, 'KirA', 20000);
INSERT INTO Employee VALUES (2, 'SRJ', 50000.90);
INSERT INTO Employee VALUES (3, 'Ramu', 10000);

--SELECT statement
SELECT * FROM Employee WHERE emp_id=1;
SELECT emp_name FROM Employee WHERE emp_id=1;
SELECT emp_name FROM Employee WHERE emp_salary<60000;

-- Update Statement
UPDATE Employee set employee.emp_salary=20000 where employee.emp_id=1;

-- Delete Statement
DELETE FROM Employee WHERE employee.emp_id=3;

-- ORDER BY for acending and Descending
SELECT employee.emp_name from Employee Order BY employee.emp_salary ASC;
SELECT employee.emp_name from Employee Order BY employee.emp_salary DESC;
SELECT * from Employee Order BY employee.emp_salary DESC;


-- Distinct Column Name
SELECT DISTINCT employee.emp_salary from Employee;
SELECT DISTINCT employee.emp_name,employee.emp_salary from Employee;


-- TRUNCATE TABLE -> DELETEs values of a table and faster than DELETE
TRUNCATE TABLE Employee;

-- DROP TABLE -> Removes the entire table
DROP TABLE Employee;



-- FOREIGN KEY -> REFERENCE OF PRIMARY KEY IN OTHER TABLE
CREATE TABLE Department(
    dept_id INTEGER not null PRIMARY KEY,
    dept_name varchar(50)
);

SELECT * FROM Department;

CREATE TABLE Employee (
    emp_id INT not null PRIMARY KEY,
    emp_name VARCHAR(30),
    emp_salary DECIMAL(10,2),
    dept_id INTEGER
);

SELECT * FROM Employee;

INSERT INTO Department values(1, 'IT');
INSERT INTO Department values(2, 'HR');
INSERT INTO Department values(3, 'MEDICAL');
INSERT INTO Department values(4, 'QUALITY');

INSERT INTO Employee VALUES (1, 'KirA', 40000, 2);
INSERT INTO Employee VALUES (2, 'SRJ', 50000.90, 1);
INSERT INTO Employee VALUES (3, 'Bittu', 30000, 3);
INSERT INTO Employee VALUES (4, 'Lilly', 40000, 4);


-- AND OPERATOR -> Satisfy Both Conditions
SELECT * from employee where emp_salary > 35000 AND dept_id=1;

-- OR OPERATOR -> Satisfy Ony one Conditions
SELECT * from employee where emp_salary > 35000 OR dept_id=1000;


-- IN Operator : Modified OR Operator
SELECT * from Employee where dept_id IN (1, 3);


-- BETWEEN OPERATOR ->  SELECTS BETWEEN GIVEN RANGE
SELECT * FROM Employee where emp_salary BETWEEN 20000 AND 41000;


-- LIKE Operator : Used with where to search specified Patterns
-- TWO WILD CARDS (% and _)
SELECT * FROM Employee WHERE emp_name LIKE 'L%';


SELECT * FROM Employee WHERE emp_name LIKE '%R%';


SELECT * FROM Employee WHERE emp_name LIKE 'L%';


SELECT * FROM Employee WHERE emp_name LIKE '_i%%';


-- UNION OPERATOR : adds 2 or more select statements
--same rows with same data type to be selected
SELECT dept_id from Employee 
UNION
SELECT dept_id from Department;

SELECT dept_id from Employee 
UNION ALL
SELECT dept_id from Department order by dept_id asc;


-- Column Alias
SELECT emp_id "ID", emp_name "USERNAME", emp_salary "SALARY", dept_id "DEPARTMENT"
from Employee;

--TABLE ALIAS
SELECT emp_name, dept_name from employee, department 
where employee.dept_id = department.dept_id;

SELECT e.emp_name, e.emp_salary, d.dept_name from employee e, department d
where e.dept_id = d.dept_id;



--INNER JOIN
SELECT e.emp_id, e.emp_name, e.emp_salary, d.dept_name
from Employee e INNER JOIN department d
on e.dept_id = d.dept_id;

-- LEFT JOIN
SELECT e.emp_id, e.emp_name, e.emp_salary, d.dept_name
FROM Employee e
LEFT JOIN department d
on e.dept_id = d.dept_id;

-- Right JOIN
SELECT e.emp_id, e.emp_name, e.emp_salary, d.dept_name
FROM Employee e
RIGHT JOIN department d
on e.dept_id = d.dept_id;


-- FULL JOIN 
SELECT e.emp_id, e.emp_name, e.emp_salary, d.dept_name
FROM Employee e
FULL JOIN department d
on e.dept_id = d.dept_id;


-- CROSS JOIN
SELECT e.emp_id, e.emp_name, e.emp_salary, d.dept_name
FROM Employee e
CROSS JOIN department d;

-- NATURAL JOIN
SELECT e.emp_id, e.emp_name, e.emp_salary, d.dept_name
FROM Employee e
NATURAL JOIN department d;


--SELF JOIN
SELECT e.emp_id, d.emp_name, d.emp_salary
FROM Employee e, Employee d
where e.emp_id = d.emp_id;



--TABLESPACE AND DATASPACE
SELECT tablespace_name from user_tablespaces;
SELECT tablespace_name, file_name, bytes from dba_data_files;


CREATE tablespace myTest datafile'C:\oraclexe\app\oracle\oradata\XE\myTest.dbf'
size 50m;

DROP tablespace myTest;

--TABLESPACE, USERS and ROLE
SELECT tablespace_name from user_tablespaces;
CREATE tablespace test datafile'C:\oraclexe\app\oracle\oradata\XE\test1.dbf'
size 50m;

CREATE USER Kira IDENTIFIED BY kira
DEFAULT TABLESPACE test
TEMPORARY TABLESPACE temp
QUOTA UNLIMITED ON test;

CREATE ROLE DEMO;

GRANT CREATE TABLE, CREATE SESSION TO DEMO;

GRANT DEMO TO Kira;



-- ALTER TABLESPACE
SELECT tablespace_name from dba_data_files;
SELECT tablespace_name, file_name, bytes from dba_data_files;



CREATE tablespace mytest1 datafile 'C:\oraclexe\app\oracle\oradata\XE\mytest1.dbf'
size 50m;
alter tablespace mytest1 add datafile 'C:\oraclexe\app\oracle\oradata\XE\mytest2dbf'
size 40m;


select tablespace_name, file_name, bytes from dba_data_files;

alter tablespace mytest1 drop DATAFILE 'C:\oraclexe\app\oracle\oradata\XE\mytest2dbf';


drop tablespace mytest1 INCLUDING CONTENTS and DATAFILES;

-- ALTER TABLE : ADD, DELETE and MODIFY
SELECT * FROM Employee;
SELECT * FROM Department;


DESC Employee;

Alter table employee add emp_address varchar(52);
ALTER table employee rename column emp_address to address;
ALTER TABLE Employee modify address number;
alter table employee modify address number unique;


-- REFENTIAL INTEGRITY : Accuracy and Consistency of data within a relationship
SELECT * FROM Employees;
SELECT * FROM Departments;

CREATE TABLE Departments(
    dept_id NUMBER PRIMARY KEY,
    dept_name varchar(50)
);

CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(30),
    emp_salary DECIMAL(10,2),
    dept_id NUMBER REFERENCES Departments on DELETE CASCADE
);

INSERT INTO Departments values(1, 'IT');
INSERT INTO Departments values(2, 'HR');
INSERT INTO Departments values(3, 'MEDICAL');
INSERT INTO Departments values(4, 'QUALITY');

INSERT INTO Employees VALUES (1, 'KirA', 40000, 1);
INSERT INTO Employees VALUES (2, 'SRJ', 50000.90, 2);
INSERT INTO Employees VALUES (3, 'Bittu', 30000, 2);
INSERT INTO Employees VALUES (4, 'Lilly', 40000, 1);
INSERT INTO Employees VALUES (5, 'Lalit', 40000, 3);
INSERT INTO Employees VALUES (6, 'Billi',50000, 4);
INSERT INTO Employees VALUES (6, 'Mitoo', 40000, 5);
-- DEPARTMENT ID 5 DOES NOT EXISTS
--Error starting at line : 257 in command -
--INSERT INTO Employees VALUES (6, 'Mitoo', 40000, 5)
--Error report -
--ORA-02291: integrity constraint (SYS.SYS_C007007) violated - parent key not found

delete from departments where dept_id=4; -- Auto delete in employee as well

-- GROUP BY
CREATE TABLE Supplier(
    supplier_id INTEGER PRIMARY KEY,
    supplier_name varchar(20)
);

CREATE TABLE PRODUCTS(
    pro_id INTEGER PRIMARY KEY,
    pro_name varchar(20),
    pro_price INTEGER,
    supplier_id INTEGER REFERENCES Supplier on DELETE CASCADE
);

INSERT INTO SUPPLIER VALUES(1, 'DELL');
INSERT INTO SUPPLIER VALUES(2, 'LENOVO');
INSERT INTO SUPPLIER VALUES(3, 'HP');
INSERT INTO SUPPLIER VALUES(4, 'AMAZON');

SELECT * FROM SUPPLIER;

INSERT INTO PRODUCTS VALUES(1, 'MOUSE', 100, 2);
INSERT INTO PRODUCTS VALUES(2, 'KEYBOARD', 150, 1);
INSERT INTO PRODUCTS VALUES(3, 'HDD', 1000, 4);
INSERT INTO PRODUCTS VALUES(4, 'MONITOR', 200, 1);
INSERT INTO PRODUCTS VALUES(5, 'PENDRIVE', 100, 2);
INSERT INTO PRODUCTS VALUES(6, 'MOUSE', 150, 3);

SELECT * FROM PRODUCTS;

SELECT pro_name
FROM PRODUCTS 
GROUP BY pro_name;

-- AGGREGATE FUNCTIONS
-- COUNT, MIN, MAX, AVG, SUM, STDDEV, VARIANCE
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;

SELECT count(emp_salary) from employees;
SELECT min(emp_salary) from employees;
SELECT max(emp_salary) from employees;
SELECT avg(emp_salary) from employees;
SELECT sum(emp_salary) from employees;
SELECT stddev(emp_salary) from employees;
SELECT variance(emp_salary) from employees;
SELECT emp_salary, count(*) from employees group by emp_salary;


-- HAVING CLAUSE
SELECT * FROM SUPPLIER;
SELECT * FROM PRODUCTS;

SELECT pro_name, count(*) FROM PRODUCTS
group by pro_name;

SELECT pro_name, count(*) FROM PRODUCTS
group by pro_name having count(*)>1;

SELECT pro_name, sum(pro_price) FROM PRODUCTS
group by pro_name having sum(pro_price) > 150;

-- CHARACTER FUNCTIONS
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
-- 1. CASE CONVERSION FUNCTIONS -> LOWER, UPPER, INITCAP
SELECT LOWER(emp_name) FROM EMPLOYEES;
SELECT UPPER(emp_name) FROM EMPLOYEES;
SELECT INITCAP(emp_name) FROM EMPLOYEES;

SELECT * FROM EMPLOYEES where UPPER(emp_name)='BITTU';


-- 2. CHARACTER MANIPULATION FUNCTIONS -> CONCAT, SUBSTR, LENGTH, TRIM, REPLACE

SELECT CONCAT(emp_name, emp_salary) FROM EMPLOYEES;
SELECT SUBSTR('I am King', 3, 4) FROM dual;
SELECT LENGTH('I am King') FROM dual;
SELECT emp_name from employees where length(emp_name)=3;
SELECT instr('I am King', 'King') FROM dual;
SELECT lpad('I am King', 2) FROM dual;
SELECT trim(' King ') FROM dual;
SELECT replace('I am King123', '123') FROM dual;


-- NUMERIC FUNCTION >> CEIL(n), FLOOR(n), ROUND(m,n), POWER(m,n), MOD(m,n), SQRT(n), ABS(n), TRUNC(n1, n2)
SELECT CEIL(12.1) from dual;
SELECT FLOOR(12.1) from dual;
SELECT ROUND(12.177777, 3) from dual;
SELECT POWER(12, 2) from dual;
SELECT MOD(12, 5) from dual;
SELECT SQRT(12) from dual;
SELECT ABS(-12.99) from dual;
SELECT TRUNC(12.16767676, 2) from dual;
SELECT TRUNC(12.16767676, -1) from dual;


-- CONVERSION FUNCTION
create table emp(date_disp date);
insert into emp values(to_date('2022-jan-9','YYYY-MM-DD'));
select * from emp;
select to_char(date_disp,'DD') from emp;

-- PRIMARY AND FOREIGN KEY
create table dept(
    dept_id number primary key,
    dept_name varchar(20)
);

create table students(
    s_id number PRIMARY KEY,
    s_name varchar(20),
    dept_id number REFERENCES dept on DELETE CASCADE
);

insert into dept values(1, 'IT');
insert into dept values(2, 'Medical');

insert into students values (1, 'Kira', 1);
insert into students values (2, 'SRJ', 1);
insert into students values (3, 'Meenu', 2);
select * from students;
delete from dept where dept_id = 2;

-- SEQUENCE IN ORACLE DB
create table studs (
    std_id number primary key,
    std_name varchar(20)
);

create sequence std_seq INCREMENT BY 1 START WITH 100
MAXVALUE 999 MINVALUE 1 NOCYCLE NOCACHE NOORDER;

insert into students values(std_seq.nextval, 'SRJ');


-- Psedocolumn
select sysdate from dual;
select systimestamp from dual;
select uid from dual;
select user from dual;
select rowid from dual;
select rownum from dual;
select nextval from dual;

select * from employees
where emp_salary=(select max(emp_salary) from employee);

-- Data Dictionary
Select * from tab;
Select * from all_tables;
Select * from all_sequences;
Select * from all_views;
Select * from all_constraints;


-- Views in Oracle
select * from employees;
select * from products;

create view employee_view as
select emp_name, emp_salary from employees;

select * from employee_view;

create or replace view employee_view as
select * from employees;

select * from employee_view;
insert into employee_view values(8, 'Raju', 20000,3);

drop view employee_view;


-- Input variables
select * from employees;
select * from products;

ACCEPT ename char prompt 'Please Enter Employee Name: ';

select * from employees where emp_name='&ename';


--Define Variable
select * from employees;
select * from products;

DEFINE eid = 1;
select * from employees where emp_id = &eid;

define
undefine eid;










