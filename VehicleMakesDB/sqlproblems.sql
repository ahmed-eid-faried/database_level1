--   Problem 1: Create Master View

--  Makes.Make, *
-- select count(*) FROM VehicleDetails  JOIN Makes ON (Makes.MakeID = VehicleDetails.MakeID)
-- select count(*) FROM VehicleDetails left JOIN Makes ON (Makes.MakeID = VehicleDetails.MakeID)
-- select count(*) FROM VehicleDetails right JOIN Makes ON (Makes.MakeID = VehicleDetails.MakeID)
-- select count(*) FROM VehicleDetails full outer JOIN Makes ON (Makes.MakeID = VehicleDetails.MakeID)
-- select  *, Makes.Make FROM VehicleDetails right JOIN Makes ON (Makes.MakeID = VehicleDetails.MakeID)
-- select  *, MakeModels.ModelName FROM VehicleDetails right JOIN MakeModels ON (MakeModels.ModelID = VehicleDetails.ModelID)
-- select  *, SubModels.SubModelName FROM VehicleDetails right JOIN SubModels ON (SubModels.SubModelID = VehicleDetails.SubModelID)
-- select  *, FuelTypes.FuelTypeName FROM VehicleDetails right JOIN FuelTypes ON (FuelTypes.FuelTypeID = VehicleDetails.FuelTypeID)
-- select  *, DriveTypes.DriveTypeName FROM VehicleDetails right JOIN DriveTypes ON (DriveTypes.DriveTypeID = VehicleDetails.DriveTypeID)
-- select  *, Bodies.BodyName FROM VehicleDetails right JOIN Bodies ON (Bodies.BodyID = VehicleDetails.BodyID)

CREATE VIEW VehicleMasterDetails
as
    select
        VehicleDetails.*,
        Makes.Make,
        MakeModels.ModelName,
        SubModels.SubModelName,
        FuelTypes.FuelTypeName,
        DriveTypes.DriveTypeName,
        Bodies.BodyName
    FROM
        VehicleDetails
        inner JOIN Makes ON (Makes.MakeID = VehicleDetails.MakeID)
        inner JOIN MakeModels ON (MakeModels.ModelID = VehicleDetails.ModelID)
        inner JOIN SubModels ON (SubModels.SubModelID = VehicleDetails.SubModelID)
        inner JOIN FuelTypes ON (FuelTypes.FuelTypeID = VehicleDetails.FuelTypeID)
        inner JOIN DriveTypes ON (DriveTypes.DriveTypeID = VehicleDetails.DriveTypeID)
        inner JOIN Bodies ON (Bodies.BodyID = VehicleDetails.BodyID);

select *
from VehicleDetails;
select *
from VehicleMasterDetails;
-----------------------------------------------------------------
-----------------------------------------------------------------
-- Problem 2: Get all vehicles made between 1950 and 2000
----------------------------------------------------------
select distinct *
from VehicleDetails
where VehicleDetails.Year between 1950 and 2000;
select distinct VehicleDetails.Vehicle_Display_Name
from VehicleDetails
where VehicleDetails.Year between 1950 and 2000;
-----------------------------------------------------------------
-----------------------------------------------------------------
-- Problem 3 : Get number vehicles made between 1950 and 2000
-------------------------------------------------------------
select distinct count(*) as NumberOfVehicles
from VehicleDetails
where VehicleDetails.Year between 1950 and 2000;
select distinct count(VehicleDetails.Vehicle_Display_Name)as NumberOfVehicles
from VehicleDetails
where VehicleDetails.Year between 1950 and 2000;
-----------------------------------------------------------------
-----------------------------------------------------------------
-- Problem 4 : Get number vehicles made between 1950 and 2000 per make and order them by Number Of Vehicles Descending

select Makes.Make, count(*) as NumberOfVehicles
from VehicleDetails
    inner join Makes on (Makes.MakeID = VehicleDetails.MakeID)
where VehicleDetails.Year between 1950 and 2000
Group by Make
order by NumberOfVehicles Desc;
-----------------------------------------------------------------
-----------------------------------------------------------------
-- Problem 5 : Get All Makes that have manufactured more than 12000 Vehicles in years 1950 to 2000
select Makes.Make, count(*) as NumberOfVehicles
from VehicleDetails
    inner join Makes on (Makes.MakeID = VehicleDetails.MakeID)
where VehicleDetails.Year between 1950 and 2000
Group by Make
having Count(*) > 12000
-- having NumberOfVehicles> 12000--Invalid column name 'NumberOfVehicles'.
order by NumberOfVehicles Desc;

-----------------------------------------------------------------
--other soln without having
select *
from (
select Makes.Make, count(*) as NumberOfVehicles
    from VehicleDetails
        inner join Makes on (Makes.MakeID = VehicleDetails.MakeID)
    where VehicleDetails.Year between 1950 and 2000
    Group by Make 
--The ORDER BY clause is invalid in views, inline functions, derived tables, subqueries, and common table expressions, unless TOP, OFFSET or FOR XML is also specified.
-- order by NumberOfVehicles Desc;
) as R
where R.NumberOfVehicles > 12000
-----------------------------------------------------------------
-----------------------------------------------------------------
--  Problem 6: Get number of vehicles made between 1950 and 2000 per make and add total vehicles column 
select Makes.Make, count(*) as NumberOfVehicles, TotalVehicles=(select count(*) as NumberOfVehicles
    from VehicleDetails)
from VehicleDetails
    inner join Makes on (Makes.MakeID = VehicleDetails.MakeID)
where VehicleDetails.Year between 1950 and 2000
Group by Make
order by NumberOfVehicles Desc;

-----------------------------------------------------------------
-----------------------------------------------------------------
use VehicleMakesDB;
-- Problem 7: Get number of vehicles made between 1950 and 2000 per make and add total vehicles column beside it, then calculate it's percentage
SELECT
    Makes.Make,
    COUNT(*) AS NumberOfVehicles,
    ( SELECT COUNT(*) AS TotalVehicleCount
    FROM VehicleDetails) AS TotalVehicles,
    (COUNT(*) * 1.0 / (SELECT COUNT(*) AS TotalVehicleCount
    FROM VehicleDetails )) AS Percentage
from VehicleDetails
    inner join Makes on (Makes.MakeID = VehicleDetails.MakeID)
where VehicleDetails.Year between 1950 and 2000
Group by Make
order by NumberOfVehicles Desc;
-----------------------------------------------------------------
SELECT * , (NumberOfVehicles*1.0/TotalVehicles*1.0) AS Percentage
FROM (
    select Makes.Make, count(*) as NumberOfVehicles, TotalVehicles=(select count(*) as NumberOfVehicles
        from VehicleDetails)
    from VehicleDetails
        inner join Makes on (Makes.MakeID = VehicleDetails.MakeID)
    where VehicleDetails.Year between 1950 and 2000
    Group by Make
-- order by NumberOfVehicles Desc
) R
ORDER BY  NumberOfVehicles DESC;
-----------------------------------------------------------------
SELECT * , (CAST(NumberOfVehicles AS FLOAT)/CAST(TotalVehicles AS FLOAT)) AS Percentage
FROM (
    select Makes.Make, count(*) as NumberOfVehicles, TotalVehicles=(select count(*) as NumberOfVehicles
        from VehicleDetails)
    from VehicleDetails
        inner join Makes on (Makes.MakeID = VehicleDetails.MakeID)
    where VehicleDetails.Year between 1950 and 2000
    Group by Make
-- order by NumberOfVehicles Desc
) R
ORDER BY  NumberOfVehicles DESC;
-----------------------------------------------------------------
-----------------------------------------------------------------
-- Problem 8: Get Make, FuelTypeName and Number of Vehicles per FuelType per Make
select Makes.Make, FuelTypes.FuelTypeName, count(*) as NumberOfVehicles, TotalVehicles=(select count(*) as NumberOfVehicles
    from VehicleDetails)
from VehicleDetails
    inner join Makes on (Makes.MakeID = VehicleDetails.MakeID)
    inner join FuelTypes on (FuelTypes.FuelTypeID = VehicleDetails.FuelTypeID)
Group by Make , FuelTypeName
order by Make Asc,FuelTypeName ASC
;
-----------------------------------------------------------------
-----------------------------------------------------------------
--   Problem 9: Get all vehicles that runs with GAS
select TOP 1000
    *, FuelTypes.FuelTypeName
from VehicleDetails
    inner join FuelTypes on (FuelTypes.FuelTypeID = VehicleDetails.FuelTypeID)
where FuelTypes.FuelTypeName =N'GAS';--N FOR OTHER LANG AS ARABIC 
-----------------------------------------------------------------
-----------------------------------------------------------------
--     Problem 10: Get all Makes that runs with GAS
select DISTINCT Makes.Make, FuelTypes.FuelTypeName
from VehicleDetails
    inner join Makes on (Makes.MakeID = VehicleDetails.MakeID)
    inner join FuelTypes on (FuelTypes.FuelTypeID = VehicleDetails.FuelTypeID)
where FuelTypes.FuelTypeName =N'GAS';--N FOR OTHER LANG AS ARABIC 
-----------------------------------------------------------------
-----------------------------------------------------------------
--     Problem 11: Get Total Makes that runs with GAS
select count(*) AS TotalMakesRunOnGas
FROM
    (
select DISTINCT (Makes.Make)
    from VehicleDetails
        inner join Makes on (Makes.MakeID = VehicleDetails.MakeID)
        inner join FuelTypes on (FuelTypes.FuelTypeID = VehicleDetails.FuelTypeID)
    where FuelTypes.FuelTypeName =N'GAS'
)R;
-----------------------------------------------------------------
-----------------------------------------------------------------
--   Problem 12: Count Vehicles by make and order them by NumberOfVehicles from high to low.
select Makes.Make, COUNT(*) AS NumberOfVehicles
from VehicleDetails
    inner join Makes on (Makes.MakeID = VehicleDetails.MakeID)
GROUP BY  Makes.Make
ORDER BY NumberOfVehicles DESC;
-----------------------------------------------------------------
-----------------------------------------------------------------
--  Problem 13: Get all Makes/Count Of Vehicles that manufactures more than 20K Vehicles
select Makes.Make, COUNT(*) AS NumberOfVehicles
from VehicleDetails
    inner join Makes on (Makes.MakeID = VehicleDetails.MakeID)
GROUP BY  Makes.Make
HAVING   COUNT(*) >20000
ORDER BY NumberOfVehicles DESC;
-----------------------------------------------------------------
SELECT *
FROM (
    select Makes.Make, COUNT(*) AS NumberOfVehicles
    from VehicleDetails
        inner join Makes on (Makes.MakeID = VehicleDetails.MakeID)
    GROUP BY  Makes.Make
)R
WHERE NumberOfVehicles >20000
ORDER BY NumberOfVehicles DESC;
-----------------------------------------------------------------
-----------------------------------------------------------------
-- Write a query to get all Makes with make starts with 'B'.
SELECT *
FROM Makes
where Makes.Make LIKE 'B%';
-----------------------------------------------------------------
-----------------------------------------------------------------
--Get all  Makes with make ends with 'W'
SELECT *
FROM Makes
where Make Like '%W';
-----------------------------------------------------------------
-----------------------------------------------------------------
--Problem 16: Get all Makes that manufactures DriveTypeName = FWD
select DISTINCT Makes.Make, DriveTypes.DriveTypeName
from VehicleDetails
    inner join Makes on (Makes.MakeID = VehicleDetails.MakeID)
    inner join DriveTypes on (DriveTypes.DriveTypeID = VehicleDetails.DriveTypeID)
where DriveTypes.DriveTypeName =N'FWD';
-----------------------------------------------------------------
-----------------------------------------------------------------
--Problem 17:  Get total Makes that Mantufactures DriveTypeName=FWD
select count(*) AS MakeWithFWD
FROM(
    select DISTINCT Makes.Make, DriveTypes.DriveTypeName
    from VehicleDetails
        inner join Makes on (Makes.MakeID = VehicleDetails.MakeID)
        inner join DriveTypes on (DriveTypes.DriveTypeID = VehicleDetails.DriveTypeID)
    where DriveTypes.DriveTypeName =N'FWD')R;
-----------------------------------------------------------------
-----------------------------------------------------------------
--Problem 18:  Get total vehicles per DriveTypeName Per Make and order them per make asc then per total Desc
select DISTINCT Makes.Make, DriveTypes.DriveTypeName, count(*)AS TotalVehicles
from VehicleDetails
    inner join Makes on (Makes.MakeID = VehicleDetails.MakeID)
    inner join DriveTypes on (DriveTypes.DriveTypeID = VehicleDetails.DriveTypeID)
group by DriveTypes.DriveTypeName  ,Makes.Make
order by Makes.Make asc, TotalVehicles desc;
-----------------------------------------------------------------
-----------------------------------------------------------------
-- Problem 19: Get total vehicles per DriveTypeName Per Make then filter only results with total > 10,000
select DISTINCT Makes.Make, DriveTypes.DriveTypeName, count(*)AS TotalVehicles
from VehicleDetails
    inner join Makes on (Makes.MakeID = VehicleDetails.MakeID)
    inner join DriveTypes on (DriveTypes.DriveTypeID = VehicleDetails.DriveTypeID)
group by DriveTypes.DriveTypeName  ,Makes.Make
having count(*)>10000
order by Makes.Make asc, TotalVehicles desc;
-----------------------------------------------------------------
-----------------------------------------------------------------
--Problem 18:  Get total vehicles per DriveTypeName Per Make and order them per make asc then per total Desc
select DISTINCT Makes.Make, DriveTypes.DriveTypeName, count(*)AS MakeWithFWD
from VehicleDetails
    inner join Makes on (Makes.MakeID = VehicleDetails.MakeID)
    inner join DriveTypes on (DriveTypes.DriveTypeID = VehicleDetails.DriveTypeID)
group by DriveTypes.DriveTypeName  ,Makes.Make
order by Makes.Make asc, MakeWithFWD desc;
-----------------------------------------------------------------
-----------------------------------------------------------------
--Problem 18:  Get total vehicles per DriveTypeName Per Make and order them per make asc then per total Desc
select DISTINCT Makes.Make, DriveTypes.DriveTypeName, count(*)AS MakeWithFWD
from VehicleDetails
    inner join Makes on (Makes.MakeID = VehicleDetails.MakeID)
    inner join DriveTypes on (DriveTypes.DriveTypeID = VehicleDetails.DriveTypeID)
group by DriveTypes.DriveTypeName  ,Makes.Make
order by Makes.Make asc, MakeWithFWD desc;