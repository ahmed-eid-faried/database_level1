-- USE MASTER;
-- CREATE DATABASE OnlineStore;
USE OnlineStore;

CREATE TABLE Images
(
  ImageID INT NOT NULL IDENTITY(1,1),
  PathUrl VARCHAR NOT NULL,
  PRIMARY KEY (ImageID)
);

CREATE TABLE Phones
(
  PhonesID INT NOT NULL IDENTITY(1,1),
  phone VARCHAR NOT NULL,
  PRIMARY KEY (PhonesID)
);

CREATE TABLE Addresses
(
  AddressID INT NOT NULL IDENTITY(1,1),
  Address VARCHAR NOT NULL,
  PRIMARY KEY (AddressID)
);

CREATE TABLE LoginCredentials
(
  LoginCredentialID INT NOT NULL IDENTITY(1,1),
  Password VARCHAR NOT NULL,
  StatusAccount INT NOT NULL,
  PRIMARY KEY (LoginCredentialID)
);

CREATE TABLE ShippingMethods
(
  ShippingMethodID INT NOT NULL IDENTITY(1,1),
  ShippingMethodName VARCHAR NOT NULL,
  PRIMARY KEY (ShippingMethodID)
);

CREATE TABLE OrderStatus
(
  OrderStatusID INT NOT NULL IDENTITY(1,1),
  OrderStatus INT NOT NULL,
  PRIMARY KEY (OrderStatusID)
);

CREATE TABLE PaymentMethods
(
  PaymentMethodID INT NOT NULL IDENTITY(1,1),
  PaymentMethod VARCHAR NOT NULL,
  PRIMARY KEY (PaymentMethodID)
);

CREATE TABLE ShippingStatus
(
  ShippingStatusID INT NOT NULL IDENTITY(1,1),
  ShippingStatus INT NOT NULL,
  PRIMARY KEY (ShippingStatusID)
);

CREATE TABLE Products
(
  ProductID INT NOT NULL IDENTITY(1,1),
  Name VARCHAR NOT NULL,
  Description VARCHAR NOT NULL,
  Price FLOAT NOT NULL,
  QuantityInStock INT NOT NULL,
  OtherRelevantDetails VARCHAR NOT NULL,
  ImageID INT NOT NULL,
  PRIMARY KEY (ProductID),
  FOREIGN KEY (ImageID) REFERENCES Images(ImageID)
);

CREATE TABLE Customers
(
  CustomerID INT NOT NULL IDENTITY(1,1),
  Name VARCHAR NOT NULL,
  Email VARCHAR NOT NULL,
  PhonesID INT NOT NULL,
  AddressShippingID INT NOT NULL,
  LoginCredentialID INT NOT NULL,
  PRIMARY KEY (CustomerID),
  FOREIGN KEY (PhonesID) REFERENCES Phones(PhonesID),
  FOREIGN KEY (AddressShippingID) REFERENCES Addresses(AddressID),
  FOREIGN KEY (LoginCredentialID) REFERENCES LoginCredentials(LoginCredentialID)
);

CREATE TABLE Orders
(
  OrderID INT NOT NULL IDENTITY(1,1),
  DateTimeOrder DATE NOT NULL,
  TotalPrice FLOAT NOT NULL,
  OrderNumber VARCHAR NOT NULL,
  CustomerID INT NOT NULL,
  OrderStatusID INT NOT NULL,
  ShippingMethodID INT NOT NULL,
  PRIMARY KEY (OrderID),
  FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
  FOREIGN KEY (OrderStatusID) REFERENCES OrderStatus(OrderStatusID),
  FOREIGN KEY (ShippingMethodID) REFERENCES ShippingMethods(ShippingMethodID)
);

CREATE TABLE PaymentTransactions
(
  TransactionID INT NOT NULL IDENTITY(1,1),
  PaymentAmount FLOAT NOT NULL,
  Timestamp DATE NOT NULL,
  CustomerID INT NOT NULL,
  PaymentMethodID INT NOT NULL,
  PRIMARY KEY (TransactionID),
  FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
  FOREIGN KEY (PaymentMethodID) REFERENCES PaymentMethods(PaymentMethodID)
);

CREATE TABLE Shipping
(
  ShippingID INT NOT NULL IDENTITY(1,1),
  TrackingNumber INT NOT NULL,
  New_Column INT NOT NULL,
  EstimatedDeliveryDate DATE NOT NULL,
  ActualDeliveryDate DATE NOT NULL,
  NotesOrUpdates VARCHAR NOT NULL,
  ShippingCarrierDetails VARCHAR NOT NULL,
  OrderID INT NOT NULL,
  ShippingStatusID INT NOT NULL,
  PRIMARY KEY (ShippingID),
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
  FOREIGN KEY (ShippingStatusID) REFERENCES ShippingStatus(ShippingStatusID)
);

CREATE TABLE Reviews
(
  ReviewID INT NOT NULL IDENTITY(1,1),
  ReviewText VARCHAR NOT NULL,
  RatingScore INT NOT NULL,
  Timestamps DATE NOT NULL,
  ProductID INT NOT NULL,
  CustomerID INT NOT NULL,
  PRIMARY KEY (ReviewID),
  FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
  FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderProduct
(
  OrderProductID INT NOT NULL IDENTITY(1,1),
  Quantities INT NOT NULL,
  TotalPrice FLOAT NOT NULL,
  ProductID INT NOT NULL,
  OrderID INT NOT NULL,
  PRIMARY KEY (OrderProductID),
  FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);