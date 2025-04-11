--1. Combine Two Tables
select firstname, lastname, city, state
from person p
left join address a
on a.personid = p.personid;

--2.Employees Earning More Than Their Managers
select e1.name
from Employee e1
join employee e2
on e1.managerID = e2.id 
where  e1. salary > e2. salary;

--3.Duplicate Emails
select email as Email
from Person
where email is not null
group by email
having count(email) >1;


--5. Find those parents who has only girls.
select g.parentname
from girls g 
left join boys b
on b.id = g.id;

--6.Total over 50 and least
select custid, count(orderid) as sales_amount, min(freight) as least_weight
from Sales.Orders
group by custid
having sum(freight) >50;

--7.Carts
select c1.Item as item_cart_1, c2.item as item_cart_2
from cart1 c1
full outer join  cart2 c2
on c2.item = c1.item;

--8.Matches
SELECT MatchID, Match, Score,
  CASE 
    WHEN CAST(SUBSTRING(Score, 1, CHARINDEX(':', Score) - 1) AS INT) > CAST(SUBSTRING(Score, CHARINDEX(':', Score) + 1, LEN(Score)) AS INT)
      THEN SUBSTRING(Match, 1, CHARINDEX('-', Match) - 1)
    WHEN CAST(SUBSTRING(Score, 1, CHARINDEX(':', Score) - 1) AS INT) < CAST(SUBSTRING(Score, CHARINDEX(':', Score) + 1, LEN(Score)) AS INT)
      THEN SUBSTRING(Match, CHARINDEX('-', Match) + 1, LEN(Match))
    ELSE 'Draw'
  END AS Result
FROM match1;

--9.Customers Who Never Order
select name 
from customers c
left join orders o
on o.customerid = c.id
where o.customerid is null

--10.Students and Examinations
select s.student_id, student_name, subject_name, count(subject_name) as attended_exams 
from students s
left join Examinations e
on e.student_id = s.student_id
group by s.student_id, s.student_name,subject_name;
