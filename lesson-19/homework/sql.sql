--# Lesson-19: Subqueries and Exists

--## Level 1: Basic Subqueries

--# 1. Find Employees with Minimum Salary
select *
from employees
where salary = (select min(Salary)
				from employees)
--# 2. Find Products Above Average Price
select *
from products
where price > (select avg(price)
				from products)

----## Level 2: Nested Subqueries with Conditions
--**3. Find Employees in Sales Department**
select * 
from employees
where department_id = (
	select d.id 
	from departments d
	where id = 1)

--# 4. Find Customers with No Orders
select * 
from customers c
where c.customer_id not in (select o.customer_id from orders o)


--## Level 3: Aggregation and Grouping in Subqueries

--# 5. Find Products with Max Price in Each Category
select * from products p2
where price = (select max(price) from products p1
				where p1.category_id = p2.category_id)

--# 6. Find Employees in Department with Highest Average Salary
SELECT top 1 *
FROM employees e
JOIN departments d ON e.department_id = d.id
WHERE e.department_id = (
    SELECT TOP 1 department_id
    FROM employees
    GROUP BY department_id
    ORDER BY AVG(salary) DESC
);



--## Level 4: Correlated Subqueries

--# 7. Find Employees Earning Above Department Average
select *
from employees e1
where salary > (select avg(salary) from employees e2
				where e2.department_id = e1.department_id)

drop table employees
select * from employees
select * from departments
select * from customers
select * from orders
select * from products

--## Level 5: Subqueries with Ranking and Complex Conditions
--# 10. Find Employees Between Company Average and Department Max Salary
select *
from employees e
where e.salary between (select avg(salary) from employees) and  (select max(salary) from employees where department_id = e.department_id)
