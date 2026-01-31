USE test;
GO

SELECT TABLE_SCHEMA, TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'Sellers';

SELECT sellers.lname_sel,customers.lname_cust,customers.city_cust
FROM sellers, customers
WHERE sellers.city_sel = customers.city_cust

