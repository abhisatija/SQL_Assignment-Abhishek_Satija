use HRDB;


 -- Assignment on HRDB 
 
 -- Question 1-1)
select * from employees;

 -- Question 1-2)
select * from departments;

 -- Question 1-3)
select concat(first_name, ', ', job_id) as 'Employee and Title' from employees;
 
 -- Question 1-4)
select hire_date, first_name, department_id from employees
where job_id = 'PU_CLERK';

 -- Question 1-5)
select concat_ws(', ', employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
as 'THE OUTPUT' from employees;

 -- Question 1-6)
select first_name, salary from employees
where salary > 2000;

 -- Question 1-7)
select first_name as 'Name',
hire_date as 'Start Date' from employees;

 -- Question 1-8)
select first_name as 'Name',
hire_date as 'Start Date' from employees
order by hire_date;

 -- Question 1-9)
select first_name as 'Name',
salary as 'Salary' from employees
order by salary desc;

 -- Question 1-10)
select first_name as 'Name',
department_id as 'Dept',
salary as 'Salary' from employees
where commission_pct is not null
order by salary desc;

 -- Question 1-11)
select last_name, job_id from employees
where manager_id is null;

 -- Question 1-12)
select last_name, job_id, salary from employees
where (job_id = 'SA_REP' or job_id ='ST_CLERK') &&
(salary <> '2500' && salary <> '3500' && salary <> '5000');

-- ----------------------------------------------------------------------------------------------------------

 -- Question 2-1)
select min(salary), max(salary), avg(salary) from employees
where commission_pct is not null;

 -- Question 2-2)
select department_id, sum(salary) as 'Total salary payout', sum(commission_pct*salary) as 'Total commission payout' from employees
group by department_id;

 -- Question 2-3)
select department_id, count(employee_id) as 'Number of employees' from employees
group by department_id;

 -- Question 2-4)
select department_id, sum(salary) as 'Total salary' from employees
group by department_id;

 -- Question 2-5)
select first_name from employees
where commission_pct is null order by 1;

 -- Question 2-6)
select first_name 'Name', department_id 'Dept ID', ifnull(commission_pct, 'No commission') 'Commission' from employees;

 -- Question 2-7)
select first_name 'Name', salary 'Salary', ifnull(commission_pct*2, 'No commission') 'Commission' from employees;

 -- Question 2-8)
select distinct e1.first_name, e1.department_id
from employees e1
join employees e2 on e1.first_name = e2.first_name
				and e1.employee_id <> e2.employee_id
                and e1.department_id = e2.department_id
order by e1.department_id, e1.first_name;

 -- Question 2-9)
select manager_id, sum(salary) as 'Total salary' from employees
group by manager_id;

 -- Question 2-10)
select concat(m.first_name, ' ', m.last_name) as Manager_name,
count(e.employee_id) as Employee_count,
m.department_id as Manager_department_id
from employees m
join employees e on m.employee_id = e.manager_id
group by m.employee_id, m.first_name, m.last_name, m.department_id
order by Manager_name;

 -- Question 2-11)
select concat(m.first_name, ' ', m.last_name) as Manager_name,
e.first_name 'Employee name', e.department_id, e.salary
from employees e
join employees m on m.employee_id = e.manager_id
where substring(e.last_name, 2, 1) = 'a'
order by Manager_name;

-- Quetion 2-12)
select department_id, avg(salary) from employees
group by department_id
order by department_id;

-- Question 2-13)
select department_id, max(salary) from employees
group by department_id
order by department_id;

-- Question 2-14)
-- using case statement
select 
    commission_pct,
    case
        when commission_pct is null then 1
        else 0.1 * salary
    end as calculated_commission
from employees;

-- using if function
select 
    commission_pct,
    if(commission_pct is null, 1, 0.1 * salary) as calculated_commission
from employees;

-- ------------------------------------------------------------------------------

-- Question 3-1)
select concat(upper(substring(last_name, 2, 1)), lower(substring(last_name, 3, 3))) 'Modified Last name' from employees;

-- Question 3-2)
select first_name, last_name, month(hire_date),
concat(first_name, '-', last_name) from employees;

-- Quention 3-3)
-- with if function
select last_name as 'Employee Last Name',
	if(salary*0.5 > 10000,
    salary+salary*0.1 + 1500,
    salary+salary*0.115 + 1500) as 'Adjusted Salary with Bonus'
    from employees;
    
-- with case staement
SELECT 
    last_name AS "Employee Last Name",
    CASE
        WHEN salary * 0.5 > 10000 THEN ROUND(salary * 1.1 + 1500, 2)
        ELSE ROUND(salary * 1.115 + 1500, 2)
    END AS "Adjusted Salary with Bonus"
FROM employees;

-- Question 3-4)
select ID, A, B, replace(Manager_name, 'Z', '$')
from (select concat(substring(e1.employee_id, 1, 2), '00', substring(e1.employee_id, 3,1), 'E') as 'ID',
	e1.department_id as 'A',
	e1.salary as 'B',
	upper(concat(e2.first_name, ' ', e2.last_name)) as Manager_name
	from employees e2 join employees e1
	on e1.employee_id = e2.manager_id) as sub;
    
-- Question 3-5)
-- with the help of case statement
select last_name 'Last Name',
case
	when last_name like 'M%' or
    last_name like 'J%' or
    last_name like 'A%' then length(last_name)
    else '-'
end as 'Name Length'
from employees
order by last_name;

-- Without case statement
SELECT 
    CONCAT(UPPER(SUBSTRING(last_name, 1, 1)), LOWER(SUBSTRING(last_name, 2))) AS Capitalized_Last_Name,
    LENGTH(last_name) AS Name_Length
FROM 
    employees
WHERE 
    last_name LIKE 'J%' OR
    last_name LIKE 'A%' OR
    last_name LIKE 'M%'
ORDER BY 
    last_name;
    
-- Question 3-6)
select last_name 'Last Name',
lpad(salary, 15, '$') 'SALARY' from employees;

-- Question 3-7)
select first_name from employees
where first_name = reverse(first_name);

-- Question 3-8)
select first_name from employees;

-- if the name with initial were not in capital then use this:
select concat(upper(substring(first_name, 1, 1)), lower(substring(first_name, 2))) 'First Name' from employees;

-- Question 3-9)
select * from locations;

SELECT 
    SUBSTRING(
        SUBSTRING_INDEX(STREET_ADDRESS, ' ', 3), 
        LOCATE(' ', STREET_ADDRESS) + 1, 
        LOCATE(' ', SUBSTRING_INDEX(STREET_ADDRESS, ' ', 3), LOCATE(' ', STREET_ADDRESS) + 1) - LOCATE(' ', STREET_ADDRESS) - 1
    ) AS Middle_Word
FROM 
    LOCATIONS;
    
-- Question 3-10)
select first_name, lower(concat(substring(first_name, 1, 1), replace(last_name, ' ', ''), '@systechusa.com')) 'E-mail Address' from employees;

-- Question 3-11)
select * from jobs;

select first_name, job_title from employees
join jobs on
jobs.job_id = employees.job_id
where employees.job_id = (select job_id from employees where first_name = 'Trenna');

-- Question 3-12)
select * from locations;

-- Without using emp detailed view
select e.first_name, d.department_name from employees e
join departments d on e.department_id = d.department_id
join locations l ON d.location_id = l.location_id
where l.city = (select l2.city 
              from employees e2
              join departments d2 on e2.department_id = d2.department_id
              join locations l2 on d2.location_id = l2.location_id
              where e2.first_name = 'Trenna');

select * from emp_details_view;

-- With using emp detailed view
select first_name, department_name from emp_details_view
where city = (select city 
            from emp_details_view 
            where first_name = 'Trenna');
            
-- Question 3-13)
select first_name, salary from employees
order by salary limit 1;

-- Question 3-14)
select first_name, salary from employees
where salary > (select min(salary) from employees);

-- -------------------------------------------------------------------------------------------------------------------
select * from employees;
-- Question 4-1)
select e.last_name, d.department_id, d.department_name from employees e
join departments d on d.department_id = e.department_id;

-- Question 4-2)
select j.job_title, l.city from jobs j
join employees e on e.job_id = j.job_id
join departments d on d.department_id = e.department_id
join locations l on l.location_id = d.location_id
where e.department_id = 40;

-- Question 4-3)
select e.last_name, d.department_name, l.location_id, l.city from employees e
join departments d on d.department_id = e.department_id
join locations l on l.location_id = d.location_id
where e.commission_pct is not null;

-- Question 4-4)
select e.last_name, d.department_name from employees e
join departments d on d.department_id = e.department_id
where e.last_name like '%a%';

-- Question 4-5)
select e.last_name, j.job_title, d.department_id, d.department_name from employees e
join departments d on d.department_id = e.department_id
join jobs j on j.job_id = e.job_id
join locations l on l.location_id = d.location_id
where l.city = 'ATLANTA';

-- Question 4-6)
select e.employee_id 'Employee id', e.last_name 'Employee name', e.manager_id 'Manager id', m.last_name 'Manager name' from employees e
join employees m on e.manager_id = m.employee_id;

-- Question 4-7)
select e.employee_id 'Employee id', e.last_name 'Employee name', e.manager_id 'Manager id', m.last_name 'Manager name' from employees e
left join employees m on e.manager_id = m.employee_id;

-- Question 4-8)
select e1.last_name as employee_last_name, e1.department_id as department_number, e2.last_name as colleague_last_name from employees e1
join employees e2 on e1.department_id = e2.department_id and e1.employee_id != e2.employee_id
order by e1.department_id, e1.last_name, e2.last_name;

-- Question 4-9)
-- with case statement
select e.first_name, j.job_title, d.department_name, e.salary,
case
	when salary >= 5000 then 'A'
    when salary >= 3000 then 'B'
    else 'C'
end as 'Grade'
from employees e
join departments d on e.department_id = d.department_id
join jobs j on e.job_id = j.job_id;

-- with if conditions
select e.first_name, j.job_title, d.department_name, e.salary,
if(salary >= 5000, 'A', if(salary >= 3000, 'B', 'C')) as 'Grade'
from employees e
join departments d on e.department_id = d.department_id
join jobs j on e.job_id = j.job_id;

-- Question 4-10)
select e.hire_date 'Employee Hire Date', e.last_name 'Employee name', m.hire_date 'Manager Hire Date', m.last_name 'Manager name' from employees e
join employees m on e.manager_id = m.employee_id
where e.hire_date < m.hire_date;

-- --------------------------------------------------------------------------------------------------------------------------

-- Question 5-1)
select e.last_name, e.hire_date from employees e
join departments d on e.department_id = d.department_id
where d.department_name = 'Sales';

-- Question 5-2)
select employee_id, last_name from employees
where salary > (select avg(salary) from employees) 
order by salary asc;

-- Question 5-3)
-- With sub query
select last_name, emplyoee_id from employees
where department_id in
(select id from (select last_name, department_id as id from employees
where last_name like "%u%") as sub);

-- with self join
SELECT 
    e1.employee_id AS employee_number, 
    e1.last_name AS employee_last_name
FROM 
    employees e1
WHERE 
    e1.department_id IN (
        SELECT 
            e2.department_id
        FROM 
            employees e2
        WHERE 
            e2.last_name LIKE '%u%'
    )
ORDER BY 
    e1.department_id, e1.employee_id;
    
-- Question 5-4)
select e.last_name, j.job_id, d.department_id from employees e
join departments d on d.department_id = e.department_id
join jobs j on j.job_id = e.job_id
join locations l on l.location_id = d.location_id
where l.city = 'ATLANTA';

-- Question 5-5)
-- with Sub Query
select last_name, salary from employees
where manager_id = (select employee_id from employees where last_name = 'Fillmore');

-- With Self join
SELECT 
    e.last_name AS employee_last_name,
    e.salary AS employee_salary
FROM 
    employees e
JOIN 
    employees m 
ON 
    e.manager_id = m.employee_id
WHERE 
    m.last_name = 'FILLMORE';
    
-- Question 5-6)
select e.department_id, e.last_name, e.job_id from employees e
join departments d on d.department_id = e.department_id
where d.department_name = 'Operations';

-- Question 5-7)
select employee_id, last_name, salary from employees
where salary > (select avg(salary) from employees) and
department_id in (select id from (select department_id as id from employees
where last_name like "%u%") as sub);

-- Question 5-8)
-- with in function
select first_name from employees
where job_id in (select job_id from employees e
					join departments d on e.department_id = d.department_id
                    where d.department_name = 'Sales');

-- With joining
select e.first_name from employees e
join departments d on d.department_id = e.department_id
where department_name = 'Sales';

-- Question 5-9)
select employee_id, salary,
case
	when department_id = 10 or department_id = 30 then '5%'
    when department_id = 40 or department_id = 50 then '15%'
    when department_id = 20  then '10%' 
    when department_id = 60 then 'No raise'
    else '-'
end as 'Raise Percentage',
salary * (1 + case
				when department_id in (10, 30) then 0.05
                when department_id = 20 then 0.10
                when department_id in (40, 50) then 0.15
                when department_id = 60 then 0.00
                else 0.00
end) as new_salary
from employees;

-- Question 5-10)
select last_name, salary from employees
order by salary desc limit 3;

-- Question 5-11)
select first_name, salary, ifnull(commission_pct, 0) as 'Commission'  from employees;

-- Question 5-12)
select concat(m.first_name, ' ', m.last_name) as Manager_name, m.salary, d.department_name from employees m
join employees e on m.employee_id = e.manager_id
join departments d on d.department_id = m.department_id
group by manager_name, salary, d.department_name
order by salary desc limit 3;


-- Question 6-1)
create table practice_date (
Emp_id int not null,
hire_date date,
Resignation_date date);

insert into practice_date (Emp_ID, Hire_Date, Resignation_Date)
values
    (1, '2000-01-01', '2013-10-07'),
    (2, '2003-12-04', '2017-08-03'),
    (3, '2012-09-22', '2015-06-21'),
    (4, '2015-04-13', NULL),
    (5, '2016-06-03', NULL),
    (6, '2017-08-08', NULL),
    (7, '2016-11-13', NULL);
    
select * from practice_date;
    
select datediff(resignation_date, hire_date) from practice_date;

SELECT concat(
        TIMESTAMPDIFF(YEAR, hire_date, resignation_date), ' year(s) ', 
        TIMESTAMPDIFF(MONTH, DATE_ADD(hire_date, INTERVAL TIMESTAMPDIFF(YEAR, hire_date, Resignation_date) YEAR), resignation_date), ' month(s) ', 
        DATEDIFF(Resignation_date, DATE_ADD(DATE_ADD(Hire_date, INTERVAL TIMESTAMPDIFF(YEAR, hire_date, Resignation_date) YEAR), INTERVAL TIMESTAMPDIFF(MONTH, DATE_ADD(hire_date, INTERVAL TIMESTAMPDIFF(YEAR, hire_date, Resignation_date) YEAR), Resignation_date) MONTH)), ' day(s)'
    ) AS date_difference
from practice_date;

-- Question 6-2)

select date_format(hire_date, '%m/%d/%Y'),
ifnull(date_format(resignation_date, '%b %D, %Y'), 'Dec, 01th 1900') from practice_date;

-- Question 6-3)
select concat(
timestampdiff(year, hire_date, resignation_date), ' Year ',
timestampdiff(month, date_add(hire_date, interval timestampdiff(year, hire_date, resignation_date) year), resignation_date),  ' Month') 'Experiance' from practice_date;

-- Use Getdate() as input date for the below three questions.
-- Question 6-4)

SELECT 
    DATEDIFF(
        DATE_SUB(DATE_ADD(MAKEDATE(YEAR(NOW()), 1), INTERVAL QUARTER(NOW())*3 MONTH), INTERVAL 3 MONTH),
        DATE_SUB(DATE_ADD(MAKEDATE(YEAR(NOW()), 1), INTERVAL QUARTER(NOW())*3 MONTH), INTERVAL 6 MONTH)
    ) AS days_in_previous_quarter;
    
-- Question 6-5)   
    SELECT 
    DATE_ADD(
        DATE_SUB(
            MAKEDATE(YEAR(NOW()), 1) + INTERVAL (QUARTER(NOW()) - 1) * 3 MONTH, 
            INTERVAL (WEEK(MAKEDATE(YEAR(NOW()), 1) + INTERVAL (QUARTER(NOW()) - 1) * 3 MONTH) - 2) * 7 DAY
        ), 
        INTERVAL 1 DAY
    ) AS previous_quarter_second_week_first_day;
    
-- Question 6-6)


-- Question 6-7)
WITH last_day_january AS (
    SELECT DATE('2015-01-31') AS last_day
)
SELECT 
    DATE_SUB(last_day, INTERVAL WEEKDAY(last_day) + 1 DAY) AS last_saturday
FROM 
    last_day_january;