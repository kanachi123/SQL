use test

go

Select DB_NAME() as CurrentDatabase;

 

--CREATE TABLE Sellers(

-- id_sel INT PRIMARY KEY IDENTITY(1,1),

-- lname_sel CHAR(50) NOT NULL,

-- city_sel CHAR(50) NOT NULL,

-- comis_sel DECIMAL NOT NULL,

-- leader CHAR(50) NOT NULL,

-- plan_sel INT NOT NULL

--);

 

--CREATE TABLE Customers(

-- id_cust INT PRIMARY KEY IDENTITY(1,1),

-- lname_cust CHAR(50) NOT NULL,

-- city_cust CHAR(50) NOT NULL,

-- rating_cust DECIMAL NOT NULL,

-- credit INT NOT NULL

--);

 

--CREATE TABLE Orders(

-- id_ord INT PRIMARY KEY IDENTITY(1,1),

-- sum_ord INT NOT NULL,

-- date_ord DATETIME NOT NULL,

-- id_sel INT,

-- id_cust INT,

-- FOREIGN KEY(id_sel) REFERENCES Sellers(id_sel),

-- FOREIGN KEY(id_cust) REFERENCES Customers(id_cust)

--);

 

--CREATE TABLE Goods(

-- id_goods INT PRIMARY KEY IDENTITY(1,1),

-- goods_name CHAR(50) NOT NULL,

-- price INT NOT NULL,

-- quantity INT NOT NULL,

-- id_cust INT,

-- FOREIGN KEY(id_cust) REFERENCES Customers(id_cust)

--);

--Alter Table Sellers

--add constraint chkPosPrice1 check (comis_sel > 0)

--Alter Table Sellers

--add constraint chkPlanPrice2 check (plan_sel > 0)

--Alter Table Customers

--add constraint chkPosPrice check (rating_cust between 1 and 20)

 

----DROP TABLE Goods;

----DROP TABLE Orders;

----DROP TABLE Customers;

----DROP TABLE Sellers;

 

 

--INSERT INTO Sellers(lname_sel,city_sel,comis_sel,leader,plan_sel)

--VALUES

--('seller1','city1',4,'leader',1000),

--('seller2','city1',8,'leader',5000),

--('seller3','city1',9,'leader',100);

 

--INSERT INTO Customers(lname_cust,city_cust,rating_cust,credit)

--VALUES

--('cust1','city1',10,10000),

--('cust2','city1',15,5000),

--('cust3','city1',8,1000);

--INSERT INTO Orders(id_cust,id_sel,sum_ord,date_ord)

--VALUES

--(1,1,4000,'2025.09.01'),

--(2,2,9000,'2025.08.08'),

--(3,3,4080,'2020.09.01');

 

--INSERT INTO Goods(id_cust,goods_name,price,quantity)

--VALUES

--(1,'goo1',4,5000),

--(2,'goo2',8,8000),

--(3,'goo3',9,9000);

 

--SELECT 

--    o.id_ord AS OrderID,

--    o.sum_ord AS OrderSum,

--    o.date_ord AS OrderDate,

 

--    s.lname_sel AS SellerName,

--    s.city_sel AS SellerCity,

--    s.comis_sel AS Commission,

--    s.plan_sel AS SalesPlan,
    
--    c.lname_cust AS CustomerName,

--    c.city_cust AS CustomerCity,

--    c.rating_cust AS CustomerRating,

--    c.credit AS CustomerCredit,

 

--    g.goods_name AS GoodsName,

--    g.price AS GoodsPrice,

--    g.quantity AS GoodsQuantity

 

--FROM
--    Orders o
--    JOIN Sellers s ON o.ord = s.id_sel
--    JOIN Customers c ON o.id_ord = c.id_cust
--    LEFT JOIN Goods g ON c.id_cust = g.id_goods;
--Alter table Sellers
--drop column fname_sel;
--Alter Table Sellers
--ADD fname_sel VARCHAR(50);

--Update Sellers
--SET fname_sel = 'firstname1'
--where id_sel = 1;
--Update Sellers
--SET fname_sel = 'firstname2'
--where id_sel = 2;
--Update Sellers
--SET fname_sel = 'firstname3'
--where id_sel = 3;

----6.1
--select * from Sellers s;
--select * from Orders o;
--select fname_sel as FirstName,sum_ord as OrderSum from Orders o JOIN Sellers s
--on o.id_ord = s.id_sel
--where (sum_ord <5500) Order by sum_ord desc;

----6.2
--select sum_ord from Orders
--where (sum_ord <5500) Order by sum_ord desc;

----6.3
--select lname_cust as CustomerName,rating_cust as Rating,sum_ord as SumOrd from Orders o JOIN Customers c
--on o.id_ord = c.id_cust order by Rating,SumOrd asc

----6.4
--select s.id_sel as ID, fname_sel as FirstName,date_ord as Date
--from Orders o JOIN Sellers s on o.id_ord = s.id_sel JOIN Customers c
--on o.id_ord = c.id_cust where c.city_cust='city1' and date_ord < '2024-01-01'
--order by o.date_ord desc;

------6.5

--Alter Table Customers
--drop fname_cust;
--Alter Table Customers
--ADD fname_cust VARCHAR(50);

--Update Customers
--SET fname_cust = 'firstname1'
--where id_cust = 1;
--Update Customers
--SET fname_cust = 'firstname2'
--where id_cust = 2;
--Update Customers
--SET fname_cust = 'firstname3'
--where id_cust = 3;
--select * from Customers;
--update Orders
--set date_ord = '2024-12-1'
--where id_ord = 1;
--select 
--    city_cust AS City,
--    fname_cust AS FirstName,
--    AVG(sum_ord) AS AVG_SUM
--from Customers c
--JOIN Orders o ON c.id_cust = o.id_ord
--where YEAR(o.date_ord) = 2024
--GROUP BY city_cust, fname_cust;

----6.7
--select * from Customers c join Goods g on c.id_cust = g.id_goods;
--select * from Customers c left join Goods g on c.id_cust = g.id_goods;
--select * from Customers c right join Goods g on c.id_cust = g.id_goods;
--select * from Customers c full join Goods g on c.id_cust = g.id_goods;
--select * from Customers c cross join Goods g;
----self join -> a table ->join->a' table


