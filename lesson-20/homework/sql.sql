--create database [homework-20]
--use [homework-20]


--# 1. Find customers who purchased at least one item in March 2024 using EXISTS
select * from #Sales s1
where exists (select 1 from #Sales s2 where s1.SaleID = s2.SaleID 
and s2.SaleDate between '2024-03-01' AND '2024-03-31')


--# 2. Find the product with the highest total sales revenue using a subquery.
select SaleID,
		CustomerName,
		sum(quantity * price) as revenue,
		Product,
		SaleDate
	from #Sales 
	group by SaleID, CustomerName, Product, SaleDate
	having sum(quantity * price) = 
(select max(TotalRevenue) from
(select SaleID, sum(quantity * price) as TotalRevenue from #Sales group by SaleID) as ravenues)


--# 3. Find the second highest sale amount using a subquery
select max(SaleAmount) 
from (
	select sum(quantity * price) as SaleAmount 
	from #Sales 
	group by SaleID
) as SaleSums
where SaleAmount < (
	select max(SaleAmount) 
	from (
		select sum(quantity * price) as SaleAmount 
		from #Sales 
		group by SaleID
	) as AllSums
)


--# 4. Find the total quantity of products sold per month using a subquery
select year(SaleDate) as SaleYear,
		month(SaleDate) as SaleMonth,
	sum(quantity) as TotalQuantity
from #Sales 
group by year(SaleDate), month(SaleDate)
having  sum(quantity) = (select max(monthlyQuantity) from 
(select sum(quantity) as monthlyQuantity from #Sales group by year(SaleDate), month(SaleDate)
) as Monthlysums
)


--# 5. Find customers who bought same products as another customer using EXISTS
select * from #Sales s
where EXISTS (select 1 from #Sales s2
where s.product = s2.product
and s.CustomerName != s2.CustomerName)


--# 6. Return how many fruits does each person have in individual fruit level
;
select distinct name,
(select count(*) from Fruits f2 where f1.name = f2.name and f2.Fruit = 'Apple') as Apple,
(select count(*) from Fruits f2 where f1.name = f2.name and f2.Fruit = 'Orange') as Orange,
(select count(*) from Fruits f2 where f1.name = f2.name and f2.Fruit = 'Banana') as Banana
from Fruits f1


--# 7. Return older people in the family with younger ones
;
select ParentId as PID, ChildID as CHID from Family
union
select f1.ParentId, f2.ChildID 
from Family f1, Family f2
where f1.ChildID = f2.ParentId 
union
select f1.ParentId, f3.ChildID 
from Family f1, Family f2, Family f3
where f1.ChildID = f2.ParentId 
and  f2.ChildID = f3.ParentId 


--# 8. Write an SQL statement given the following requirements. 
--For every customer that had a delivery to California, provide a result set of the customer orders 
--that were delivered to Texas
;
select * from #Orders
where DeliveryState = 'TX'
and CustomerID in (select CustomerID from #Orders where DeliveryState = 'CA')


--# 9. Insert the names of residents if they are missing
select * from #residents
;
update #residents
set address = replace(address, 'age=', 'name=' + fullname + 'age=')
where address not like '%name=%'


--# 10. Write a query to return the route to reach from Tashkent to Khorezm. 
--The result should include the cheapest and the most expensive routes
;
CREATE TABLE #Routes
(
RouteID        INTEGER NOT NULL,
DepartureCity  VARCHAR(30) NOT NULL,
ArrivalCity    VARCHAR(30) NOT NULL,
Cost           MONEY NOT NULL,
PRIMARY KEY (DepartureCity, ArrivalCity)
);

INSERT INTO #Routes (RouteID, DepartureCity, ArrivalCity, Cost) VALUES
(1,'Tashkent','Samarkand',100),
(2,'Samarkand','Bukhoro',200),
(3,'Bukhoro','Khorezm',300),
(4,'Samarkand','Khorezm',400),
(5,'Tashkent','Jizzakh',100),
(6,'Jizzakh','Samarkand',50);



;
with RoutePaths as (
select 
		RouteID,
		DepartureCity,
		ArrivalCity,
		cast(DepartureCity + ' - ' + ArrivalCity as varchar(50)) as route,
		Cost
	from #Routes
	where DepartureCity = 'Tashkent'

	union all

select r.RouteID,
		rp.DepartureCity,
		r.ArrivalCity,
		cast(rp.route + ' - ' + r.ArrivalCity as varchar(50)) as Route,
		rp.cost + r.cost
	from RoutePaths rp
	join #Routes r on rp.ArrivalCity = r.DepartureCity
	where rp.route not like '%' + r.ArrivalCity + '%'
)
select top 2 Route, cost
from RoutePaths
where ArrivalCity = 'Khorezm'
and cost in (
	(select min(cost) from RoutePaths where ArrivalCity = 'Khorezm'),
	(select max(cost) from RoutePaths where ArrivalCity = 'Khorezm')
	)
order by Cost asc


--# 11. Rank products based on their order of insertion.
;
select * from #RankingPuzzle
;
with Grouped as (
    select *,
        sum(case when Vals = 'Product' then 1 else 0 end) over (order by ID ROWS UNBOUNDED PRECEDING) as GroupID
    from #RankingPuzzle
)
select *
from Grouped
where Vals <> 'Product';



--# 12. You have to return Ids, what number of the letter would be next if inserted, the maximum length of the consecutive occurence of the same digit


CREATE TABLE #Consecutives
(
     Id VARCHAR(5)  
    ,Vals INT /* Value can be 0 or 1 */
)
 
INSERT INTO #Consecutives VALUES
('a', 1),
('a', 0),
('a', 1),
('a', 1),
('a', 1),
('a', 0),
('b', 1),
('b', 1),
('b', 0),
('b', 1),
('b', 0)
```

---
# Question 13
# Find employees whose sales were higher than the average sales in their department

```sql
CREATE TABLE #EmployeeSales (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeName VARCHAR(100),
    Department VARCHAR(50),
    SalesAmount DECIMAL(10,2),
    SalesMonth INT,
    SalesYear INT
);

INSERT INTO #EmployeeSales (EmployeeName, Department, SalesAmount, SalesMonth, SalesYear) VALUES
('Alice', 'Electronics', 5000, 1, 2024),
('Bob', 'Electronics', 7000, 1, 2024),
('Charlie', 'Furniture', 3000, 1, 2024),
('David', 'Furniture', 4500, 1, 2024),
('Eve', 'Clothing', 6000, 1, 2024),
('Frank', 'Electronics', 8000, 2, 2024),
('Grace', 'Furniture', 3200, 2, 2024),
('Hannah', 'Clothing', 7200, 2, 2024),
('Isaac', 'Electronics', 9100, 3, 2024),
('Jack', 'Furniture', 5300, 3, 2024),
('Kevin', 'Clothing', 6800, 3, 2024),
('Laura', 'Electronics', 6500, 4, 2024),
('Mia', 'Furniture', 4000, 4, 2024),
('Nathan', 'Clothing', 7800, 4, 2024);
```

-----
--# 14. Find employees who had the highest sales in any given month using EXISTS
-----
--# 15. Find employees who made sales in every month using NOT EXISTS

```sql
CREATE TABLE Products (
    ProductID   INT PRIMARY KEY,
    Name        VARCHAR(50),
    Category    VARCHAR(50),
    Price       DECIMAL(10,2),
    Stock       INT
);

INSERT INTO Products (ProductID, Name, Category, Price, Stock) VALUES
(1, 'Laptop', 'Electronics', 1200.00, 15),
(2, 'Smartphone', 'Electronics', 800.00, 30),
(3, 'Tablet', 'Electronics', 500.00, 25),
(4, 'Headphones', 'Accessories', 150.00, 50),
(5, 'Keyboard', 'Accessories', 100.00, 40),
(6, 'Monitor', 'Electronics', 300.00, 20),
(7, 'Mouse', 'Accessories', 50.00, 60),
(8, 'Chair', 'Furniture', 200.00, 10),
(9, 'Desk', 'Furniture', 400.00, 5),
(10, 'Printer', 'Office Supplies', 250.00, 12),
(11, 'Scanner', 'Office Supplies', 180.00, 8),
(12, 'Notebook', 'Stationery', 10.00, 100),
(13, 'Pen', 'Stationery', 2.00, 500),
(14, 'Backpack', 'Accessories', 80.00, 30),
(15, 'Lamp', 'Furniture', 60.00, 25);


--# 16. Retrieve the names of products that are more expensive than the average price of all products.
-----
--# 17. Find the products that have a stock count lower than the highest stock count.
-----
--# 18. Get the names of products that belong to the same category as 'Laptop'.
-----
--# 19. Retrieve products whose price is greater than the lowest price in the Electronics category.
-----
--# 20. Find the products that have a higher price than the average price of their respective category.

CREATE TABLE Orders (
    OrderID    INT PRIMARY KEY,
    ProductID  INT,
    Quantity   INT,
    OrderDate  DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Orders (OrderID, ProductID, Quantity, OrderDate) VALUES
(1, 1, 2, '2024-03-01'),
(2, 3, 5, '2024-03-05'),
(3, 2, 3, '2024-03-07'),
(4, 5, 4, '2024-03-10'),
(5, 8, 1, '2024-03-12'),
(6, 10, 2, '2024-03-15'),
(7, 12, 10, '2024-03-18'),
(8, 7, 6, '2024-03-20'),
(9, 6, 2, '2024-03-22'),
(10, 4, 3, '2024-03-25'),
(11, 9, 2, '2024-03-28'),
(12, 11, 1, '2024-03-30'),
(13, 14, 4, '2024-04-02'),
(14, 15, 5, '2024-04-05'),
(15, 13, 20, '2024-04-08');
```
-----
--# 21. Find the products that have been ordered at least once.
-----
--# 22. Retrieve the names of products that have been ordered more than the average quantity ordered.
-----
--# 23. Find the products that have never been ordered.
-----
--# 24. Retrieve the product with the highest total quantity ordered.
-----
--# 25. Find the products that have been ordered more times than the average number of orders placed.
---    
