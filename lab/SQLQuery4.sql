use test;
go
Select DB_NAME() as CurrentDatabase;


Alter Table Sellers
add constraint chk_pos_price check (comis_sel > 0);

Alter Table Sellers
add constraint chk_plan_price check (plan_sel > 0);


Alter Table Sellers
add constraint chk_pos_price check (comis_sel > 0);

Alter Table Customers
add constraint chk_plan_range check (rating_cust between 1 and 20);

INSERT INTO Sellers (lname_sel, city_sel, comis_sel, leader, plan_sel)
VALUES 
('Seller1', 'City1', 5, 'Leader1', 100000),
('Seller2', 'City2', 6, 'Leader2', 150000),
('Seller3', 'City3', 4, 'Leader3', 120000);
INSERT INTO Customers (lname_cust, city_cust, rating_cust, credit)
VALUES 
('Customer1', 'City1', 10, 5000),
('Customer2', 'City2', 15, 10000),
('Customer3', 'City3', 20, 15000);
INSERT INTO Orders (id_cust, id_sel, sum_ord, date_ord)
VALUES 
(1, 1, 5000, '2025.09.01'),
(2, 2, 7000, '2025.09.02'),
(3, 3, 10000, '2025.09.03');
INSERT INTO Goods (
	id_cust,
	goods_name ,
	price,
	quantity)
VALUES 
(1,'ffds', 5000, 5),
(2,'dfdew' ,7000, 8),
(3,'wfw' ,10000, 98);

SELECT * FROM Sellers;
SELECT * FROM Customers;
SELECT * FROM Orders;
SELECT * FROM Goods;
