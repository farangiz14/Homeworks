--# Lesson 21  WINDOW FUNCTIONS

--1. Write a query to assign a row number to each sale based on the SaleDate.
 select *,
		row_number() over(order by saledate desc) as rank
from ProductSales

--2. Write a query to rank products based on the total quantity sold. give the same rank for the same amounts without skipping numbers.
select *,
dense_rank() over(order by saleamount desc) as rank
from ProductSales

select* from ProductSales

--3. Write a query to identify the top sale for each customer based on the SaleAmount.
with cte as(
	select customerid,
	saleamount,
	row_number() over(partition by customerid order by saleamount desc) as rank
from ProductSales
			)
select customerid, saleamount
from cte
where rank = 1


--4. Write a query to display each sale's amount along with the next sale amount in the order of SaleDate.
select customerid, saleamount,saledate,
	lead(saleamount) over(order by saledate desc) as next_s
from ProductSales

--5. Write a query to display each sale's amount along with the previous sale amount in the order of SaleDate.
select customerid, saleamount, saledate,
	lag(saleamount) over(order by saledate desc) as prev_s
from ProductSales


select * from ProductSales
--6. Write a query to identify sales amounts that are greater than the previous sale's amount
with cte as(
select customerid, saleamount, saledate,
	lag(saleamount) over(order by saledate desc) as prev_s
from ProductSales
)
select * from cte
where saleamount > prev_s

--7. Write a query to calculate the difference in sale amount from the previous sale for every product
select customerid, saleamount, saledate,
		lag(saleamount) over( order by saledate) as prev_s,
saleamount - lag(saleamount) over(order by saledate) as diff
from ProductSales

--8.  Write a query to compare the current sale amount with the next sale amount in terms of percentage change.
select customerid, saleamount, saledate,
		lead(saleamount) over( order by saledate) as next,
(lead(saleamount) over(order by saledate) - saleamount)/ saleamount as perc_diff
from ProductSales

--9. Write a query to calculate the ratio of the current sale amount to the previous sale amount within the same product.
select customerid, saleamount, saledate,
		lag(saleamount) over(partition by productname order by saledate) as prev_s,
		saleamount/ lag(saleamount) over(partition by productname order by saledate) as ratio
		from ProductSales
--12. Write a query to calculate a "closing balance"(running total) for sales amounts which adds the current sale amount to a running total of previous sales.
select customerid,
		  saledate,
		  saleamount,
		  SUM(saleamount) OVER (PARTITION BY customerid ORDER BY saledate rows between unbounded preceding and current row) as closing_b
FROM ProductSales;

