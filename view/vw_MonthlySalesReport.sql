use Northwind;
GO
CREATE VIEW vw_MonthlySalesReport AS

    SELECT
        YEAR(o.OrderDate) AS SalesYear,
        MONTH(o.OrderDate) AS SalesMonth,
        DATENAME(MONTH, o.OrderDate) AS MonthName,
        COUNT(DISTINCT o.OrderID) AS TotalOrders, -- Total number of orders in the month
        SUM(od.Quantity * od.UnitPrice) AS TotalRevenue, -- Total revenue generated in the month
        COUNT(DISTINCT o.CustomerID) AS UniqueCustomers,
        SUM(od.Quantity) AS TotalQuantity,
        SUM(o.Freight) AS TotalFreight
    FROM Orders o
    JOIN [Order Details] od 
    ON o.OrderID = od.OrderID
    GROUP BY 
        YEAR(o.OrderDate),
        MONTH(o.OrderDate),
        DATENAME(MONTH, o.OrderDate);
        
GO