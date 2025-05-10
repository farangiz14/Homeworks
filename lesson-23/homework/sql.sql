--HW 23
--### Puzzle 1: In this puzzle you have to extract the month from the dt column and then append zero single digit month if any. Please check out sample input and expected output.

select id, dt,
	format(dt, 'mm') AS MonthPrefixedWithZero
from dates

--### Puzzle 2: In this puzzle you have to find out the unique Ids present in the table. You also have to find out the SUM of Max values of vals columns for each Id and RId. For more details please see the sample input and expected output.

select count(distinct id) AS Distinct_Ids, 
		rid, 
		sum(max_vals)  AS TotalOfMaxVals
from 
	(select id, rid, max(vals) as max_vals
	from MyTabel
	group by id,rid)
as subquery
group by rid

--### Puzzle 3: In this puzzle you have to get records with at least 6 characters and maximum 10 characters. Please see the sample input and expected output.
select * 
from TestFixLengths
where len(vals) between 6 and 10

--### Puzzle 4: In this puzzle you have to find the maximum value for each Id and then get the Item for that Id and Maximum value. 
Please check out sample input and expected output.

select distinct id, item, vals as max_vals
from TestMaximum t
where vals = (
				select max(vals) 
				from TestMaximum
				where id = t.id
			)

--### Puzzle 5: In this puzzle you have to first find the maximum value for each Id and DetailedNumber, 
and then Sum the data using Id only. Please check out sample input and expected output.

select distinct id, sum(max_vals) as sum_val
from 
	(
		select id, max(vals) as max_vals
				from SumOfMax
				group by id
			) as subquary
group by id


--### Puzzle 6: In this puzzle you have to find difference between a and b column between each row and if the difference is not equal to 0 then show the difference i.e. a – b otherwise 0. Now you need to replace this zero with blank.Please check the sample input and the expected output.
select *,
	case when a-b = 0 then ' '
	else cast(a-b as varchar) 
	end as output 
from TheZeroPuzzle



--7. What is the total revenue generated from all sales?  
select sum( quantitysold * unitprice) as total_rev
from sales

--8. What is the average unit price of products?
select product,avg(unitprice) as avg_p
from sales
group by product
--9. How many sales transactions were recorded?  
select count(saleid) as trans_rec
from sales
--10. What is the highest number of units sold in a single transaction?  
select saleid, max(quantitysold) as max_q
from sales
group by saleid
--11. How many products were sold in each category?  
select category , count(product)
from sales
group by category
--12. What is the total revenue for each region?  
select region, sum( quantitysold * unitprice) as total_rev
from sales
group by region
--13. Which product generated the highest total revenue? 
with cte as(
			select product, sum( quantitysold * unitprice) as total_rev
			from sales
			group by product)
select product, total_rev
from cte
where total_rev = (
					select max(total_rev) as max_r
					from cte)
										
--14. Compute the running total of revenue ordered by sale date.
select *,
		sum( quantitysold * unitprice) over( order by saledate desc) as total_rev
from sales
--15. How much does each category contribute to total sales revenue?  
select category, sum( quantitysold * unitprice) as total_rev,
	(sum(quantitysold * unitprice) / (select sum( quantitysold * unitprice) from sales)) as categ_contr
from sales
group by category



--17. Show all sales along with the corresponding customer names

select product,category, quantitysold, unitprice, saleid, customername
from sales s 
join customers c
on c.customerid = s.customerid

--18. List customers who have not made any purchases  
select customername
from customers c 
left join sales s
on c.customerid = s.customerid
where s.saleid is null

--19. Compute total revenue generated from each customer  
select customername, sum( quantitysold * unitprice) as rev
from sales s 
join customers c
on c.customerid = s.customerid
group by customername

--20. Find the customer who has contributed the most revenue 
with cte as(
			select customername, sum( quantitysold * unitprice) as rev
			from sales s 
			join customers c
			on c.customerid = s.customerid
			group by customername
			)
select customername, rev
from cte
where rev = (
			select max(rev)
			from cte
			)
--21. Calculate the total sales per customer
select customername, sum(quantitysold) as tot_sale
from sales s 
join customers c
on c.customerid = s.customerid
group by customername
		

select * from Customers
select * from sales
select * from Products


--22. List all products that have been sold at least once 
select *
from products p
inner join sales s
on s.product = p.productname

--23. Find the most expensive product in the Products table  
select productname, costprice
from products
where costprice = (
					select max(costprice)
					from products
					)

--24. Find all products where the selling price is higher than the average selling price in their category  
with cte as(
select productname as prod,category as categ, avg(costprice) as avg_price
from products
group by productname, category
			)
select p.productname, p.category, p.costprice
from products p
join cte c
on c.prod = p.productname
where p.costprice > avg_price
