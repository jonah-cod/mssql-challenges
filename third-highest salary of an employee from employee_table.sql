create schema staff;


CREATE TABLE staff.employees(
    employee_id int PRIMARY KEY IDENTITY(1,1), 
    first_name varchar(255)null,
    last_name varchar(255)null,
    salary decimal(10,2) null
)

insert into staff.employees(first_name, last_name, salary)
select  s.first_name,s.last_name, p.list_price
from sales.customers s, production.products p

select Top 10000 * from staff.employees

-- first solution 

-- Find the employees with top N distinct salaries.
-- Find the lowest salary among the salaries fetched by the above query, this will give us the Nth highest salary.
-- Find the details of the employee whose salary is the lowest salary fetched by the above query.

SELECT * FROM staff.employees WHERE salary = 
         (
            SELECT MIN(salary) FROM staff.employees
            WHERE  salary IN (
                                 SELECT DISTINCT TOP 1
                                     salary FROM staff.employees 
                                         ORDER BY salary DESC
                             )
        )

-- alternative


SELECT TOP 1 salary 
FROM (  
      SELECT DISTINCT TOP 3 salary  
      FROM staff.employees  
      ORDER BY salary DESC  
      ) RESULT  
ORDER BY salary  