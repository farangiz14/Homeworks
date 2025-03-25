--1.1--
SELECT ProductName AS Name 
FROM Products;

--1.2--
SELECT *
FROM Customers AS Clients;

--1.3--
SELECT ProductName
FROM Products
UNION
SELECT ProductName
FROM Products_Discounted;

--1.4--
SELECT *
FROM Products
INTERSECT
SELECT *
FROM Products_Discounted;

--1.5--
SELECT DISTINCT FirstName, LastName, Country  
FROM Customers;

--1.6--
SELECT ProductName, Price,  
       CASE  
           WHEN Price > 1000 THEN 'High'  
           WHEN Price <= 1000 THEN 'Low'  
       END
FROM Products;

--1.7--
SELECT IIF( StockQuantity > 100, 'Yes', 'No')
FROM Products_Discounted;

--2.1--
SELECT ProductName
FROM Products
UNION
SELECT ProductName
FROM OutOfStock;

--2.2--
SELECT *
FROM Products
EXCEPT
SELECT *
FROM Products_Discounted;

--2.3--
SELECT IIF(Price > 1000, 'Expensive', 'Affordable') AS Price_Category  
FROM Products;

--2.4--
SELECT *  
FROM Employees  
WHERE Age < 25 OR Salary > 60000;

--2.5--

IF EXISTS (SELECT 1 FROM Employees WHERE DepartmentName = 'HR' OR EmployeeID = 5)
BEGIN
    UPDATE Employees
    SET Salary = Salary * 1.10
    WHERE DepartmentName = 'HR' OR EmployeeID = 5;
END

--3.1--
SELECT *
FROM Products
INTERSECT
SELECT *
FROM Products_Discounted

--3.2--
select 
	*, 
		case 
			when SaleAmount > 500 then 'Top Tier'
			when SaleAmount BETWEEN 200 AND 500 then 'Mid Tier'
			else 'Low Tier'			
		end
	from Sales;

--3.3--

SELECT CustomerID  
FROM Sales  
EXCEPT  
SELECT CustomerID  
FROM Invoices;

--3.4--
SELECT CustomerID, Quantity, 
       CASE 
           WHEN Quantity > 3 THEN 0.03
           WHEN Quantity BETWEEN 1 AND 3 THEN 0.05
           ELSE 0.07
       END AS Discount_Percentage
FROM Orders;
