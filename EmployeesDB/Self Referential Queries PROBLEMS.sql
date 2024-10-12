USE EmployeesDB;
-----------------------------------------------------------------
-----------------------------------------------------------------
--   Problem 51: Get all employees that have manager along with Manager's name.
SELECT * FROM Employees;
SELECT Employees.EmployeeID, Employees.Name, Employees.Salary, Employees.ManagerID, Managers.Name AS Manager FROM Employees 
INNER JOIN Employees AS Managers ON Employees.ManagerID=Managers.EmployeeID
WHERE Employees.ManagerID IS NOT NULL;

-- Get all employees that have manager along with Manager's name.
-- this will select all data from employees that are managed by someone along with their manager name, 
-- employees that have no manager will not be selected because we used inner join 
-- Note we used inner join on the same table with diffrent alliace.
-----------------------------------------------------------------
-----------------------------------------------------------------
--   Problem 52: Get all employees that have manager or does not have manager along with Manager's name, incase no manager name show null
SELECT Employees.EmployeeID, Employees.Name, Employees.Salary, Employees.ManagerID, Managers.Name AS Manager FROM Employees 
LEFT JOIN Employees AS Managers ON Employees.ManagerID=Managers.EmployeeID;
 