
select * from ActiveEmployees
select * from InActiveEmployees

select * from ActiveEmployees
union
select * from InActiveEmployees

--this will remove the redundancy from the resultset (distinct results only)
select * from Departments
union 
select * from Departments;
--this will append data regardeless of any redundancy
select * from Departments
union ALL
select * from Departments;