-- restore database Shop_DB from disk ='/backup/Shop_Databse.bak';
select Customers.CustomerID, Customers.Name, Orders.OrderID, Orders.Amount from  Customers join Orders on Customers.CustomerID=Orders.CustomerID;
select Customers.CustomerID, Customers.Name, Orders.OrderID, Orders.Amount from  Customers inner join Orders on Customers.CustomerID=Orders.CustomerID;
select Customers.CustomerID, Customers.Name, Orders.OrderID, Orders.Amount from Customers left join Orders on Customers.CustomerID = Orders.CustomerID;
select Customers.CustomerID, Customers.Name, Orders.OrderID, Orders.Amount from Customers left outer join Orders on Customers.CustomerID=Orders.CustomerID;
select Customers.CustomerID, Customers.Name, Orders.OrderID, Orders.Amount from Customers right join Orders on Customers.CustomerID=Orders.CustomerID;
select Customers.CustomerID, Customers.Name, Orders.OrderID, Orders.Amount from Customers right outer join Orders on Customers.CustomerID=Orders.CustomerID;
select Customers.CustomerID, Customers.Name, Orders.OrderID, Orders.Amount from Customers full outer join Orders on Customers.CustomerID=Orders.CustomerID;
 