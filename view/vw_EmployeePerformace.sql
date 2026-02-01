use Northwind;
GO

CREATE VIEW vw_EmployeePerformance
AS
SELECT

    e.EmployeeID,
    e.FirstName,
    e.LastName,
    e.Title,
    COUNT(DISTINCT o.OrderID) AS TotalOrdersHandled, 
    SUM(od.Quantity * od.UnitPrice) AS TotalSalesAmount,  
    AVG(od.Quantity * od.UnitPrice) AS AverageSalesPerOrder, 
    MIN(o.OrderDate) AS FirstOrderHandled,             
    MAX(o.OrderDate) AS LastOrderHandled,              
    CASE
        WHEN MAX(o.OrderDate) >= DATEADD(year, -1, GETDATE()) THEN 'Active'     
        WHEN MAX(o.OrderDate) < DATEADD(year, -1, GETDATE()) 
             AND MAX(o.OrderDate) >= DATEADD(year, -3, GETDATE()) THEN 'Inactive' 
        ELSE 'Lost'                                                        
    END AS EmployeeStatus
GO