use Northwind;
GO
CREATE VIEW vw_SupplierStats AS

    SELECT
    p.ProductID,
    p.ProductName,
    COUNT(DISTINCT p.ProductID) AS ProductCount,
    COUNT(DISTINCT od.OrderID) AS TotalOrders,
    SUM(od.Quantity) AS TotalQuantitySold,
    SUM(od.Quantity * od.UnitPrice) AS TotalRevenue,
    AVG(od.UnitPrice) AS AveragePrice,
    MAX(od.UnitPrice) AS HighestPrice,
    MIN(od.UnitPrice) AS LowestPrice
    FROM Products p
    LEFT JOIN [Order Details] od 
        ON p.ProductID = od.ProductID
    GROUP BY
        p.ProductID,
        p.ProductName;        
GO

SELECT * FROM vw_SupplierStats;