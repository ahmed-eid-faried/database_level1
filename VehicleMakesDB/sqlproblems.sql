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
--   Problem 20: Get all Vehicles that number of doors is not specified
SELECT *
FROM VehicleDetails
WHERE VehicleDetails.NumDoors IS NULL;
-----------------------------------------------------------------
-----------------------------------------------------------------
--  Problem 21: Get Total Vehicles that number of doors is not specified
SELECT COUNT(*) AS TotalWithNoSpecifiedDoors
FROM VehicleDetails
WHERE VehicleDetails.NumDoors IS NULL;
-----------------------------------------------------------------
-----------------------------------------------------------------
--    Problem 22: Get percentage of vehicles that has no doors specified
SELECT (CAST(COUNT(*) AS FLOAT) /(SELECT CAST(COUNT(*) AS FLOAT)
    FROM VehicleDetails)) AS PercOfNoSpecifiedDoors
FROM VehicleDetails
WHERE VehicleDetails.NumDoors IS NULL;

--Get percentage of vehicles that has no doors specified
select
    (
		CAST(	(select count(*) as TotalWithNoSpecifiedDoors
    from VehicleDetails
    where NumDoors is Null) as float)
		/	
		Cast( (select count(*)
    from VehicleDetails as TotalVehicles) as float)
	) as PercOfNoSpecifiedDoors
-----------------------------------------------------------------
-----------------------------------------------------------------
-- Problem 23: Get MakeID , Make, SubModelName for all vehicles that have SubModelName 'Elite'
SELECT DISTINCT VehicleDetails.MakeID , Make, SubModelName
FROM VehicleDetails
    INNER JOIN Makes ON Makes.MakeID =VehicleDetails.MakeID
    INNER JOIN SubModels ON SubModels.ModelID =VehicleDetails.ModelID
WHERE SubModelName ='Elite';
-----------------------------------------------------------------
-----------------------------------------------------------------
--  Problem 24: Get all vehicles that have Engines > 3 Liters and have only 2 doors
select *
from VehicleDetails
WHERE VehicleDetails.Engine_Liter_Display>3 and NumDoors =2;
-----------------------------------------------------------------
-----------------------------------------------------------------
--  Problem 25: Get make and vehicles that the engine contains 'OHV' and have Cylinders = 4
SELECT VehicleDetails.*, Make
FROM VehicleDetails
    INNER JOIN Makes ON Makes.MakeID =VehicleDetails.MakeID
WHERE VehicleDetails.Engine LIKE '%OHV%'AND VehicleDetails.Engine_Cylinders=4
;
-----------------------------------------------------------------
-----------------------------------------------------------------
--   Problem 26: Get all vehicles that their body is 'Sport Utility' and Year > 2020
SELECT *, Bodies.BodyName
FROM VehicleDetails
    INNER JOIN Bodies ON Bodies.BodyID =VehicleDetails.BodyID
WHERE Bodies.BodyName = 'Sport Utility' AND VehicleDetails.Year > 2020;
-----------------------------------------------------------------
-----------------------------------------------------------------
--   Problem 27: Get all vehicles that their Body is 'Coupe' or 'Hatchback' or 'Sedan'
SELECT top 1000
    *, Bodies.BodyName
FROM VehicleDetails
    INNER JOIN Bodies ON Bodies.BodyID =VehicleDetails.BodyID
WHERE Bodies.BodyName  in ('Coupe' ,'Hatchback' ,'Sedan' );
-----------------------------------------------------------------
-----------------------------------------------------------------
--   Problem 28: Get all vehicles that their body is 'Coupe' or 'Hatchback' or 'Sedan' and manufactured in year 2008 or 2020 or 2021
SELECT top 1000
    *, Bodies.BodyName
FROM VehicleDetails
    INNER JOIN Bodies ON Bodies.BodyID =VehicleDetails.BodyID
WHERE Bodies.BodyName  in ('Coupe' ,'Hatchback' ,'Sedan' ) and VehicleDetails.Year in (2008,2020,2021);
-----------------------------------------------------------------
-----------------------------------------------------------------
--   Problem 29: Return found=1 if there is any vehicle made in year 1950
SELECT FOUND=1
WHERE EXISTS(SELECT TOP 1
    *
FROM VehicleDetails
WHERE YEAR=1950)
-----------------------------------------------------------------
-----------------------------------------------------------------
--   Problem 30: Get all Vehicle_Display_Name, NumDoors and add extra column to describe number of doors by words, and if door is null display 'Not Set'
SELECT DISTINCT VehicleDetails.NumDoors
FROM VehicleDetails;
-- to get all cases -->> 0 1 2 3 4 5 6 8 NULL
SELECT VehicleDetails.Vehicle_Display_Name, VehicleDetails.NumDoors,
    CASE 
    WHEN VehicleDetails.NumDoors=0 THEN  'Zero Doors'
    WHEN VehicleDetails.NumDoors=1 THEN  'One Doors'
    WHEN VehicleDetails.NumDoors=2 THEN  'Two Doors'
    WHEN VehicleDetails.NumDoors=3 THEN  'Three Doors'
    WHEN VehicleDetails.NumDoors=4 THEN  'Four Doors'
    WHEN VehicleDetails.NumDoors=5 THEN  'Five Doors'
    WHEN VehicleDetails.NumDoors=6 THEN  'Six Doors'
    WHEN VehicleDetails.NumDoors=8 THEN  'Eight Doors'
    WHEN VehicleDetails.NumDoors is null THEN  'Not Set'
    ELSE 'Unknown'
END
AS DoorDescriptions
FROM VehicleDetails;
-----------------------------------------------------------------
-----------------------------------------------------------------
--   Problem 31: Get all Vehicle_Display_Name, year and add extra column to calculate the age of the car then sort the results by age desc.
SELECT VehicleDetails.Vehicle_Display_Name, VehicleDetails.Year, Age= YEAR(GetDate()) - VehicleDetails.year
FROM VehicleDetails
Order by Age Desc;
-----------------------------------------------------------------
-----------------------------------------------------------------
--   Problem 32: Get all Vehicle_Display_Name, year, Age for vehicles that their age between 15 and 25 years old
SELECT *
FROM
    (SELECT VehicleDetails.Vehicle_Display_Name, VehicleDetails.Year, AGE= YEAR(GETDATE())-VehicleDetails.Year
    FROM VehicleDetails)R
WHERE AGE BETWEEN 15 AND 25
ORDER BY Age Desc;
-----------------------------------------------------------------
-----------------------------------------------------------------
--   Problem 33: Get Minimum Engine CC , Maximum Engine CC , and Average Engine CC of all Vehicles
SELECT MIN(VehicleDetails.Engine_CC) AS 'Minimum Engine CC', MAX(VehicleDetails.Engine_CC) AS 'Maximum Engine CC', AVG(VehicleDetails.Engine_CC) AS 'Average Engine CC'
FROM VehicleDetails;
-----------------------------------------------------------------
-----------------------------------------------------------------
--   Problem 34: Get all vehicles that have the minimum Engine_CC
SELECT *
FROM VehicleDetails
WHERE VehicleDetails.Engine_CC=(
    SELECT MIN(VehicleDetails.Engine_CC)
FROM VehicleDetails
);
-----------------------------------------------------------------
-----------------------------------------------------------------
--   Problem 35: Get all vehicles that have the Maximum Engine_CC
SELECT *
FROM VehicleDetails
WHERE VehicleDetails.Engine_CC=(
    SELECT MAX(VehicleDetails.Engine_CC)
FROM VehicleDetails
);
-----------------------------------------------------------------
-----------------------------------------------------------------
--   Problem 36: Get all vehicles that have Engin_CC below average
SELECT *
FROM VehicleDetails
WHERE VehicleDetails.Engine_CC<(
    SELECT AVG(VehicleDetails.Engine_CC)
FROM VehicleDetails
);
-----------------------------------------------------------------
-----------------------------------------------------------------
--   Problem 37: Get total vehicles that have Engin_CC above average
SELECT COUNT(*)as NumberOfVehiclesAboveAverageEngineCC
FROM VehicleDetails
WHERE VehicleDetails.Engine_CC>(
    SELECT AVG(VehicleDetails.Engine_CC)
FROM VehicleDetails
);
select Count(*) as NumberOfVehiclesAboveAverageEngineCC
from
    (
 
	Select ID, VehicleDetails.Vehicle_Display_Name
    from VehicleDetails
    where Engine_CC > ( select Avg(Engine_CC) as MinEngineCC
    from VehicleDetails )

) R1;
-----------------------------------------------------------------
-----------------------------------------------------------------
--   Problem 38: Get all unique Engin_CC and sort them Desc
SELECT DISTINCT VehicleDetails.Engine_CC
FROM VehicleDetails
ORDER BY Engine_CC DESC;
-----------------------------------------------------------------
-----------------------------------------------------------------
--   Problem 39: Get the maximum 3 Engine CC
SELECT DISTINCT TOP 3
    VehicleDetails.Engine_CC
FROM VehicleDetails
ORDER BY Engine_CC DESC;
-----------------------------------------------------------------
-----------------------------------------------------------------
--   Problem 40: Get all vehicles that has one of the Max 3 Engine CC
SELECT *
FROM VehicleDetails
WHERE VehicleDetails.Engine_CC IN
(SELECT DISTINCT TOP 3
    VehicleDetails.Engine_CC
FROM VehicleDetails
ORDER BY Engine_CC DESC);
-----------------------------------------------------------------
-----------------------------------------------------------------
--   Problem 41: Get all Makes that manufactures one of the Max 3 Engine CC
SELECT DISTINCT Makes.Make
FROM VehicleDetails
    inner join Makes ON  Makes.MakeID =VehicleDetails.MakeID
WHERE VehicleDetails.Engine_CC IN
(SELECT DISTINCT TOP 3
    VehicleDetails.Engine_CC
FROM VehicleDetails
ORDER BY Engine_CC DESC)
ORDER BY Make ASC;
-----------------------------------------------------------------
-----------------------------------------------------------------
--   Problem 42: Get a table of unique Engine_CC and calculate tax per Engine CC
-- Get a table of unique Engine_CC and calculate tax per Engine CC as follows:
-- 0 to 1000    Tax = 100
-- 1001 to 2000 Tax = 200
-- 2001 to 4000 Tax = 300
-- 4001 to 6000 Tax = 400
-- 6001 to 8000 Tax = 500
-- Above 8000   Tax = 600
-- Otherwise    Tax = 0
SELECT DISTINCT Engine_CC,
    CASE
    WHEN Engine_CC BETWEEN 0 AND 1000 then 100
    WHEN Engine_CC BETWEEN 1001 AND 2000 then 200
    WHEN Engine_CC BETWEEN 2001 AND 4000 then 300
    WHEN Engine_CC BETWEEN 4001 AND 6000 then 400
    WHEN Engine_CC BETWEEN 6001 AND 8000 then 500
    WHEN Engine_CC > 8000  then 600
    ELSE 0
END AS TAX
FROM VehicleDetails
ORDER BY Engine_CC DESC;
