select IsExisted='Yes' where exists (select * from Orders where Orders.CustomerID=3 and Orders.Amount<1000);
select * from Customers where exists (select * from Orders where Orders.CustomerID=3 and Orders.Amount<1000);
select * from Customers T1 where exists (select * from Orders where Orders.CustomerID=T1.CustomerID and Orders.Amount<1000);
 --More optimized and faster
select * from Customers T1 where exists (select top 1 * from Orders where Orders.CustomerID=T1.CustomerID and Orders.Amount<1000);
 --More optimized and faster
select * from Customers T1 where exists (select top 1 R='Y' from Orders where Orders.CustomerID=T1.CustomerID and Orders.Amount<1000); 