-- postgresql

-- 1. From the following tables write a SQL query to find the details of an employee. Return full name, email, salary, Department Name, postal code, and City.

select CONCAT  (first_name, ' ', last_name) AS "Full name",
emp.email, emp.salary, dept.department_name, loc.pincode as "postal code" , 
loc.city as City from employees emp join departments dept on emp.department_id = dept.department_id
join locations loc on dept.location_id = loc.location_id;


-- 2. From the following tables write a SQL query to find the departments whose location is in "Jammu Kashmir" or "Jharkhand". Return Department Name, state_province, street_address.

select dept.department_name, loc.state_province, loc.street_address 
from departments dept inner join locations loc on 
dept.location_id = loc.location_id
where loc.city in ('Jharkhnad','Jammu Kashmir');  


-- 3. From the following tables write a SQL query to find the count of employees present in different jobs whose average salary is greater than 10,000. Return all the jobs with employee count, Job Name, and average salary.

select count(emp.employee_id), j.job_title, avg(emp.salary) from employees emp inner join jobs j on
emp.job_id = j.job_id 
group by j.job_id having avg(emp.salary) > 10000;

-- 4.From the following table write a SQL query to find all the first_names and last_names in both dependents and employees tables. Return the duplicate records as well and order the records in descending order of the last_name column.

select first_name,last_name from employees 
union
select first_name,last_name from dependents order by last_name desc;


-- 5.From the following table write a SQL query to list every employee that has a manager with the name of his or her manager. 

select emp.first_name as employee_first_name, emp.last_name as employee_last_name,
mgr.first_name as manager_first_name,mgr.last_name as manager_last_name 
from employees emp INNER JOIN employees mgr 
on emp.manager_id = mgr.employee_id;

-- 6. Find the departments that have more than 5 employees earning a salary greater than  50,000 and are located in either New York or California. Include the department name, location, and the number of employees meeting the criteria.

select dept.department_name,loc.city,count(emp.employee_id) as total_emp from employees emp inner join departments dept 
on emp.department_id = dept.department_id inner join locations loc on dept.location_id = loc.location_id 
where emp.salary > 50000 and loc.city in ('New York','California') group by dept.department_name, loc.city
havig count(emp.employee_id) > 5;

-- 7.List any employees who have dependents and have a job title that includes the word 'manager', and sort the results by department name in ascending order.

SELECT emp.employee_id, jb.job_title, dept.department_name FROM employees emp INNER JOIN dependents dept ON dept.employee_id = emp.employee_id INNER JOIN jobs jb ON 
jb.job_id = emp.job_id INNER JOIN departments dept ON dept.department_id = emp.department_id WHERE jb.job_title LIKE '%manager%' ORDER BY dept.department_name;



-- 8.Add a column in the dependent table called “city” depicting their current location of
-- stay. 

alter table dependents add COLUMN city varchar(255);

update dependents set city = 'KOLKATA' where dependent_id in (1,3,5);
update dependents set city = 'DELHI' where dependent_id in (2,4);

-- Find all employees who have been hired in the past 3 years and have dependents
-- living in a city that is different from the city they work in (if I work in Kolkata, then my
-- dependent should not be in Kolkata).

select emp.employee_id, dp.city, dept.department_name, loc.city from employees emp inner join 
dependents dp on dp.employee_id = emp.employee_id inner join departments dept on dept.department_id = emp.department_id 
inner join locations loc on loc.location_id = dept.location_id where dp.city != loc.city and emp.hire_date >= current_date - interval '3 years';

-- Additionally, only include employees whose salary is greater than the average salary of
-- their job title(suppose, my job_title is ”developer” and the salary is 80k, and the average
-- salary under the same job_title “developer” is 70k), and whose manager's job title
-- includes the word 'director'. Finally, include the department name and location of each
-- employee, and sort the results by department name in ascending order

select e.employee_id,dp.city,d.department_name,l.city from employees e 
inner join dependents dp on dp.employee_id = e.employee_id 
inner join jobs j on e.job_id = j.job_id 
inner join (select m.employee_id,j.job_title manager_job_title from  employees m inner join jobs j 
on m.job_id = j.job_id) manager on manager.employee_id = e.employee_id
inner join departments d on d.department_id = e.department_id 
inner join locations l on l.location_id = d.location_id 
inner join(select j.job_title,AVG(e.salary) avg_salary from jobs j inner join employees e
on j.job_id = e.job_id group by j.job_title) job_avg on j.job_title = job_avg.job_title
where dp.city != l.city and e.hire_date >= current_date - interval '3 years' and e.salary > job_avg.avg_salary and manager.manager_job_title 
like '%director%' order by d.department_name;


