create database case_study2

use case_study2

CREATE TABLE LOCATION (
  Location_ID INT PRIMARY KEY,
  City VARCHAR(50)
);

INSERT INTO LOCATION (Location_ID, City)
VALUES (122, 'New York'),
       (123, 'Dallas'),
       (124, 'Chicago'),
       (167, 'Boston');


  CREATE TABLE DEPARTMENT (
  Department_Id INT PRIMARY KEY,
  Name VARCHAR(50),
  Location_Id INT,
  FOREIGN KEY (Location_Id) REFERENCES LOCATION(Location_ID)
);


INSERT INTO DEPARTMENT (Department_Id, Name, Location_Id)
VALUES (10, 'Accounting', 122),
       (20, 'Sales', 124),
       (30, 'Research', 123),
       (40, 'Operations', 167);

	   CREATE TABLE JOB (
  Job_ID INT PRIMARY KEY,
  Designation VARCHAR(50)
);

CREATE TABLE JOB
(JOB_ID INT PRIMARY KEY,
DESIGNATION VARCHAR(20))

INSERT  INTO JOB VALUES
(667, 'CLERK'),
(668,'STAFF'),
(669,'ANALYST'),
(670,'SALES_PERSON'),
(671,'MANAGER'),
(672, 'PRESIDENT')


CREATE TABLE EMPLOYEE
(EMPLOYEE_ID INT,
LAST_NAME VARCHAR(20),
FIRST_NAME VARCHAR(20),
MIDDLE_NAME CHAR(1),
JOB_ID INT FOREIGN KEY
REFERENCES JOB(JOB_ID),
MANAGER_ID INT,
HIRE_DATE DATE,
SALARY INT,
COMM INT,
DEPARTMENT_ID  INT FOREIGN KEY
REFERENCES DEPARTMENT(DEPARTMENT_ID))

INSERT INTO EMPLOYEE VALUES
(7369,'SMITH','JOHN','Q',667,7902,'17-DEC-84',800,NULL,20),
(7499,'ALLEN','KEVIN','J',670,7698,'20-FEB-84',1600,300,30),
(7505,'DOYLE','JEAN','K',671,7839,'04-APR-85',2850,NULl,30),
(7506,'DENNIS','LYNN','S',671,7839,'15-MAY-85',2750,NULL,30),
(7507,'BAKER','LESLIE','D',671,7839,'10-JUN-85',2200,NULL,40),
(7521,'WARK','CYNTHIA','D',670,7698,'22-FEB-85',1250,500,30)


select * from DEPARTMENT

select * from EMPLOYEE

select * from JOB

select * from LOCATION

--Simple Queries:
--1. List all the employee details.
select * from EMPLOYEE

--2. List all the department details.
select * from DEPARTMENT

--3. List all job details.
select * from JOB

--4. List all the locations.
select * from LOCATION

--5. List out the First Name, Last Name, Salary, Commission for allEmployees.
select FIRST_NAME, LAST_NAME, SALARY, COMM
from EMPLOYEE


--6. List out the Employee ID, Last Name, Department ID for all employeesandalias
--Employee ID as "ID of the Employee", Last Name as "Name of theEmployee", Department ID as "Dep_id".
select EMPLOYEE_ID as "ID of the Employee",
LAST_NAME as "Name of the Employee",
DEPARTMENT_ID as "Dep_id"
from EMPLOYEE


--7. List out the annual salary of the employees with their names only. 
select concat(FIRST_NAME,' ', LAST_NAME) as NameOfEmployee,
12*SALARY as AnnualSalary
from EMPLOYEE


--WHERE Condition:
--1. List the details about "Smith".
select * from EMPLOYEE
where LAST_NAME = 'Smith'

--2. List out the employees who are working in department 20.
select concat(FIRST_NAME,' ', LAST_NAME) as NameOfEmployee
from EMPLOYEE
where DEPARTMENT_ID = 20

--3. List out the employees who are earning salaries between 3000and4500.
select concat(FIRST_NAME,' ', LAST_NAME) as NameOfEmployee
from EMPLOYEE
where SALARY between 3000 and 4500

--4. List out the employees who are working in department 10 or 20. 
select concat(FIRST_NAME,' ', LAST_NAME) as NameOfEmployee
from EMPLOYEE
where DEPARTMENT_ID in (10, 20)

--5. Find out the employees who are not working in department 10 or 30.
select concat(FIRST_NAME,' ', LAST_NAME) as NameOfEmployee
from EMPLOYEE
where DEPARTMENT_ID not in (10, 20)

--6. List out the employees whose name starts with 'S'.
select concat(FIRST_NAME,' ', LAST_NAME) as NameOfEmployee
from EMPLOYEE
where (FIRST_NAME like 'S%'
OR LAST_NAME like 'S%')

--7. List out the employees whose name starts with 'S' and ends with'H'.
select concat(FIRST_NAME,' ', LAST_NAME) as NameOfEmployee
from EMPLOYEE
where (FIRST_NAME like 'S%H'
OR LAST_NAME like 'S%H')

--8. List out the employees whose name length is 4 and start with 'S'.
select concat(FIRST_NAME,' ', LAST_NAME) as NameOfEmployee
from EMPLOYEE
where (FIRST_NAME like 'S%'
OR LAST_NAME like 'S%')
and (LEN(FIRST_NAME) = 4
or LEN(LAST_NAME) = 4)

--9. List out employees who are working in department 10 and draw salaries more than 3500.
select concat(FIRST_NAME,' ', LAST_NAME) as NameOfEmployee
from EMPLOYEE
where DEPARTMENT_ID = 10
and SALARY>3500


--10. List out the employees who are not receiving commission. 
select concat(FIRST_NAME,' ', LAST_NAME) as NameOfEmployee
from EMPLOYEE
where COMM is NULL


--ORDER BY Clause:
--1. List out the Employee ID and Last Name in ascending order based on the Employee ID.

select Employee_id, Last_name
from EMPLOYEE
order by EMPLOYEE_ID

--2. List out the Employee ID and Name in descending order based on salary.
select Employee_id, Last_name
from EMPLOYEE
order by SALARY desc

--3. List out the employee details according to their Last Name in ascending-order.
select * from EMPLOYEE
order by LAST_NAME

--4. List out the employee details according to their Last Name in ascending order and then Department ID in descending order. 
select * from EMPLOYEE
order by LAST_NAME, DEPARTMENT_ID desc


--GROUP BY and HAVING Clause:
--1. How many employees are in different departments in the organization?
select DEPARTMENT_ID, 
count(*) as NumOfEmployeeInOrg
from EMPLOYEE
group by DEPARTMENT_ID


--2. List out the department wise maximum salary, minimum salary and average salary of the employees.
select DEPARTMENT_ID, 
max(salary) as MaxSalary,
min(salary) as MinSalary,
avg(salary) as AvgSalary
from EMPLOYEE
group by DEPARTMENT_ID


--3. List out the job wise maximum salary, minimum salary and averagesalary of the employees.
select JOB_ID, 
max(salary) as MaxSalary,
min(salary) as MinSalary,
avg(salary) as AvgSalary
from EMPLOYEE
group by JOB_ID

select * from EMPLOYEE


--4. List out the number of employees who joined each month in ascending order.
select month(Hire_Date) as Month_,
count(*) as NumOfEmployee
from EMPLOYEE
group by month(Hire_Date)
order by month(Hire_Date)

--5. List out the number of employees for each month and year in ascending order based on the year and month.
select month(Hire_Date) as Month_, 
year(Hire_Date) as Year_,
count(*) as NumOfEmployee
from EMPLOYEE
group by month(Hire_Date), year(Hire_Date)
order by month(Hire_Date), year(Hire_Date)

--6. List out the Department ID having at least four employees.

select DEPARTMENT_ID
--,count(*) as CountOfEmployee
from EMPLOYEE
group by DEPARTMENT_ID
having count(*) >= 4

--7. How many employees joined in the month of January?
select count(*) as NumOfEmployee
from EMPLOYEE
where month(Hire_Date) = 1

--8. How many employees joined in the month of January or September?
select count(*) as NumOfEmployee
from EMPLOYEE
where month(Hire_Date) in (1, 9)

--9. How many employees joined in 1985?
select count(*) as NumOfEmployee
from EMPLOYEE
where year(Hire_Date) = 1985

--10. How many employees joined each month in 1985?
select month(Hire_Date) as monthOfJoining, 
count(*) as NumOfEmployee
from EMPLOYEE
where year(Hire_Date) = 1985
group by month(Hire_Date)
order by month(Hire_Date)

--11. How many employees joined in March 1985?
select count(*) as NumOfEmployee
from EMPLOYEE
where year(Hire_Date) = 1985
and month(Hire_Date) = 3


--12. Which is the Department ID having greater than or equal to 3 employees joining in April 1985?
select DEPARTMENT_ID
from EMPLOYEE
where year(Hire_Date) = 1985
and month(Hire_Date) = 4
group by DEPARTMENT_ID
having count(*)>=3

--Joins:
--1. List out employees with their department names.
select concat(FIRST_NAME,' ', LAST_NAME) as EmployeeName,
D.Name as DepartmentName
from EMPLOYEE E, DEPARTMENT D
where E.DEPARTMENT_ID = D.Department_Id

--2. Display employees with their designations. 
select concat(FIRST_NAME,' ', LAST_NAME) as EmployeeName,
J.Designation
from EMPLOYEE E, JOB J
where E.JOB_ID = J.JOB_ID


--3. Display the employees with their department names and regional groups.
select concat(FIRST_NAME,' ', LAST_NAME) as EmployeeName,
D.Name as DepartmentName, 
L.City as RegionalGroup
from EMPLOYEE E, DEPARTMENT D, LOCATION L
where E.DEPARTMENT_ID = D.Department_Id
and D.Location_Id = L.Location_ID


--4. How many employees are working in different departments? Display with department names.
select D.Name as DepartmentName,
count(*) as NumOfEmployee
from EMPLOYEE E, DEPARTMENT D
where E.DEPARTMENT_ID = D.Department_Id
group by D.Name

--5. How many employees are working in the sales department?
select count(*) as NumOfEmployee
from EMPLOYEE E, DEPARTMENT D
where E.DEPARTMENT_ID = D.Department_Id
and D.Name = 'Sales'

--6. Which is the department having greater than or equal to 5 employees? Display the department names in ascending order.
select D.Name as DepartmentName
from EMPLOYEE E, DEPARTMENT D
where E.DEPARTMENT_ID = D.Department_Id
group by D.Name
having count(*) >=5

--7. How many jobs are there in the organization? Display with designations. 
select D.Name, J.Designation, count(*) as NumberOfJobs
from EMPLOYEE E, JOB J, DEPARTMENT D
where E.JOB_ID = J.JOB_ID
and D.Department_Id = E.DEPARTMENT_ID
group by D.Name, J.Designation

----------------------------------
select Designation,
count(*) as NumberOfJobs
from JOB
group by rollup(Designation)

--8. How many employees are working in "New York"?
select count(*) as NumberOfEmployee
from EMPLOYEE E, DEPARTMENT D, LOCATION L
where E.DEPARTMENT_ID = D.Department_Id
and D.Location_Id = L.Location_ID
and L.City = 'New York'

--9. Display the employee details with salary grades. Use conditional statement to create a grade column.
select *, case
              when salary>2500 then 'A'
			  when salary between 2000 and 2500 then 'B'
			  when salary between 1500 and 2000 then 'C'
			  else 'D'
		  end as Salary_Grade
from EMPLOYEE

--10. List out the number of employees grade wise. Use conditional statement to create a grade column.
with salary_grade_tables as
(
select *, case
              when salary>2500 then 'A'
			  when salary between 2000 and 2500 then 'B'
			  when salary between 1500 and 2000 then 'C'
			  else 'D'
		  end as Salary_Grade
from EMPLOYEE
)
select Salary_Grade, 
count(*) as NumberOfEmployee
from  salary_grade_tables
group by Salary_Grade

--11.Display the employee salary grades and the number of employees between 2000 to 5000 range of salary.
with salary_grade_tables as
(
	select *, case
              when salary>2500 then 'A'
			  when salary between 2000 and 2500 then 'B'
			  when salary between 1500 and 2000 then 'C'
			  else 'D'
		  end as Salary_Grade
	from EMPLOYEE
)

	select Salary_Grade, 
	count(*) as NumberOfEmployee
	from  salary_grade_tables
	where salary between 2000 and 5000
	group by Salary_Grade

--12. Display all employees in sales or operation departments. 
select concat(FIRST_NAME,' ', LAST_NAME) as EmployeeName
from EMPLOYEE E, DEPARTMENT D
where E.DEPARTMENT_ID = D.Department_Id
and D.Name in ('Sales', 'Operations')


--SET Operators:
--1. List out the distinct jobs in sales and accounting departments.
select distinct(Designation)
from EMPLOYEE E, JOB J, DEPARTMENT D
where E.JOB_ID = J.JOB_ID
and D.Department_Id = E.DEPARTMENT_ID
and D.Name in ('Sales', 'Accounting')

--2. List out all the jobs in sales and accounting departments.
select Designation
from EMPLOYEE E, JOB J, DEPARTMENT D
where E.JOB_ID = J.JOB_ID
and D.Department_Id = E.DEPARTMENT_ID
and D.Name in ('Sales', 'Accounting')

--3. List out the common jobs in research and accounting departments in ascending order. 

with common_jobs as
(
select Designation
from EMPLOYEE E, JOB J, DEPARTMENT D
where E.JOB_ID = J.JOB_ID
and D.Department_Id = E.DEPARTMENT_ID
and D.Name = 'Research'

intersect

select Designation
from EMPLOYEE E, JOB J, DEPARTMENT D
where E.JOB_ID = J.JOB_ID
and D.Department_Id = E.DEPARTMENT_ID
and D.Name = 'Accounting'
)
select Designation from common_jobs
order by Designation


--Subqueries:
--1. Display the employees list who got the maximum salary.
select concat(FIRST_NAME,' ', LAST_NAME) as EmployeeName
from EMPLOYEE 
where salary in (select max(salary) from EMPLOYEE)


--2. Display the employees who are working in the sales department.
select concat(FIRST_NAME,' ', LAST_NAME) as EmployeeName
from EMPLOYEE
where DEPARTMENT_ID in (select DEPARTMENT_ID
from DEPARTMENT
where Name = 'Sales')

--3. Display the employees who are working as 'Clerk'.
select concat(FIRST_NAME,' ', LAST_NAME) as EmployeeName
from EMPLOYEE
where JOB_ID in (select JOB_ID
from JOB
where Designation = 'Clerk')


--4. Display the list of employees who are living in "New York".
select concat(FIRST_NAME,' ', LAST_NAME) as EmployeeName
from EMPLOYEE E, DEPARTMENT D, LOCATION L
where E.DEPARTMENT_ID = D.Department_Id
and D.Location_Id = L.Location_ID
and L.City = 'New York'

--5. Find out the number of employees working in the sales department. 
select count(*) as EmployeeNumber
from EMPLOYEE
where DEPARTMENT_ID in (select DEPARTMENT_ID
from DEPARTMENT
where Name = 'Sales')

--6. Update the salaries of employees who are working as clerks on the basis of 10%. 

update EMPLOYEE
set salary = 1.1 * (select salary
	from EMPLOYEE
	where JOB_ID in (select JOB_ID
	from JOB
	where Designation = 'Clerk'))
where JOB_ID in (select JOB_ID
from JOB
where Designation = 'Clerk')

--7. Delete the employees who are working in the accounting department. 
delete EMPLOYEE
where DEPARTMENT_ID in (select DEPARTMENT_ID
from DEPARTMENT
where Name = 'Accounting')

--8. Display the second highest salary drawing employee details. 
select * from EMPLOYEE
where salary in
(
select max(salary)
from employee
where salary 
	not in (select max(salary)
	from employee))

--9. Display the nth highest salary drawing employee details. 

--Considering n = 5 in below example

select * from employee
where salary in
(
	select top 1 salary 
	from employee
	where salary in
		(select top 5 salary
		from employee
		order by salary desc)
	order by salary
)

--10. List out the employees who earn more than every employee in department 30.
select concat(FIRST_NAME,' ', LAST_NAME) as EmployeeName
from employee
where salary in 
	(select max(salary) 
	from employee
	where DEPARTMENT_ID = 30)


--11. List out the employees who earn more than the lowest salary in department.
select concat(FIRST_NAME,' ', LAST_NAME) as EmployeeName
from employee
where salary in 
     (select min(salary) 
	 from employee
	 where salary not in(
		(select min(salary) 
		from employee)))

--12. Find out which department has no employees.

select Name from
DEPARTMENT D
LEFT JOIN EMPLOYEE E
on D.Department_Id = E.DEPARTMENT_ID
where EMPLOYEE_ID is null

--13. Find out the employees who earn greater than the average salary for their department.
with average_salary_details_by_dept as
	(select DEPARTMENT_ID as DEPARTMENT_ID_, 
	avg(salary) as AverageSalary
	from employee
	group by DEPARTMENT_ID)

select concat(FIRST_NAME,' ', LAST_NAME) as EmployeeName
	from employee e, average_salary_details_by_dept asdbd
	where e.department_id = asdbd.DEPARTMENT_ID_
	and Salary > AverageSalary