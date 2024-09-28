
use HR_DB;
-----------------------------------------
select ID, Name=FirstName+' '+LastName, GendorTitle=
case 
    when Gendor='M' then 'Male'
    when Gendor='F' then 'Female'
    else 'unknown'
end 
from Employees order by Name;
-------------------------------------------------------
select ID,Name= FirstName+' '+LastName, 
GendorTitle=
case 
    when Gendor='M' then 'Male'
    when Gendor='F' then 'Female'
    else 'UNKNOWN'
end ,
Status=
CASE
    WHEN ExitDate is null THEN 'Active'
    WHEN ExitDate is not null THEN 'Resigned'
    else 'unknown'
END
from Employees;
-------------------------------------------------------
select ID, FirstName, LastName,MonthlySalary,
NewSalaryToBe =
CASE
    WHEN MonthlySalary>1000 THEN MonthlySalary * 1.1
    WHEN MonthlySalary<=1000 THEN MonthlySalary * 1.2
END
from Employees
-------------------------------------------------------
