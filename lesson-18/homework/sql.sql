--Lesson-18: View, temp table, variable, functions

--1. Create a temporary table named MonthlySales to store the total quantity sold and total revenue for each product in the current month.
--Return: ProductID, TotalQuantity, TotalRevenue
create view MonthlySales as
select sum(quantity) as q_sold, sum(quantity*price) as t_rev
from sales s
join products p
on p.productid = s.productid
where saledate = getdate()

--2. Create a view named vw_ProductSalesSummary that returns product info along with total sales quantity across all time.
--Return: ProductID, ProductName, Category, TotalQuantitySold
create view vw_ProductSalesSummary as
select p.productid, productname, category, quantity as TotalQuantitySold
from sales s
join products p
on p.productid = s.productid

--3. Create a function named fn_GetTotalRevenueForProduct(@ProductID INT)
--Return: total revenue for the given product ID

create proc pr_GetTotalRevenueForProduct 
	@ProductID INT
as
begin

select productname, sum(quantity*price) as t_rev
from sales s
join products p
on p.productid = s.productid
where s.productid = @ProductID
group by productname 
end

exec pr_GetTotalRevenueForProduct @ProductID = 4


select * from products
select * from sales


--4. Create an function fn_GetSalesByCategory(@Category VARCHAR(50))
--Return: ProductName, TotalQuantity, TotalRevenue for all products in that category.

create proc fn_GetSalesByCategory
	@Category VARCHAR(50)
as
begin
select ProductName, sum(quantity) as TotalQuantity, sum(quantity*price) as TotalRevenue
from sales s
join products p
on p.productid = s.productid
where category = @Category
group by productname 
end

exec fn_GetSalesByCategory @Category = 'Electronics'

