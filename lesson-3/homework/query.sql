

--1.1--
--BULK INSERT comman in SQL used to quickly import a large amounts of data from files such as CSV or TXT into the database table, its purpose is to speed up the process of inserting several rows at once and is very useful for importing from external sources;

--1.2--
--There are four files formats that can be imported int SQL server; They are: CSV - format that is commonly used for structured data, Excel - useful for tabular data, TXT - plain text files, and JSON - JavaScript Obejct Notation used for structured data exchange;

--1.3--
CREATE TABLE Products (ProductID INT PRIMARY KEY, ProductName VARCHAR(50), Price DECIMAL(10,2));
 
 --1.4--
INSERT INTO Products (ProductID, ProductName, Price)  
VALUES  
(1, 'Apple iPhone 15 Pro', 999.99),  
(2, 'Sony PlayStation 5', 499.99),  
(3, 'Tesla Model 3', 39999.99);  

--1.5--
--NULL represents missing or uknown value in a table columns, and is not the same as empty string (' ') or 0. NULL does not participate in calculations or comparison in a standard way. Furthermore, the commands NULL and NOT NULL are used to define whether a column can store unkown values.
CREATE TABLE TestNULL (
empID INT PRIMARY KEY,
name VARCHAR(50) NOT NULL,
email varchar(50) NULL
);

INSERT INTO TestNULL VALUES ( 1, 'Alice', NULL); --The command will be accepted as the is 
INSERT INTO TestNULL VALUES ( 1, NULL, 'abs@gmail.com'); --The command will not be accepted as column name is set to not to store unknown values.

--1.6--
ALTER TABLE Products
ADD CONSTRAINT uniq_prod_names UNIQUE (ProductName);

--1.7--
--The purpose of unique constraint  is that no two products can have the same name in the Productname column. In anohter words, preventing duplicate entries.

--1.8--
CREATE TABLE Categories (
CategoryID INT PRIMARY KEY,
CategoryName VARCHAR(50) UNIQUE
);

--1.9--
--The purpose of Identity column in SQL is to automatically generate unique numeric values for each row in a table. It is commonly used  fro primary key columns to ensure that each record has a distinct identifier. Its key feauture is Auto-Incrementing, that assigns unique number when a new row is inserted 

--2.1--
BULK INSERT Products
FROM "C:\Users\Frey\Desktop\MAAB\Productsdat.txt"
WITH (
	FORMAT = 'CSV',
	FIRSTROW = 1,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	TABLOCK
	);

--2.2--
ALTER TABLE Products
ADD CategoryID	INT,
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)

SELECT * FROM Products
SELECT * FROM Categories

--2.3--
--A Primary Key ensures uniqueness, does not allow NULL values, and a table can have only one. It creates a clustered index by default. A Unique Key also ensures uniqueness but allows NULL values (except in some databases like MySQL). A table can have multiple unique keys, and it creates a non-clustered index by default.

--2.4--
ALTER TABLE Products
ADD CONSTRAINT chk_price CHECK (Price > 0);

--2.5--
ALTER TABLE Products  
ADD Stock INT NOT NULL DEFAULT 0;

--2.6--
SELECT ProductID, ProductName, ISNULL(Stock, 0) AS StockValue  
FROM Products;

--2.7--
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    ProductID INT,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

--3.1--
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Age INT NOT NULL,
    CHECK (Age >= 18)
);

--3.2--
CREATE TABLE Employees (
    EmployeeID INT IDENTITY(100,10) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
);

--3.3--
CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    PRIMARY KEY (OrderID, ProductID)  -- Composite Primary Key
);

--3.4--


SELECT ProductID, ISNULL(Price, 5000) AS AdjustedSalary  
FROM Products;


--3.5--
CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,        
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(255),          
    CONSTRAINT UQ_Email UNIQUE (Email)  
);
   
--3.6--
CREATE TABLE Orderss (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    FOREIGN KEY (CustomerID) 
    REFERENCES Customers(CustomerID) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE
);

