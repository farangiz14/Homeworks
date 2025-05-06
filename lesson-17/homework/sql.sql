--# Lesson-17: Practice


--### 1. You must provide a report of all distributors and their sales by region.  If a distributor did not have any sales for a region, provide a zero-dollar value for that day.  Assume there is at least one sale for each region

create view report as 
select * from #RegionSales 




--### 2. Find managers with at least five direct reports
select e2.name
from Employee e1
join Employee e2
on e1.managerid = e2.id 
group by e2.id, e2.name
having count(*) = 5



--### 3. Write a solution to get the names of products that have at least 100 units ordered in February 2020 and their amount.
select product_name, sum(unit)
from products p
join orders o
on p.product_id = o.product_id
group by product_name
having sum(unit) >= 100

--### 6. Write an SQL query to return the number of locations,in which location most signals sent, and total number of signal for each device from the given table.



select device_id, 
	count(locations) AS no_of_location,
	(select top 1 locations
from device d2
where d2.device_id = d1.device_id
group by locations
order by count(*) desc) as max_signal_location,
count(*) as no_of_signals
from device d1
GROUP BY device_id;



