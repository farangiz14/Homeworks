--1.0--
CREATE DATABASE HW3
USE HW3

CREATE TABLE Employees (
EmpID INT,
Name VARCHAR(50),
Salary DECIMAL(10,2)
)

--1.1--
--SINGLE RAW
INSERT INTO Employees VALUES (1, 'Anna', 50259.39)
INSERT INTO Employees VALUES (2, 'Tom', 40052.5)

--MULTIPLE RAW
INSERT INTO Employees VALUES
(3, 'Tony', 34600),
(4, 'Anya', 50333.39)

--1.2--
UPDATE Employees  
SET Salary = 0 
WHERE EmpID = 1;

--1.3--
DELETE FROM Employees
WHERE EmpID =2

--1.4--

--DELETE has been demonstrated above with an example, we can see that it can delete values (rows), keeping the table

--DROP on the other hand is used to remove specific columns and even the entire table
ALTER TABLE Employees
DROP COLUMN Salary

DROP TABLE Employees

--TRUNCATE can remove all rows quickly as well as reseting the identities of the columns (aka formats)
TRUNCATE TABLE Employees

--1.5--
ALTER TABLE Employees
ALTER COLUMN Name VARCHAR(100)

--1.6--
ALTER TABLE Employees
ADD Department VARCHAR(50)

--1.7--
ALTER TABLE Employees
ALTER COLUMN Salary FLOAT

--1.8--
CREATE TABLE Departments (
  DepartmentID INT PRIMARY KEY, DepartmentName VARCHAR(50)
	)

--1.9--
DELETE FROM Employees


--2.0--
CREATE TABLE Dattest (
  DepartmentID INT PRIMARY KEY, DepartmentName VARCHAR(50), Salary int)

INSERT INTO Dattest VALUES
(1, 'HR', 6000),
(2, 'Finance', 5000),
(3, 'Marketing', 8000),
(4, 'Data', 4000),
(5, 'IT', 5500)

ALTER TABLE Employees
ADD DepartmentID INT

INSERT INTO Employees (Department)  
SELECT DepartmentName FROM Dattest

INSERT INTO Employees (DepartmentID)  
SELECT  FROM Dattest


--2.1--
UPDATE Employees  
SET Department = 'Management'
WHERE Salary > 5000;

--2.2--
DELETE FROM Employees

--2.3--
ALTER TABLE Employees
DROP COLUMN Department

--2.4--
EXEC sp_rename 'Employees', 'StaffMembers'

--2.5--
DROP TABLE Departments;



--3.1--
CREATE TABLE Products (ProductID INT Primary Key, ProductName VARCHAR(50), Category VARCHAR(50), Price DECIMAL(10,2))

--3.2--
ALTER TABLE Products
ADD CONSTRAINT Constraint_price CHECK (Price>0)

--3.3--
ALTER TABLE Products
ADD StockQuantity INT DEFAULT 50

--3.4--
EXEC sp_rename 'Products.Category', 'ProductCategory', 'COLUMN';

--3.5--
INSERT INTO Products (ProductID, ProductName, ProductCategory, Price, StockQuantity)
VALUES
(1, 'Laptop', 'Electronics', 1200.00, 10),
(2, 'Smartphone', 'Electronics', 800.00, 25),
(3, 'Headphones', 'Accessories', 150.00, 50),
(4, 'Desk Chair', 'Furniture', 300.00, 15),
(5, 'Coffee Maker', 'Appliances', 100.00, 20);

--3.6--
SELECT * INTO Products_Backup FROM Products

--3.7--
EXEC sp_rename 'Products', 'Inventory' 

--3.8--
ALTER TABLE Inventory DROP CONSTRAINT Constraint_price
ALTER TABLE Inventory
ALTER COLUMN Price FLOAT

--3.9--
ALTER TABLE Inventory
ADD  ProductCode INT IDENTITY(1000,5)

SELECT * FROM Inventory
