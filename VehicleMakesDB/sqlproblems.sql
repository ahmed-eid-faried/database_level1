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
 
 CREATE VIEW VehicleMasterDetails as
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
 
select * from VehicleDetails;
select * from VehicleMasterDetails;
-----------------------------------------------------------------
-----------------------------------------------------------------
-- Problem 2: Get all vehicles made between 1950 and 2000
----------------------------------------------------------
select distinct * from VehicleDetails where VehicleDetails.Year between 1950 and 2000;
select distinct VehicleDetails.Vehicle_Display_Name from VehicleDetails where VehicleDetails.Year between 1950 and 2000;
-----------------------------------------------------------------
-----------------------------------------------------------------
-- Problem 3 : Get number vehicles made between 1950 and 2000
-------------------------------------------------------------
select distinct count(*) as NumberOfVehicles from VehicleDetails where VehicleDetails.Year between 1950 and 2000;
select distinct count(VehicleDetails.Vehicle_Display_Name)as NumberOfVehicles  from VehicleDetails where VehicleDetails.Year between 1950 and 2000;
-----------------------------------------------------------------
-----------------------------------------------------------------
-- Problem 4 : Get number vehicles made between 1950 and 2000 per make and order them by Number Of Vehicles Descending

select Makes.Make, count(*) as count from VehicleDetails
inner join Makes on (Makes.MakeID = VehicleDetails.MakeID)
where VehicleDetails.Year between 1950 and 2000
Group by Make
order by count Desc;
 