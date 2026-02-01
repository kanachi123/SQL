USE Northwind;
GO

CREATE VIEW vw_CategorySalesStats AS
SELECT
    c.CategoryID,
    c.CategoryName,

    COUNT(DISTINCT p.ProductID) AS ProductCount,
    COUNT(DISTINCT o.OrderID) AS TotalOrders,
    SUM(od.Quantity) AS TotalQuantitySold,
    SUM(od.Quantity * od.UnitPrice) AS TotalRevenue,

    AVG(od.UnitPrice) AS AveragePrice,
    MAX(od.UnitPrice) AS MaxPrice,
    MIN(od.UnitPrice) AS MinPrice

FROM Categories c
JOIN Products p
    ON c.CategoryID = p.CategoryID
JOIN [Order Details] od
    ON p.ProductID = od.ProductID
JOIN Orders o
    ON od.OrderID = o.OrderID

GROUP BY
    c.CategoryID,
    c.CategoryName;
GO
SELECT * FROM vw_CategorySalesStats;