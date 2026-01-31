USE test

--CREATE TABLE Orders(
--	OrderID INT IDENTITY(1,1) PRIMARY KEY,
--	CustomerID INT NOT NULL,
--	SellerID INT NOT NULL,
--	sum_ord decimal,
--	date_ord DATETIME
--); 

--GO
--Create View test_select
--AS
--SELECT s.lname_sel,
--	   goods.goods_name,
--	   c.lname_cust
--	   AS Names
--FROM Orders o
--JOIN Customers c on o.OrderID = c.id_cust
--JOIN Goods goods on o.OrderID = goods.id_goods
--JOIN Sellers s on o.OrderID = c.id_cust;
--GO
select * from test_select;