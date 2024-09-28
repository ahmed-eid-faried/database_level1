create view  ActiveEmployees as 
(select * from Employees where ExitDate is null);

create view  InActiveEmployees as 
select * from Employees where ExitDate is not null;

create view  ShowActiveEmployees as 
select ID, Name=FirstName+' '+LastName,Gendor, Age=DATEDIFF(YEAR,DateOfBirth,getDate()), MonthlySalary from Employees where ExitDate is not null;



select * from ShowActiveEmployees where ShowActiveEmployees.ID=290;