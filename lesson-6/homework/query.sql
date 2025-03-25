---PUZZLE--

--Question: If all the columns have zero values, then don’t show that row. In this case, we have to remove the 
--5th row while selecting data.

--### Table Schema:
CREATE TABLE TestMultipleZero (
    A INT NULL,
    B INT NULL,
    C INT NULL,
    D INT NULL
);

--### Sample Data:
INSERT INTO TestMultipleZero(A,B,C,D)
VALUES 
    (0,0,0,1),
    (0,0,1,0),
    (0,1,0,0),
    (1,0,0,0),
    (0,0,0,0),
    (1,1,1,0);

SELECT *
FROM TestMultipleZero
WHERE NOT (A = 0 AND B = 0 AND C = 0 AND D = 0);

--PUZZLE 2---

CREATE TABLE InputTbl (
    col1 VARCHAR(10),
    col2 VARCHAR(10)
);
    INSERT INTO InputTbl (col1, col2) VALUES 
('a', 'b'),
('a', 'b'),
('b', 'a'),
('c', 'd'),
('c', 'd'),
('m', 'n'),
('n', 'm');

SELECT DISTINCT 
       CASE WHEN Column1 < Column2 THEN Column1 ELSE Column2 END AS Col_A,  
       CASE WHEN Column1 > Column2 THEN Column1 ELSE Column2 END AS Col_B  
FROM YourTable;


SELECT col1, col2
FROM InputTbl 
WHERE col1 < col2  
UNION  
SELECT col2, col1
FROM InputTbl
WHERE col2 < col1;


SELECT DISTINCT CASE WHEN col1 < col2 THEN col1 ELSE col2 END,
				CASE WHEN col1 > col2 THEN col1 ELSE col2 END
FROM InputTbl;

--PUZZLE 3: Find those with odd ids

create table section1(id int, name varchar(20))
insert into section1 values (1, 'Been'),
       (2, 'Roma'),
       (3, 'Steven'),
       (4, 'Paulo'),
       (5, 'Genryh'),
       (6, 'Bruno'),
       (7, 'Fred'),
       (8, 'Andro')

SELECT * FROM section1
WHERE id%2 = 1 

--FRACTION: %

--PUZZLE 4:Person with the smallest id (use the table in puzzle 3)

 SELECT TOP 1 *
 FROM section1
 ORDER BY id ASC
--- Puzzle 5: Person with the highest id (use the table in puzzle 3)
SELECT TOP 1 *
 FROM section1
 ORDER BY id DESC
--- Puzzle 6: People whose name starts with b (use the table in puzzle 3)
SELECT *
FROM section1
WHERE name LIKE 'B%'


--Puzzle 7: Write a query to return only the rows where the code contains the literal underscore _ (not as a wildcard).

CREATE TABLE ProductCodes (
    Code VARCHAR(20)
);

INSERT INTO ProductCodes (Code) VALUES
('X-123'),
('X_456'),
('X#789'),
('X-001'),
('X%202'),
('X_ABC'),
('X#DEF'),
('X-999');

SELECT *
FROM ProductCodes
WHERE Code LIKE '%@_%' escape '@'


