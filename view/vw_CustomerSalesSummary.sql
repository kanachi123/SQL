USE Northwind;
GO

CREATE VIEW vw_CustomerSalesSummary AS
SELECT
    c.CustomerID,
    c.CompanyName,
    c.ContactName,
    c.City,
    c.Country,
    COUNT(DISTINCT o.OrderID) AS TotalOrders, -- Total number of orders placed by the customer               
    SUM(od.Quantity * od.UnitPrice) AS TotalRevenue,           
    CASE 
        WHEN COUNT(DISTINCT o.OrderID) > 0 
        THEN SUM(od.Quantity * od.UnitPrice) / COUNT(DISTINCT o.OrderID)
        ELSE 0
    END AS AverageOrderValue,                                
    MIN(o.OrderDate) AS FirstOrderDate,                        
    MAX(o.OrderDate) AS LastOrderDate,                          
    CASE
        WHEN MAX(o.OrderDate) >= DATEADD(year, -1, GETDATE()) THEN 'Active'     
        WHEN MAX(o.OrderDate) < DATEADD(year, -1, GETDATE()) 
             AND MAX(o.OrderDate) >= DATEADD(year, -3, GETDATE()) THEN 'Inactive' 
        ELSE 'Lost'                                                        
    END AS CustomerStatus
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
LEFT JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY
    c.CustomerID,
    c.CompanyName,
    c.ContactName,
    c.City,
    c.Country;
GO

SELECT * FROM vw_CustomerSalesSummary;
