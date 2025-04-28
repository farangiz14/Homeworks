--HOMEWORK 15--

---Easy Tasks--
--1. Create a numbers table using a recursive query.
with numbers as(
select 1 as num
union all
select num + 1
from numbers
where num < 10
)

select * from numbers
OPTION (MAXRECURSION 0);

--2. Beginning at 1, this script uses a recursive statement to double the number for each record
WITH DoubleNum AS (
    SELECT 1 AS num     
    UNION ALL
    SELECT num * 2      
    FROM DoubleNum
    WHERE num < 100     
)
SELECT *
FROM DoubleNum

--3. Write a query to find the total sales per employee using a derived table.(Sales, Employees)
SELECT 
   concat(firstname, ' ' , lastname),
   (select sum(salesamount)
	from sales s
		where s.employeeid = e.EmployeeID) AS TotalSales
FROM Employees e;

--4. Create a CTE to find the average salary of employees.(Employees)

with avg_sal as(
select avg(salary) as average_salary
from employees
)

select * from avg_sal 

--5. Write a query using a derived table to find the highest sales for each product.(Sales, Products)
select productname,
		(select max(salesamount) 
			from sales s
			where s.productid = p.productid) as highest_sales 
from products p

--6. Use a CTE to get the names of employees who have made more than 5 sales.(Sales, Employees)
with sales5 as(
	select 
	employeeid,
	concat(firstname, ' ', lastname) as employee
from employees
),

sales_count as(
	select 
	employeeid,
	count(salesamount) as total_sales
from sales 
group by employeeid
)

select s5.employee
from sales5 s5
join sales_count sc
on sc.employeeid = s5.employeeid
where sc.total_sales > 5;

--7. Write a query using a CTE to find all products with sales greater than $500.(Sales, Products)

with cte_prod as(
select productid, productname as products
from products
),

sales500 as(
select productid, salesamount
from sales 
)

select salesamount, products
from sales500 s
join cte_prod p
on p.productid = s.productid
where salesamount > 500;

--8. Create a CTE to find employees with salaries above the average salary.(Employees)
with avg_salary as(
	select
		avg(salary) as avg_sal
	from employees
				)
select concat( firstname, ' ', lastname) as employee, e.salary, employeeid
from employees e
cross join avg_salary e2
where e.salary > avg_sal

--9. Write a query to find the total number of products sold using a derived table.(Sales, Products)
select productname,
		(select count(productid)
		from sales s
		where s.productid = p.productid
		) as units_sold
from products p;

--10. Use a CTE to find the names of employees who have not made any sales.(Sales, Employees)
with cte_emp as(
	select concat(firstname, ' ', lastname) as employee, employeeid
	from employees
				)

select salesamount, employee
from sales s
join cte_emp c
on c.employeeid = s.employeeid
where salesamount = 0; 

-- Medium Tasks --

--1. This script uses recursion to calculate factorials
WITH  FactorialCTE AS (
    SELECT 1 AS Number, 1 AS Factorial
    UNION ALL
    SELECT Number + 1, Factorial * (Number + 1)
    FROM FactorialCTE
    WHERE Number < 5 
)
SELECT Factorial
FROM FactorialCTE
WHERE Number = 5; 

--2. This script uses recursion to calculate Fibonacci numbers
--3. This script uses recursion to split a string into rows of substrings for each character in the string.(Example)
--4. Create a CTE to rank employees based on their total sales.(Employees, Sales)
with tsales as(
select concat(firstname,' ', lastname) as name, sum(salesamount) as sales 
from Employees e
join sales s
on s.employeeid = e.EmployeeID
group by FirstName, LastName
)

select name, sales,
rank() over(order by sales desc) as salesrank
from tsales

--5. Write a query using a derived table to find the top 5 employees by the number of orders made.(Employees, Sales)
select top 5 concat(firstname,' ', lastname) as name,
	(select top 5 sum(salesamount)
	from sales s
	join Employees
	on e.EmployeeID = s.employeeid
	) as sales
from Employees e
order by sales desc;


--6. Use a CTE to calculate the sales difference between the current month and the previous month.(Sales)
with monthlysales as(
	select format(saledate, 'yyyy-MM') as sdate,
		sum(salesamount) as total_sales
	from sales
	group by format(saledate, 'yyyy-MM') 
					)
select sdate, 
		total_sales, 
		total_sales - lag(total_sales) over(order by sdate) as sale_diff
from monthlysales;

--7. Write a query using a derived table to find the sales per product category.(Sales, Products)
select productname, CategoryID,
		(select sum(salesamount)
		from sales s
		join Products
		on p.productid = s.productid) as sales		
from products p

--8. Use a CTE to rank products based on total sales in the last year.(Sales, Products)
with rank_prod as (
					select year(saledate) as years,
						sum(salesamount) as sales
					from sales
					group by year(saledate)
					)
select years, sales, sales - lag(sales) over(order by years desc) as sale_diff,
rank() over(order by sales desc) as sales_ranl
from rank_prod

--9. Create a derived table to find employees with sales over $5000 in each quarter.(Sales, Employees)
select 
	concat(firstname,' ', lastname) as name,
		    t.sum_sale
from Employees e 
join
	(select s.employeeid,
			sum(salesamount) as sum_sale 
		from sales s
		group by s.employeeid 
		having sum(s.salesamount) > 5000
		) as t
		on e.employeeid = t.employeeid


--10. Use a derived table to find the top 3 employees by total sales amount in the last month.(Sales, Employees)
select top 3
	concat(firstname,' ', lastname) as name,
	(select sum(salesamount)
	from sales s
	join employees 
	on e.employeeid = s.employeeid) as total_sales
from employees e

	
