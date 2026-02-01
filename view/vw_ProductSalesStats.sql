USE Northwind;
GO

CREATE VIEW vw_ProductSalesStats AS
SELECT
    p.ProductID,
    p.ProductName,
    c.CategoryName,
    s.CompanyName AS SupplierName,
    SUM(od.Quantity) AS TotalQuantitySold,
    SUM(od.Quantity * od.UnitPrice) AS TotalRevenue,
    COUNT(DISTINCT od.OrderID) AS OrderCount,
    p.UnitsInStock,
    p.UnitsOnOrder,
    p.ReorderLevel
FROM [Order Details] od
JOIN Products p ON od.ProductID = p.ProductID
JOIN Categories c ON p.CategoryID = c.CategoryID
JOIN Suppliers s ON p.SupplierID = s.SupplierID
GROUP BY
    p.ProductID,
    p.ProductName,
    c.CategoryName,
    s.CompanyName,
    p.UnitsInStock,
    p.UnitsOnOrder,
    p.ReorderLevel;
GO

SELECT * FROM vw_ProductSalesStats;
