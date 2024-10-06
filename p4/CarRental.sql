-- USE MASTER;
-- CREATE DATABASE CarRental;
USE CarRental;

CREATE TABLE Customers
(
  CustomerID INT NOT NULL IDENTITY(1,1),
  Name INT NOT NULL,
  Phone INT NOT NULL,
  DriverLicenseNumber INT NOT NULL,
  PRIMARY KEY (CustomerID)
);

CREATE TABLE VehicleCategories
(
  VehicleCategoryID INT NOT NULL IDENTITY(1,1),
  Category INT NOT NULL,
  PRIMARY KEY (VehicleCategoryID)
);

CREATE TABLE RentalTransaction
(
  RentalTransactionID INT NOT NULL IDENTITY(1,1),
  PaymentDetails VARCHAR NOT NULL,
  InitialPaidAmount FLOAT NOT NULL,
  PRIMARY KEY (RentalTransactionID)
);

CREATE TABLE VehicleReturn
(
  VehicleReturnID INT NOT NULL IDENTITY(1,1),
  ActualReturnDate DATE NOT NULL,
  ActualRentalDays INT NOT NULL,
  FinalVehicleCheckNotes DATE NOT NULL,
  AdditionalCharges FLOAT NOT NULL,
  RemainingAmount FLOAT NOT NULL,
  ConsumedMileageByCustomer FLOAT NOT NULL,
  RentalTransactionID INT NOT NULL,
  PRIMARY KEY (VehicleReturnID),
  FOREIGN KEY (RentalTransactionID) REFERENCES RentalTransaction(RentalTransactionID)
);

CREATE TABLE Vehicles
(
  VehicleID INT NOT NULL IDENTITY(1,1),
  Make VARCHAR NOT NULL,
  Year DATE NOT NULL,
  Model VARCHAR NOT NULL,
  Mileage VARCHAR NOT NULL,
  RentalRates INT NOT NULL,
  FuelType INT NOT NULL,
  PlateNumber INT NOT NULL,
  VehicleCategoryID INT NOT NULL,
  PRIMARY KEY (VehicleID),
  FOREIGN KEY (VehicleCategoryID) REFERENCES VehicleCategories(VehicleCategoryID)
);

CREATE TABLE VehicleBooking
(
  VehicleBookingID INT NOT NULL IDENTITY(1,1),
  StartDate DATE NOT NULL,
  EndDate DATE NOT NULL,
  InitialRentalDays INT NOT NULL,
  DropOfLocation VARCHAR NOT NULL,
  PickupLocation VARCHAR NOT NULL,
  InitialTotalDueAmount FLOAT NOT NULL,
  InitialVehicleCheckNotes VARCHAR NOT NULL,
  VehicleID INT NOT NULL,
  CustomerID INT NOT NULL,
  RentalTransactionID INT NOT NULL,
  PRIMARY KEY (VehicleBookingID),
  FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID),
  FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
  FOREIGN KEY (RentalTransactionID) REFERENCES RentalTransaction(RentalTransactionID)
);