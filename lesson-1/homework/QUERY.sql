
--1.1--
-- Data is raw facts that includes values such as numbers or names, numbers and etc.
-- Data Base is the collection of an organized data for the purpose of easy access and management
-- Relational Database is a database that stores data in tables, with relationships between the tables
-- Table is a structured format that exist in database with row and columns

--1.2--
--SQL Server posseses several key features, and they are:
--1. Data Storage and Management
--2.Security
--3.Backup and Recovery
--4.Scalability
--5. SQL Queries

--1.3--
-- SQL Server Authentification Modes are:
--Windows Authentification
--SQL Server Authentification

--2.1--
CREATE DATABASE SchoolDB
USE SchoolDB  

--2.2--
CREATE TABLE Students_schoolDB (  
    StudentID INT PRIMARY KEY,  
    Name VARCHAR(100),  
    Age INT  
)

--2.3--
--There are several differences between SQL Server, SSMS and SQL, and here they are:
--SQL Server is a database management system that stores, manages and processes data
--While SQL is a programming language
-- And SSMS is a software tool used to interct with SQL server easily

--3.1--
--DQL (Data Query Language) – Used to retrieve data
SELECT * FROM Students_schoolDB
--DML-- (Data Manipulation Language) – Used to modify data
INSERT INTO Students_schoolDB VALUES 
(1, 'Alice', 20),
(2, 'Bob', 21), 
(3, 'Charlie', 22)
UPDATE Students_schoolDB SET Age = 21 WHERE StudentID = 1;
DELETE FROM Students_schoolDB WHERE StudentID = 1;

--DDL (Data Definition Language) – Used to define database structure
ALTER TABLE Students_schoolDB ADD Gender VARCHAR(10);
DROP TABLE Students;

--DCL (Data Control Language) – Used to control user access.
--This will be covered in the future lessons

--TCL (Transaction Control Language) – Used to manage transactions
BEGIN TRANSACTION
UPDATE Students_schoolDB SET Age = 22 WHERE StudentID = 1
COMMIT

--3.2--
INSERT INTO Students_schoolDB VALUES 
(1, 'Alice', 20),
(2, 'Bob', 21), 
(3, 'Charlie', 22)
