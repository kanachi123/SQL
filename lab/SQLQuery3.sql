USE NORTHWIND
GO

/*             --template
--CREATE PROCEDURE MyPersons
--AS SELECT FirstName,LastName FROM Employees
--WHERE BirthDate is null
--CREATE PROCEDURE Get_Ch
--AS SELECT ProductName FROM Products WHERE (UnitPrice <= 20)

--EXECUTE MyPersons;
*/

--8.2
--EXECUTE Get_Ch;

--8.3
--CREATE PROCEDURE GetProducts
--WITH ENCRYPTION
--AS
--BEGIN
--	SELECT ProductName,UnitPrice,UnitsInStock,UnitPrice FROM Products WHERE  UnitsInStock  >= 1
--	GROUP BY ProductName,UnitPrice,UnitsInStock;
--END;

--EXECUTE GetProducts;

--select ProductName,UnitPrice,UnitsInStock,UnitPrice from Products

--8.4

--ALTER PROC CustNames @date int
--AS
--BEGIN 
--	SELECT c.ContactName FROM Customers c INNER Join Orders o  ON o.CustomerID = c.CustomerID WHERE Year(o.OrderDate) = @date;
--END
--DECLARE @date_tmp int = 1998
--EXECUTE CustNames @date_tmp ;

--8.5


ALTER PROC getTitle @num VARCHAR(30),@tit nvarchar(30) output
AS 
BEGIN
	SELECT @tit=c.ContactTitle from Customers c WHERE CustomerID = @num;
END;
go
DECLARE @id1 VARCHAR(30)
EXECUTE getTitle 'ALFKI', @num=@id1 OUTPUT
print @id1
--8.6
EXECUTE sp_help 'dbo.GetProducts'
GO
