--Lesson 13 ----Practice: String Functions, Mathematical Functions, Date and time Functions

--Easy Tasks

--1.You need to write a query that outputs "100-Steven King", meaning emp_id + first_name + last_name in that format using employees table.
select concat(employee_id,'-', first_name,' ', last_name) as output
from employees

--2.Update the portion of the phone_number in the employees table, within the phone number the substring '124' will be replaced by '999'
select replace(phone_number, 123, 999)
from employees

--3.That displays the first name and the length of the first name for all employees whose name starts with the letters 'A', 'J' or 'M'. Give each column an appropriate label. Sort the results by the employees first names.(Employees)
select first_name, len(first_name) as length
from employees
where first_name like 'A%' OR first_name LIKE 'J%' OR first_name LIKE 'M%'

--4.Write an SQL query to find the total salary for each manager ID.(Employees table)
select manager_id, sum(salary)
from employees
group by manager_id

--5.Write a query to retrieve the year and the highest value from the columns Max1, Max2, and Max3 for each row in the TestMax table
select year1, GREATEST(max1, max2, max3) as highest_value
from TestMax

--6.Find me odd numbered movies description is not boring.(cinema)
select 
	case
		when id %2 > 0 then 'not boring'
		else 'boring'
		end
from cinema

--7.You have to sort data based on the Id but Id with 0 should always be the last row. Now the question is can you do that with a single order by column.(SingleOrder)
select * from SingleOrder
order by id desc

--8.Write an SQL query to select the first non-null value from a set of columns. If the first column is null, move to the next, and so on. If all columns are null, return null.(person)
select id, coalesce(ssn,passportid,itin)
from person

--9.Find the employees who have been with the company for more than 10 years, but less than 15 years. Display their Employee ID, First Name, Last Name, Hire Date, and the Years of Service (calculated as the number of years between the current date and the hire date, rounded to two decimal places).(Employees)
select employee_id, first_name, last_name, hire_date, 
		round(datediff(day,hire_date, GETDATE())/365,2) as years_of_service
from employees
where round(datediff(day,hire_date, GETDATE())/365,2) > 10 
	and 
	round(datediff(day,hire_date, GETDATE())/365,2) < 15

--10.Find the employees who have a salary greater than the average salary of their respective department.(Employees)
select employee_id, first_name, last_name, salary
from employees e
where salary > (select avg(salary)
					from employees e2
					where e2.department_id = e.department_id)

--Medium Tasks
--1.Write an SQL query that separates the uppercase letters, lowercase letters, numbers, and other characters from the given string 'tf56sd#%OqH' into separate columns.

SELECT 
    REPLACE(TRANSLATE('tf56sd#%OqH', 'abcdefghijklmnopqrstuvwxyz0123456789#%', ''), ' ', '') AS UppercaseLetters,
    REPLACE(REPLACE('tf56sd#%OqH', 'A', ''), 'B', '') AS LowercaseLetters,  -- Continue for all upper case chars
    REPLACE(REPLACE('tf56sd#%OqH', 's', ''), 'd', '') AS Numbers -- Etc...


--2.split column FullName into 3 part ( Firstname, Middlename, and Lastname).(Students Table)
select
	PARSENAME(replace(fullname, ' ', '.'),3) as firstname,
	parsename(replace(fullname,' ','.'),2) as middlename,
	parsename(replace(fullname, ' ', '.'),3) as lastname
	from students

--3.For every customer that had a delivery to California, provide a result set of the customer orders that were delivered to Texas. (Orders Table)
select customerid, deliverystate
from orders
where customerid in (select customerid
						from orders
						where deliverystate = 'CA')
				AND
					deliverystate = 'TX'


--4.Write an SQL query to transform a table where each product has a total quantity into a new table 
where each row represents a single unit of that product.For example, if A and B, it should be A,B and B,A.(Ungroup)

SELECT productdescription 
from Ungroup
where quantity >= 1
union all
SELECT productdescription 
from Ungroup
where quantity >= 2
union all
SELECT productdescription 
from Ungroup
where quantity >= 3
union all
SELECT productdescription 
from Ungroup
where quantity >= 4

--5.Write an SQL statement that can group concatenate the following values.(DMLTable)
select CONCAT_WS(' ', sequencenumber, string)
from DMLTable

--6.Write an SQL query to determine the Employment Stage for each employee based on their HIRE_DATE. The stages are defined as follows:
select 
	case
		when DATEDIFF(year, hire_date, getdate()) < 1 
			then 'New Hire'
		when  DATEDIFF(year, hire_date, getdate()) between 1 and 5 
			then 'Junior'
		when  DATEDIFF(year, hire_date, getdate()) between 5 and 10 
			then 'Mid-Level'
		when  DATEDIFF(year, hire_date, getdate()) between 10 and 20 
			then 'Senior'
		else 'Veteran'
		end
from employees

--7.Find the employees who have a salary greater than the average salary of their respective department(Employees)
select employee_id, first_name, last_name, salary
from employees e
where salary > (select avg(salary)
					from employees e2
					where e2.department_id = e.department_id)

--8.Find all employees whose names (concatenated first and last) contain the letter "a" and whose salary is divisible by 5(Employees)
select concat(first_name, ' ', last_name) 
from employees
where concat(first_name, ' ', last_name) like '%a%'
and cast(salary as int) % 5 = 0

--9.The total number of employees in each department and the percentage of those employees who have been with the company for more than 3 years(Employees)
select department_id, count(employee_id) as total_emp, 
	100* sum(case
		when DATEDIFF(year, hire_date, GETDATE()) > 3
			 then 1 else 0 end)
			 /
			 (count(employee_id))
			 as percentage
from employees
group by department_id

--10.Write an SQL statement that determines the most and least experienced Spaceman ID by their job description.(Personal)
select spacemanid, jobdescription,
	case
		when missioncount = (select max(missioncount) FROM personal WHERE jobdescription = p.jobdescription) then 'most experienced'
		when missioncount = (select min(missioncount) FROM personal WHERE jobdescription = p.jobdescription) then 'least experienced'
		else null
		end as levels
from personal p


--Difficult Tasks
--1.Write an SQL query that replaces each row with the sum of its value and the previous rows value. (Students table)
select studentid, fullname,
sum(grade) over(order by studentid) as cummulative_grade
from students;

--2.Given the following hierarchical table, write an SQL statement that determines the level of depth each employee has from the president. (Employee table)
WITH cte AS (
  SELECT EmployeeID, 0 AS Depth, jobtitle 
  FROM employee1 
  WHERE ManagerID IS NULL

  UNION ALL

  SELECT e.EmployeeID, cte.Depth + 1, e.jobtitle
  FROM employee1 e 
  JOIN cte ON e.ManagerID = cte.EmployeeID
)

SELECT * FROM cte;

--3.You are given the following table, which contains a VARCHAR column that contains mathematical equations. Sum the equations and provide the answers in the output.(Equations)
select equation,
		sum(cast(value as int)) as TotalSum
from equations
cross apply string_split(replace(replace(equation, '+', ','),'-',','), ',')
GROUP BY equation;

--4.Given the following dataset, find the students that share the same birthday.(Student Table)
select s1.studentname
from student s1
join student s2
on s2.birthday = s1.birthday
where s1.studentname >s2.studentname

--5.You have a table with two players (Player A and Player B) and their scores. If a pair of players have multiple entries, aggregate their scores into a single row for each unique pair of players.  Write an SQL query to calculate the total score for each unique player pair(PlayerScores)

select LEAST(playera, playerb) as player1,
		greatest(playera, playerb) as player2,
		sum(score) as total_score
from playerscores
group by  LEAST(playera, playerb),
		greatest(playera, playerb)


