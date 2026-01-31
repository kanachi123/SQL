use Northwind;
GO
CREATE FUNCTION getStockStatus(@product_name NVARCHAR(100))
RETURNS TABLE 
AS
RETURN(
    SELECT 
        products.ProductID,
        products.ProductName,
        products.StockQuantity,
        CASE
            WHEN products.StockQuantity = 0 THEN 'OUT OF STOCK'
            WHEN products.StockQuantity < 50 THEN 'LOW STOCK'
            ELSE 'IN STOCK'
        END AS StockStatus
    FROM dbo.Products products
    WHERE products.ProductName = @product_name

);