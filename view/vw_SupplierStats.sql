use Northwind;
GO
CREATE VIEW vw_SupplierStats AS

    SELECT
    p.ProductID,
    p.ProductName,
    
    COUNT(DISTINCT p.ProductID) AS ProductCount,
    SUM(od.Quantity) AS TotalQuantitySold,    
    SUM(od.Quantity * od.UnitPrice) AS TotalRevenue,
    
    CASE
        WHEN SUM(od.Quantity * od.UnitPrice) >= 100000 THEN 'Major Supplier'
        WHEN SUM(od.Quantity * od.UnitPrice) BETWEEN 50000 AND 99999 THEN 'Regular Supplier'
        ELSE 'Minor Supplier'
    END AS SupplierType

FROM Suppliers s
JOIN Products p
    ON s.SupplierID = p.SupplierID
JOIN [Order Details] od
    ON p.ProductID = od.ProductID

GROUP BY

    p.ProductID,
    p.ProductName;        

GO

SELECT * FROM vw_SupplierStats;