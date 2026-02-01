USE Northwind
GO
CREATE VIEW vw_OrderDetails
AS
SELECT
    o.OrderID,
    o.OrderDate,
    o.RequiredDate,
    o.ShipedDate,
    c.CompanyName,
    c.ContactName,
    c.City,
    c.Country,
    e.FullName,
    e.Title,
    s.ShipperCompany,
    s.Freight,
    CASE
        WHEN o.ShippedDate IS NULL THEN 'Pending'
        ELSE 'Shipped'
    END AS ShippingStatus
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Employees e ON o.EmployeeID = e.EmployeeID
JOIN Shippers s ON o.ShipVia = s.ShipperID;
GO

select * from vw_OrderDetails;