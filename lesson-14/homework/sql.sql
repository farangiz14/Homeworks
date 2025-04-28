
--Easy Tasks
--1.Write a SQL query to split the Name column by a comma into two separate columns: Name and Surname.(TestMultipleColumns)
select 
substring(name,1,charindex(',',name)-1) as name, 
SUBSTRING(name,CHARINDEX(',', name) + 1 , len(name)) as surname
from TestMultipleColumns

--2.Write a SQL query to find strings from a table where the string itself contains the % character.(TestPercent)
select strs from TestPercent
where strs like '%[%]%'
 
--3.In this puzzle you will have to split a string based on dot(.).(Splitter)
select substring(vals,1,charindex('.',vals)-1) as value_1,
		(substring(vals,charindex('.',vals)+1, len(vals))) as values_2,
		substring(vals,charindex('.',vals)+3, len(vals)) as values_3
from splitter

--4.Write a SQL query to replace all integers (digits) in the string with 'X'.(1234ABC123456XYZ1234567890ADS)
select translate('1234ABC123456XYZ1234567890ADS', '0123456789', 'XXXXXXXXXX')

--5.Write a SQL query to return all rows where the value in the Vals column contains more than two dots (.).(testDots)
select vals
from testDots
where vals like '%.%.%.%'

--6.Write a SQL query to count the occurrences of a substring within a string in a given column.(Not table)
select (len('Apple juice is great! Apple pie is delicious. Iphone is produced by Apple') - len(replace('Apple juice is great! Apple pie is delicious. Iphone is produced by Apple', 'apple', ''))) / len('Apple')

--7.Write a SQL query to count the spaces present in the string.(CountSpaces)
select len(texts)- len(replace(texts, ' ', '')) as count_space
from countspaces

--8.write a SQL query that finds out employees who earn more than their managers.(Employee)
select e1.name
from employee e1
join employee m1
on m1.id = e1.managerid
where e1.salary > m1.salary

--Medium Tasks
--1.Write a SQL query to separate the integer values and the character values into two different columns.(SeperateNumbersAndCharcters)
SELECT 
translate(value, 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz', replicate(' ', 52)) as num_only,
translate(value, '0123456789', replicate(' ', 10)) as letters
FROM SeperateNumbersAndCharcters;

--2.write a SQL query to find all dates' Ids with higher temperature compared to its previous (yesterday's) dates.(weather)
select w1.id
from weather w1
join weather w2
on w1.recorddate = DATEADD(day, 1, w2.recorddate)
where w1.temperature > w2.temperature
 
--3.Write a SQL query that reports the device that is first logged in for each player.(Activity)
select  device_id, player_id, min(event_date) as first_log
from Activity
group by player_id, device_id

--4.Write an SQL query that reports the first login date for each player.(Activity)
select player_id, min(event_date) as first_log
from Activity
group by player_id

--5.Your task is to split the string into a list using a specific separator 
(such as a space, comma, etc.), and then return the third item from that list.(fruits)
select string_split(fruit_list, ',')
from fruits

--6.Write a SQL query to create a table where each character from the string will be converted into a row, with each row having a single column.(sdgfhsdgfhs@121313131)
with SplitString AS (
	select substring('sdgfhsdgfhs@121313131', 1,1) as character, 1 AS Position
UNION ALL
select substring('sdgfhsdgfhs@121313131', s.Position + 1, 1), s.position + 1 
    FROM SplitString as s
    WHERE s.position < LEN('sdgfhsdgfhs@121313131')
)
select character from SplitString
option (maxrecursion 0);

--7.You are given two tables: p1 and p2. Join these tables on the id column. 
The catch is: when the value of p1.code is 0, replace it with the value of p2.code.(p1,p2)

select p1.id,
case when p1.code = 0 then p2.code else p1.code
end as code
from p1 p1
join p2 p2
on p2.id = p1.id

--8.You are given a sales table. Calculate the week-on-week percentage of sales per area for each financial week.  For each week, the total sales will be considered 100%, and the percentage sales for each day of the week should be calculated based on the area sales for that week.(WeekPercentagePuzzle)
select (saleslocal + salesremote)*100/ sum(saleslocal + salesremote) over() as weekpercetnage
from WeekPercentagePuzzle

--Difficult Tasks
--1.In this puzzle you have to swap the first two letters of the comma separated string.(MultipleVals)
select concat(
			substring(vals, 3,1), 
			',',
			substring(replace(vals, substring(vals,3,2), ''), 1,len(vals))
			)
from MultipleVals
--2.Find a string where all characters are the same and the length is greater than 1.(FindSameCharacters)
select vals
from FindSameCharacters
where len(vals) > 3

--3.Write a T-SQL query to remove the duplicate integer values present in the string column. Additionally, remove the single integer character that appears in the string.(RemoveDuplicateIntsFromNames)

--4.Find a string where all characters are the same and the length is greater than 1.(FindSameCharacters)
select vals
from FindSameCharacters
where len(vals) > 3

--5.Write a SQL query to extract the integer value that appears at the start of the string in a column named Vals.(GetIntegers)
select cast(SUBSTRING(vals,1,PATINDEX('%[^0-9]%', vals + 'a')-1) as int) as first_integer
from GetIntegers
where vals is not null
