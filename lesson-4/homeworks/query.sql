--1.1--
SELECT TOP 5 employees FROM Employee;

--1.2--
SELECT DISTINCT ProductName FROM Products;

--1.3--
SELECT * FROM Products
WHERE Price > 100;

--1.4--
SELECT CustomerName FROM Customers
WHERE CustomerName LIKE 'A%';

--1.5--
SELECT * FROM Products
ORDER BY Price ASC

--1.6--
SELECT * FROM Employees
WHERE Salary >= 60000 AND Department = 'HR'

--1.7--
UPDATE Products
SET Email = ISNULL(Email,  'noemail@example.com');

--1.8--
SELECT * FROM Products
WHERE Price BETWEEN 1000 AND 3000

--1.9--
SELECT DISTINCT ProductName, Category FROM Products

--1.10--
SELECT DISTINCT ProductName, Category FROM Products
ORDER BY ProductName DESC


--2.1--
SELECT TOP 10 ProductName FROM Products
ORDER BY Price DESC;

--2.2--
SELECT EmployeeID, COALESCE(FirstName, LastName) AS DisplayName
FROM Employees;

--2.3--
SELECT DISTINCT Category, Price FROM Products

--2.4--
SELECT * FROM Employees
WHERE Age BETWEEN 30 AND 40
OR Department = 'Marketing'

--2.5--
SELECT * FROM Employees
ORDER BY Salary DESC
OFFSET 10 ROWS
FETCH NEXT 10 ROWS ONLY

--2.6--
SELECT * FROM Products
WHERE Price <= 1000 AND Stock > 50 
ORDER BY Stock ASC

--2.7--
SELECT * FROM Products
WHERE ProductName LIKE '%e%'

--2.8--
SELECT * FROM Employee_records
WHERE Department IN ('HR', 'IT', 'Finance')

--2.9--
SELECT * FROM Customers
ORDER BY City ASC, PostalCode DESC


--3.1--
SELECT TOP(10) *  
FROM Products  
ORDER BY Price DESC;

--3.2--
SELECT EmployeeID, CONCAT(FirstName, ' ', LastName) AS FullName  
FROM Employees;

--3.3--
SELECT DISTINCT ProductName, Category, Price FROM Products
WHERE Price > 50

--3.4--
SELECT Price FROM Products
WHERE Price < (SELECT AVG(Price) * 0.1 FROM Products)

--3.5--
SELECT * FROM Employee
WHERE Age < 30 AND Department NOT IN ('HR', 'IT')

--2.6--
SELECT * FROM Employees
WHERE Email LIKE '%@gmail.com'

--2.7--

SELECT * FROM Employees  
WHERE Salary > ALL (SELECT Salary FROM Employees WHERE Department = 'Sales');

--2.8--
SELECT * FROM Orders
WHERE OrderDate BETWEEN DATEADD(DAY, -180, GETDATE()) AND GETDATE();


