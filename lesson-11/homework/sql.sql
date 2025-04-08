--1--
select OrderID, concat(firstname, ' ', lastname) as CustomerName, OrderDate
from Orders o
join Customers c
on c.CustomerID = o.CustomerID
where YEAR(orderdate) > 2022;

--2--
select name as EmployeeName, DepartmentName
from Employees e
join Departments d
on d.departmentid = e.departmentid
where d.departmentname in ('sales', 'marketing');

--3--
select e.name as EmployeeName, 
		d.DepartmentName, 
		e.salary as MaxSalary
from Employees e
join Departments d
on d.departmentid = e.departmentid 
where e.salary = (
					select max(e2.salary) 
				from Employees e2
				where e2.departmentid = e.departmentid 
);

--4--
select CONCAT(firstname, ' ', lastname) as CustomerName, OrderID, OrderDate
from customers c
join orders o
on o.CustomerID = c.CustomerID	
where country = 'usa'
	and year(OrderDate) = 2023;

--5--
SELECT 
    CONCAT(c.firstname, ' ', c.lastname) AS customerName, 
    COUNT(o.OrderID) AS TotalOrders
FROM 
    customers c
JOIN 
    orders o 
ON o.CustomerID = c.CustomerID
GROUP BY 
    c.firstname, c.lastname;

--6--
select ProductName, SupplierName
from products p
join suppliers s
on s.supplierid = p.supplierid
where s.SupplierName in ('Gadget Supplies', 'Clothing Mart');

--7--
select concat(c.firstname, ' ' , c.lastname) as CustomerName, 
		o.orderdate as MostRecentOrderDate, 
		o.orderID
from customers c
right join orders o
on o.customerid = c.customerid
where o.orderdate = (
						select max(orderdate)
						from orders o2
						where o2.customerid = o.customerid
					);

--8--
select concat(c.firstname, ' ', c.lastname) as CustomerName, 
		o.OrderID, 
		sum(o.totalamount) as OrderTotal
from customers c 
join orders o
on o.customerid = c.customerid
group by c.customerid, c.firstname, c.lastname, o.orderid
having sum(o.totalamount) > 500;

--9--
select ProductName, SaleDate, SaleAmount
from products p
join sales s
on s.productid = p.productid
where year(saledate) = 2022
	and SaleAmount > 400;

--10--
select ProductName, sum(saleamount) as TotalSalesAmount
from Products p
join sales s
on s.productid = p.productid
group by ProductName;

--11--
select name as EmployeeName, DepartmentName, Salary
from Employees e
join Departments d
on e.departmentid = d.departmentid
where DepartmentName in ('human resources')
	and salary > 50000;

--12--
select ProductName, SaleDate, StockQuantity
from Products p
join Sales s
on p.productid = s.productid
where year(saledate) = 2023
	and StockQuantity > 50;

--13--
select name as EmployeeName, DepartmentName, HireDate
from Employees e
join Departments d
on d.departmentid = e.DepartmentID
where Departmentname = 'sales'
	or year(hiredate) > 2020;

--14--
select CONCAT(firstname, ' ' , LastName) as  CustomerName, OrderID, Address, OrderDate
from Customers c
join Orders o
on o.CustomerID = c.CustomerID
where country = 'usa'
	and address like '[0-9][0-9][0-9][0-9]%';

--15--
select ProductName, Category, SaleAmount
from Products p
join Sales s
on s.productid = p.productid
where category = 1
	or saleamount > 350;

--16--
select c.CategoryName, count(p.productname) as ProductCount
from Products p
join Categories c
on c.CategoryID = p.category
group by c.CategoryName;

--17--
select CONCAT(firstname, ' ', lastname) as CustomerName, City, OrderID, TotalAmount as Amount
from customers c
join Orders o
on o.CustomerID = c.CustomerID
where City = 'los angeles'
	and TotalAmount > 300;

--18--
select name as EmployeeName, DepartmentName
from Employees e
join Departments d
on d.departmentid = e.DepartmentID
where d.departmentname in ('hr', 'finance')
	or len(name) - len(replace(replace(replace(replace(replace(name, 'a', ''), 'e', ''), 'i', ''),'o',''), 'u', '')) >=4;

--19--
select p.ProductName, saleamount as QuantitySold, Price
from sales s
join Products p
on p.productid = s.productid
where saleamount > 100
	 and price > 500;

--20--
select name as EmployeeName, DepartmentName, Salary
from Employees e
join Departments d
on d.departmentid = e.DepartmentID
where Departmentname in ('sales', 'marketing')
	and salary > 60000;
