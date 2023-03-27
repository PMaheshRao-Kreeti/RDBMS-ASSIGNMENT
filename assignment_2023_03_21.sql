-- 3rd assignment
-- -- all query commands are in postgresql

-- 1. Write the query to get the department and department wise total(sum) salary, display it in ascending order according to salary.

select department_name , sum(salary) as Salary
from departments as dept, employees as emp 
where dept.department_id = emp.department_id
group by dept.department_id order by salary;

-- 2. Write the query to get the department, total no. employee of each department, total(sum) salary with respect to department from "Employee" table

select dept.department_name,count(*),sum(emp.salary) as total_salary
from departments as dept,employees as emp
where dept.department_id=emp.department_id
Group by dept.department_name;

-- 3. Get department wise maximum salary from "Employee" table order by salary ascending
select dept.department_name, max(salary) as "max_salary"
from employees as emp, departments as dept
where emp.department_id = dept.department_id
group by dept.department_id order by max_salary;


-- 4. Write a query to get the departments where average salary is more than 60k
select dept.department_name, avg(emp.salary) from employees as emp, departments as dept
where emp.department_id = dept.department_id
group by dept.department_id having avg(salary) > 60000;

-- 5. Write down the query to fetch department name assign to more than one Employee
select dept.department_name
from employees AS emp, departments AS dept
where emp.department_id = dept.department_id
group by emp.department_id, dept.department_name
having COUNT(*) > 1;

-- 6. Write a query to show department_name and assignedTo where assignedTo will be “One candidate” if its assigned to only one employee otherwise “Multiple candidates”
select dept.department_name,
case
  when count(*) = 1 then 'One Candidate'
  else 'Multiple Candidate'
end as assignedTO
from employees as emp, departments as dept
where emp.department_id = dept.department_id
group by emp.department_id, dept.department_name;

