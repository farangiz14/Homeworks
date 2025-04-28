WITH cte AS (
    SELECT 
        product, 
        quantity AS qty
    FROM 
        grouped

    UNION ALL

    SELECT 
        product, 
        qty - 1
    FROM 
        cte
    WHERE 
        qty - 1 > 0
)
SELECT 
    product, 
    1 AS quantity
FROM 
    cte;


WITH Regions AS (
    SELECT DISTINCT Region FROM #RegionSales
),
Distributors AS (
    SELECT DISTINCT Distributor FROM #RegionSales
),
RegionDistributor AS (
    SELECT r.Region, d.Distributor
    FROM Regions r
    CROSS JOIN Distributors d
)
SELECT rd.Region, rd.Distributor, 
       ISNULL(rs.Sales, 0) AS Sales
FROM RegionDistributor rd
LEFT JOIN #RegionSales rs
ON rd.Region = rs.Region AND rd.Distributor = rs.Distributor
ORDER BY rd.Distributor, rd.Region;


SELECT e.name
FROM Employee e
JOIN (
    SELECT managerId
    FROM Employee
    WHERE managerId IS NOT NULL
    GROUP BY managerId
    HAVING COUNT(*) >= 5
) m ON e.id = m.managerId;


SELECT p.product_name, SUM(o.unit) AS unit
FROM Products p
JOIN Orders o ON p.product_id = o.product_id
WHERE o.order_date >= '2020-02-01' AND o.order_date < '2020-03-01'
GROUP BY p.product_name
HAVING SUM(o.unit) >= 100;


WITH VendorCounts AS (
    SELECT CustomerID, Vendor, COUNT(*) AS OrderCount
    FROM Orders
    GROUP BY CustomerID, Vendor
),
RankedVendors AS (
    SELECT *, 
           ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY OrderCount DESC) AS rnk
    FROM VendorCounts
)
SELECT CustomerID, Vendor
FROM RankedVendors
WHERE rnk = 1;


DECLARE @Check_Prime INT = 91;
DECLARE @i INT = 2;
DECLARE @is_prime BIT = 1;

WHILE @i <= SQRT(@Check_Prime)
BEGIN
    IF @Check_Prime % @i = 0
    BEGIN
        SET @is_prime = 0;
        BREAK;
    END
    SET @i = @i + 1;
END

IF @Check_Prime < 2
    PRINT 'This number is not prime'
ELSE IF @is_prime = 1
    PRINT 'This number is prime'
ELSE
    PRINT 'This number is not prime';


WITH SignalCounts AS (
    SELECT Device_id, Locations, COUNT(*) AS Signals
    FROM Device
    GROUP BY Device_id, Locations
),
MaxSignals AS (
    SELECT Device_id, Locations,
           ROW_NUMBER() OVER (PARTITION BY Device_id ORDER BY COUNT(*) DESC) AS rnk
    FROM Device
    GROUP BY Device_id, Locations
)
SELECT sc.Device_id,
       COUNT(DISTINCT sc.Locations) AS no_of_location,
       (SELECT Locations FROM MaxSignals ms WHERE ms.Device_id = sc.Device_id AND ms.rnk = 1) AS max_signal_location,
       SUM(sc.Signals) AS no_of_signals
FROM SignalCounts sc
GROUP BY sc.Device_id;


WITH DeptAvg AS (
    SELECT DeptID, AVG(Salary) AS AvgSalary
    FROM Employee
    GROUP BY DeptID
)
SELECT e.EmpID, e.EmpName, e.Salary
FROM Employee e
JOIN DeptAvg d ON e.DeptID = d.DeptID
WHERE e.Salary > d.AvgSalary;


WITH TicketMatches AS (
    SELECT t.TicketID, COUNT(*) AS MatchCount
    FROM Tickets t
    JOIN WinningNumbers w ON t.Number = w.Number
    GROUP BY t.TicketID
)
SELECT SUM(
    CASE 
        WHEN MatchCount = 3 THEN 100
        WHEN MatchCount > 0 THEN 10
        ELSE 0
    END
) AS TotalWinnings
FROM TicketMatches;


