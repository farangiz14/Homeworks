--1--
SELECT TOP 5 * 
FROM Employees;

--2--
SELECT DISTINCT ProductName 
FROM Products;

--3--
SELECT * FROM Products
WHERE Price > 100;

--4--
SELECT FirstName, LastName  
FROM Customers  
WHERE FirstName LIKE 'A%' OR LastName LIKE 'A%';

--5--
SELECT * 
FROM Products
ORDER BY Price ASC

--6--
SELECT * 
FROM Employees
WHERE Salary >= 60000 AND Department = 'HR'

--7--
UPDATE Products
SET Email = ISNULL(Email,  'noemail@example.com');

--8--
SELECT * 
FROM Products
WHERE Price BETWEEN 1000 AND 3000

--9--
SELECT DISTINCT ProductName, Category 
FROM Products

--10--
SELECT DISTINCT ProductName, Category 
FROM Products
ORDER BY ProductName DESC


--11--
SELECT TOP 10 * 
FROM Products
ORDER BY Price DESC;

--12--
SELECT EmployeeID, COALESCE(FirstName, LastName) AS DisplayName
FROM Employees;

--13--
SELECT DISTINCT Category, Price 
FROM Products

--14--
SELECT * 
FROM Employees
WHERE Age BETWEEN 30 AND 40
OR Department = 'Marketing'

--15--
SELECT * 
FROM Employees
ORDER BY Salary DESC
OFFSET 10 ROWS
FETCH NEXT 10 ROWS ONLY

--16--
SELECT * 
FROM Products
WHERE Price <= 1000 AND Stock > 50 
ORDER BY Stock ASC

--17--
SELECT * 
FROM Products
WHERE ProductName LIKE '%e%'

--18--
SELECT * 
FROM Employees
WHERE Department IN ('HR', 'IT', 'Finance')

--19--
SELECT * 
FROM Customers
ORDER BY City ASC, PostalCode DESC


--20--
SELECT TOP(10) *  
FROM Products  
ORDER BY SalesAmount DESC;

--21--
SELECT EmployeeID, CONCAT(FirstName, ' ', LastName) AS FullName  
FROM Employees;

--22--
SELECT DISTINCT ProductName, Category, Price 
FROM Products
WHERE Price > 50

--23--
SELECT Price 
FROM Products
WHERE Price < (SELECT AVG(Price) * 0.1 FROM Products)

--24--
SELECT * 
FROM Employees
WHERE Age < 30 AND Department NOT IN ('HR', 'IT')

--25--
SELECT * 
FROM Employees
WHERE Email LIKE '%@gmail.com'

--26--

SELECT * 
FROM Employees  
WHERE Salary > ALL (SELECT Salary FROM Employees WHERE Department = 'Sales');

--27--
SELECT * 
FROM Orders
WHERE OrderDate BETWEEN DATEADD(DAY, -180, GETDATE()) AND GETDATE();


