-- DQL_Database_Query_Langauge
------------------------------------------------------
-------------Select Distinct Statement----------------
------------------------------------------------------
Select * from Employees;

Select Employees.* from Employees;

Select ID, FirstName, LastName,MonthlySalary From Employees;

Select ID, FirstName, DateOfBirth From Employees;

Select * from Departments;

Select * from Countries;
------------------------------------------------------
-----------Where Statement + AND , OR, NOT------------
------------------------------------------------------
Select DepartmentID from Employees;

Select Distinct  DepartmentID from Employees;

Select FirstName from Employees;

Select Distinct  FirstName from Employees;


Select FirstName, DepartmentID from Employees;

Select distinct FirstName, DepartmentID from Employees;
------------------------------------------------------
----------------------In Operator---------------------
------------------------------------------------------

select * from Employees
where DepartmentID=1 Or DepartmentID=2;


select * from Employees
where DepartmentID=1 Or DepartmentID=2 or DepartmentID=7;


select * from Employees
where DepartmentID=1 Or DepartmentID=2 or DepartmentID=5 or DepartmentID=7;


select * from Employees
where DepartmentID in (1,2,5,7);


select * from Employees
where FirstName in ('Jacob','Brooks','Harper');


select Departments.Name from Departments 
where 
ID in ( select DepartmentID from Employees where MonthlySalary <=210 );


select Departments.Name from Departments 
where 
ID not in ( select DepartmentID from Employees where MonthlySalary <=210 );
------------------------------------------------------
-------------------Sorting : Order By-----------------
------------------------------------------------------
select ID, FirstName,MonthlySalary from Employees
where DepartmentID=1


select ID, FirstName,MonthlySalary from Employees
where DepartmentID=1
Order By FirstName ;

select ID, FirstName,MonthlySalary from Employees
where DepartmentID=1
Order By FirstName ASC;

select ID, FirstName,MonthlySalary from Employees
where DepartmentID=1
Order By FirstName desc;

select ID, FirstName,MonthlySalary from Employees
where DepartmentID=1
Order By MonthlySalary ;


select ID, FirstName,MonthlySalary from Employees
where DepartmentID=1
Order By MonthlySalary Asc;


select ID, FirstName,MonthlySalary from Employees
where DepartmentID=1
Order By MonthlySalary Desc;



select ID, FirstName,MonthlySalary from Employees
where DepartmentID=1
Order By FirstName , MonthlySalary ;


select ID, FirstName,MonthlySalary from Employees
where DepartmentID=1
Order By FirstName ASC, MonthlySalary Desc;
------------------------------------------------------
------------------Select Top Statement----------------
------------------------------------------------------

Select * from Employees;


-- This will show top 5 employees.
Select top 5 * from Employees;


-- This will show top 10% of the data.
select top 10 percent * from Employees;

-- this will show the all salaries ordered from the heighest to lowest.
select  MonthlySalary from employees
order by MonthlySalary Desc;



-- this will show the all salaries ordered from the heighest to lowest without redundancy.
select distinct MonthlySalary from employees
order by MonthlySalary Desc;

-- this will show the heighest 3 salaries.
select  distinct  top 3 MonthlySalary from employees
order by MonthlySalary Desc;


--This will show all employees who takes one of the heighest 3 salaries.

select ID , FirstName, MonthlySalary from Employees where MonthlySalary In
(
	select  distinct  top 3 MonthlySalary from employees
	order by MonthlySalary Desc
)

Order By MonthlySalary Desc



--This will show all employees who takes one of the Lowest 3 salaries.
select ID , FirstName, MonthlySalary from Employees where MonthlySalary In
(
	select  distinct  top 3 MonthlySalary from employees
	order by MonthlySalary ASC
)

Order By MonthlySalary ASC


------------------------------------------------------
-----------------------Select As----------------------
------------------------------------------------------


Select A= 5 * 4 , B= 6/2 



Select A= 5 * 4 , B= 6/2 
from employees



Select ID, FirstName,  A = MonthlySalary/2
from employees


Select ID, FirstName + ' ' + LastName as FullName From Employees;


Select ID, FullName = FirstName + ' ' + LastName  From Employees;


select ID, FirstName , MonthlySalary , YealySalary = MonthlySalary * 12  from employees;


select ID, FirstName , MonthlySalary , YealySalary =MonthlySalary* 12 , BonusAmount= MonthlySalary * BonusPerc  from employees;


select Today = getDate()


select ID, FullName= FirstName + ' ' + LastName, Age = DATEDIFF(Year , DateOfBirth ,getDate()) from Employees;


------------------------------------------------------
-------------------Between Operator-------------------
------------------------------------------------------
Select * from Employees where
(MonthlySalary >=500 and MonthlySalary <=1000)


Select * from Employees where
MonthlySalary Between 500 and 1000;
------------------------------------------------------
----------Count, Sum, Avg, Min, Max Functions---------
------------------------------------------------------

select TotalCount=Count(MonthlySalary), 
	   TotalSum=Sum(MonthlySalary),
	   Average=Avg(MonthlySalary),
	   MinSalary=Min(MonthlySalary),
	   MaxSalary=Max(MonthlySalary) 
	   
	   from Employees;



select  TotalCount=Count(MonthlySalary), 
	   TotalSum=Sum(MonthlySalary),
	   Average=Avg(MonthlySalary),
	   MinSalary=Min(MonthlySalary),
	   MaxSalary=Max(MonthlySalary) 
	   
	   from Employees where DepartmentID=1
	   
	   
select * from employees;

select TotalEmployees = count (ID) from Employees;

--count function only counts the not null values.
select ResignedEmployees= count(ExitDate)  from employees;
------------------------------------------------------
-----------------------Group By-----------------------
------------------------------------------------------

select TotalCount=Count(MonthlySalary), 
	   TotalSum=Sum(MonthlySalary),
	   Average=Avg(MonthlySalary),
	   MinSalary=Min(MonthlySalary),
	   MaxSalary=Max(MonthlySalary) 
	   
	   from Employees;


select  TotalCount=Count(MonthlySalary), 
	   TotalSum=Sum(MonthlySalary),
	   Average=Avg(MonthlySalary),
	   MinSalary=Min(MonthlySalary),
	   MaxSalary=Max(MonthlySalary) 
	   
	   from Employees where DepartmentID=3
	   

select DepartmentID, TotalCount=Count(MonthlySalary), 
	   TotalSum=Sum(MonthlySalary),
	   Average=Avg(MonthlySalary),
	   MinSalary=Min(MonthlySalary),
	   MaxSalary=Max(MonthlySalary) 
	   
	   from Employees
       Group By DepartmentID
	   order by DepartmentID
------------------------------------------------------
------------------------Having------------------------
------------------------------------------------------

select DepartmentID, TotalCount=Count(MonthlySalary), 
	   TotalSum=Sum(MonthlySalary),
	   Average=Avg(MonthlySalary),
	   MinSalary=Min(MonthlySalary),
	   MaxSalary=Max(MonthlySalary) 
	   
	   from Employees
	
       Group By DepartmentID
	  
	   order by DepartmentID


--Having is the where satement for group by
select DepartmentID, TotalCount=Count(MonthlySalary), 
	   TotalSum=Sum(MonthlySalary),
	   Average=Avg(MonthlySalary),
	   MinSalary=Min(MonthlySalary),
	   MaxSalary=Max(MonthlySalary) 
	   
	   from Employees
       Group By DepartmentID
	  having Count(MonthlySalary) > 100



-- Same solution without having :-)
select * from 
(

   select DepartmentID, TotalCount=Count(MonthlySalary), 
	   TotalSum=Sum(MonthlySalary),
	   Average=Avg(MonthlySalary),
	   MinSalary=Min(MonthlySalary),
	   MaxSalary=Max(MonthlySalary) 
	   
	   from Employees
	
       Group By DepartmentID
	  
) R1

where R1.TotalCount> 100;
------------------------------------------------------
-------------------------Like-------------------------
------------------------------------------------------

select * from Employees;

--Finds any values that start with "a"
select ID, FirstName from Employees
where FirstName like 'a%';


--Finds any values that end with "a"
select ID, FirstName from Employees
where FirstName like '%a';


--Finds any values that have "tell" in any position
select ID, FirstName from Employees
where FirstName like '%tell%';

--	Finds any values that start with "a" and ends with "a"
select ID, FirstName from Employees
where FirstName like 'a%a';

--Finds any values that have "a" in the second position
select ID, FirstName from Employees
where FirstName like '_a%';

--Finds any values that have "a" in the third position
select ID, FirstName from Employees
where FirstName like '__a%';


--Finds any values that start with "a" and are at least 3 characters in length
select ID, FirstName from Employees
where FirstName like 'a__%';

--Finds any values that start with "a" and are at least 4 characters in length
select ID, FirstName from Employees
where FirstName like 'a___%';



--Finds any values that start with "a"
select ID, FirstName from Employees
where FirstName like 'a%' or FirstName like 'b%' ;
------------------------------------------------------
-----------------------WildCards----------------------
------------------------------------------------------

--Execute these satatements to update data
Update Employees 
set FirstName ='Mohammed' , LastName='Abu-Hadhoud'
where ID= 285;


Update Employees 
set FirstName ='Mohammad' , LastName='Maher'
where ID= 286;

--------------------------------

select ID, FirstName, LastName from Employees
Where firstName = 'Mohammed' or FirstName ='Mohammad'; 


-- will search form Mohammed or Mohammad
select ID, FirstName, LastName from Employees
Where firstName like 'Mohamm[ae]d';

-------------------------------------

--You can use Not 
select ID, FirstName, LastName from Employees
Where firstName Not like 'Mohamm[ae]d';

--------------------

select ID, FirstName, LastName from Employees
Where firstName like 'a%' or firstName like 'b%' or firstName like 'c%';


-- search for all employees that their first name start with a or b or c
select ID, FirstName, LastName from Employees
Where firstName like '[abc]%';


---------------------------------
-- search for all employees that their first name start with any letter from a to l
select ID, FirstName, LastName from Employees
Where firstName like '[a-l]%';
---------------------------------
------------------------------------------------------
------------------------------------------------------
------------------------------------------------------
