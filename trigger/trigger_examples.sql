-- trigger_examples.sql
-- Примеры триггеров для Northwind (MS SQL Server/T-SQL)
-- Использовать `USE NORTHWIND` перед исполнением

USE NORTHWIND;
GO

/* 1) Создание таблицы аудита для Orders */
IF OBJECT_ID('dbo.Orders_Audit', 'U') IS NOT NULL
    DROP TABLE dbo.Orders_Audit;
GO

CREATE TABLE dbo.Orders_Audit (
    AuditID INT IDENTITY PRIMARY KEY,
    OrderID INT,
    Action NVARCHAR(10), -- 'INSERT' | 'UPDATE' | 'DELETE'
    OldShipCountry NVARCHAR(100) NULL,
    NewShipCountry NVARCHAR(100) NULL,
    ChangedAt DATETIME2 DEFAULT SYSUTCDATETIME(),
    ChangedBy SYSNAME DEFAULT SUSER_SNAME()
);
GO

/* 2) AFTER trigger: вставка записей в таблицу аудита при INSERT/UPDATE/DELETE */
IF OBJECT_ID('dbo.trg_Orders_Audit', 'TR') IS NOT NULL
    DROP TRIGGER dbo.trg_Orders_Audit;
GO

CREATE TRIGGER dbo.trg_Orders_Audit
ON dbo.Orders
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- INSERTS
    INSERT INTO dbo.Orders_Audit (OrderID, Action, NewShipCountry)
    SELECT i.OrderID, 'INSERT', i.ShipCountry
    FROM INSERTED i
    LEFT JOIN DELETED d ON i.OrderID = d.OrderID
    WHERE d.OrderID IS NULL;

    -- UPDATES
    INSERT INTO dbo.Orders_Audit (OrderID, Action, OldShipCountry, NewShipCountry)
    SELECT i.OrderID, 'UPDATE', d.ShipCountry, i.ShipCountry
    FROM INSERTED i
    JOIN DELETED d ON i.OrderID = d.OrderID;

    -- DELETES
    INSERT INTO dbo.Orders_Audit (OrderID, Action, OldShipCountry)
    SELECT d.OrderID, 'DELETE', d.ShipCountry
    FROM DELETED d
    LEFT JOIN INSERTED i ON d.OrderID = i.OrderID
    WHERE i.OrderID IS NULL;
END;
GO

/* 3) Пример INSTEAD OF INSERT для валидации (ShipCountry не должен быть пустым) */
IF OBJECT_ID('dbo.trg_Orders_ValidateInsert', 'TR') IS NOT NULL
    DROP TRIGGER dbo.trg_Orders_ValidateInsert;
GO

CREATE TRIGGER dbo.trg_Orders_ValidateInsert
ON dbo.Orders
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM INSERTED WHERE ShipCountry IS NULL OR LTRIM(RTRIM(ShipCountry)) = '')
    BEGIN
        RAISERROR('ShipCountry must be provided for all orders', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- Если всё прошло валидацию - выполняем обычную вставку
    INSERT INTO dbo.Orders (
        CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate,
        ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry
    )
    SELECT
        CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate,
        ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry
    FROM INSERTED;
END;
GO

/* 4) Предотвращаем удаление отгруженного заказа (ShippedDate IS NOT NULL) */
IF OBJECT_ID('dbo.trg_Orders_PreventDeleteShipped', 'TR') IS NOT NULL
    DROP TRIGGER dbo.trg_Orders_PreventDeleteShipped;
GO

CREATE TRIGGER dbo.trg_Orders_PreventDeleteShipped
ON dbo.Orders
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM DELETED d WHERE d.ShippedDate IS NOT NULL)
    BEGIN
        RAISERROR('Cannot delete shipped orders', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- безопасное удаление (разрешено для не отгруженных заказов)
    DELETE o
    FROM dbo.Orders o
    JOIN DELETED d ON o.OrderID = d.OrderID;
END;
GO

/* 5) Обновление суммарной стоимости заказа при изменении Order Details
   Допустим, у нас есть поля Quantity и UnitPrice в таблице [Order Details] */
IF OBJECT_ID('dbo.trg_OrderDetails_UpdateOrderTotal', 'TR') IS NOT NULL
    DROP TRIGGER dbo.trg_OrderDetails_UpdateOrderTotal;
GO

CREATE TRIGGER dbo.trg_OrderDetails_UpdateOrderTotal
ON dbo.[Order Details]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Получаем набор affected orderID (INSERTED/DELETED могут использоваться)
    DECLARE @AffectedOrders TABLE (OrderID INT PRIMARY KEY);

    INSERT INTO @AffectedOrders
    SELECT DISTINCT OrderID FROM
    (
        SELECT OrderID FROM INSERTED
        UNION
        SELECT OrderID FROM DELETED
    ) t;

    -- Обновляем поле Orders Freight (пример): считаем сумму суммы по деталям и записываем в колонку Freight (для демонстрации)
    -- На реальной схеме возможно другое поле, например OrderTotal

    UPDATE o
    SET Freight = od.Total
    FROM dbo.Orders o
    JOIN (
        SELECT OrderID, SUM(Quantity * UnitPrice * (1 - Discount)) AS Total
        FROM dbo.[Order Details]
        WHERE OrderID IN (SELECT OrderID FROM @AffectedOrders)
        GROUP BY OrderID
    ) od ON od.OrderID = o.OrderID;
END;
GO

/* 6) Как тестировать и отлаживать: примеры действий */
-- 6.1 Проверить, какие триггеры есть на Orders
SELECT t.[name], t.[is_disabled], OBJECT_DEFINITION(t.object_id) as Definition
FROM sys.triggers t
WHERE parent_id = OBJECT_ID('dbo.Orders');

-- 6.2 Вставка для теста (валидная)
INSERT INTO dbo.Orders (CustomerID, EmployeeID, OrderDate, RequiredDate, ShipCountry)
VALUES ('ALFKI', 1, GETDATE(), DATEADD(day, 7, GETDATE()), 'Armenia');

-- 6.3 Попытка вставки с пустым ShipCountry — будет отклонена
INSERT INTO dbo.Orders (CustomerID, EmployeeID, OrderDate, RequiredDate, ShipCountry)
VALUES ('ALFKI', 1, GETDATE(), DATEADD(day, 7, GETDATE()), NULL);

-- 6.4 Множественная вставка
INSERT INTO dbo.Orders (CustomerID, EmployeeID, OrderDate, RequiredDate, ShipCountry)
VALUES
('ALFKI', 1, GETDATE(), DATEADD(day, 7, GETDATE()), 'Armenia'),
('ANATR', 4, GETDATE(), DATEADD(day, 7, GETDATE()), 'Norway');

-- 6.5 Удаление отгруженного заказа (должно привести в ошибке) — тест для PreventDeleteShipped
-- предварительно нужно вставить заказ и поставить ShippedDate
DECLARE @OrderID INT;
INSERT INTO dbo.Orders (CustomerID, EmployeeID, OrderDate, ShipCountry) OUTPUT Inserted.OrderID INTO @OrderID
VALUES ('ALFKI', 1, GETDATE(), 'Armenia');

-- Однако в Northwind вставка OrderID автогенерируется — для теста создайте тестовую запись, затем обновите ShippedDate
-- UPDATE dbo.Orders SET ShippedDate = GETDATE() WHERE OrderID = X;
-- DELETE FROM dbo.Orders WHERE OrderID = X; -- приведёт к ошибке

-- 6.6 Просмотр аудита
SELECT TOP 100 * FROM dbo.Orders_Audit ORDER BY ChangedAt DESC;

/* 7) Очистка/удаление созданных объектов (rollback examples) */
-- DROP TRIGGER dbo.trg_OrderDetails_UpdateOrderTotal ON dbo.[Order Details];
-- DROP TRIGGER dbo.trg_Orders_PreventDeleteShipped ON dbo.Orders;
-- DROP TRIGGER dbo.trg_Orders_ValidateInsert ON dbo.Orders;
-- DROP TRIGGER dbo.trg_Orders_Audit ON dbo.Orders;
-- DROP TABLE dbo.Orders_Audit;
GO

/* Notes:
   - Триггер на Northwind Orders в реальной базе может зависеть от структуры таблиц — проверьте имена колонок (Orders, [Order Details])
   - В реальном боевом окружении следует избегать тяжелых вычислений внутри триггеров
   - Для логирования и асинхронной обработки лучше записывать события в очередь/таблицу и обрабатывать вне транзакции
*/