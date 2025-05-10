--# Lesson 22: Aggregated Window Functions

select * from sales_data 

--## Easy Questions

--1. **Compute Running Total Sales per Customer**
select *,
sum(total_amount) over(partition by customer_id order by order_date desc
						rows between unbounded preceding and current row)
from sales_data

--2. **Count the Number of Orders per Product Category**
select product_category, count(product_name)
from sales_data
group by product_category

--3. **Find the Maximum Total Amount per Product Category**
SELECT product_category, MAX(total_amount) AS max_amount
FROM sales_data
GROUP BY product_category;

--4. **Find the Minimum Price of Products per Product Category**
SELECT product_category, Min(total_amount) AS max_amount
FROM sales_data
GROUP BY product_category;
--5. **Compute the Moving Average of Sales of 3 days (prev day, curr day, next day)**
select *,
		avg(total_amount) over(partition by customer_id order by order_Date desc
								rows between 1 preceding and 1 following)
from sales_data

--6. **Find the Total Sales per Region**
select region, sum(total_amount) as reg_total
from sales_data
group by region
--7. **Compute the Rank of Customers Based on Their Total Purchase Amount**
select 
	customer_id, sum(total_amount) as total,
		DENSE_RANK() over(order by sum(total_amount) desc) as rank
from sales_data
group by customer_id



--8. **Calculate the Difference Between Current and Previous Sale Amount per Customer**
select *,
	lag(total_amount) over(partition by customer_id order by order_date desc) as prev,
	total_amount - lag(total_amount) over(partition by customer_id order by order_Date desc) as diff
from sales_Data

--9. **Find the Top 3 Most Expensive Products in Each Category**
with cte as(
	select product_category, total_amount,
		dense_rank() over(partition by product_category order by total_amount desc) as rank
	from sales_data
			)
select *
from cte
where rank <= 3
order by product_category, rank
--10. **Compute the Cumulative Sum of Sales Per Region by Order Date**
select *,
	sum(total_amount) over( partition by region order by order_date desc) as cum
from sales_data
order by region, order_Date
