USE NORTHWIND

GO

--CREATE TRIGGER yoU_SALL_NOT_pass
--ON Orders INSTEAD OF INSERT
--AS
--BEGIN

--	ROLLBACK TRANSACTION;
--	RAISERROR ('INSERT ERROR',12,1);
--END;

SELECT name, is_disabled FROM sys.triggers WHERE parent_id = OBJECT_ID('dbo.Orders');
SELECT OBJECT_DEFINITION(OBJECT_ID('dbo.yoU_SALL_NOT_pass'));                        
--DISABLE TRIGGER dbo.yoU_SALL_NOT_pass ON dbo.Orders;
--ENABLE TRIGGER dbo.yoU_SALL_NOT_pass ON dbo.Orders; 

/* 
INSERT INTO dbo.Orders(CustomerID, EmployeeID, OrderDate, RequiredDate, ShipCountry )
VALUES( 'ALFKI', 1, GETDATE(), DATEADD(DAY,7,GETDATE()) ,NULL); */

/* 
CREATE TRIGGER CUST_NOT_PASS
ON Customers INSTEAD OF UPDATE(Phone)
AS
BEGIN
    ROLLBACK TRANSACTION;
    RAISERROR ('UPDATE ERROR',12,1);
END;
 */

GO