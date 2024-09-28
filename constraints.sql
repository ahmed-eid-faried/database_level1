-- The following constraints are commonly used in SQL:
------------------------------------------------------
-- NOT NULL - Ensures that a column cannot have a NULL value
-- UNIQUE - Ensures that all values in a column are different
-- PRIMARY KEY - A combination of a NOT NULL and UNIQUE. Uniquely identifies each row in a table
-- FOREIGN KEY - Prevents actions that would destroy links between tables
-- CHECK - Ensures that the values in a column satisfies a specific condition
-- DEFAULT - Sets a default value for a column if no value is specified
-- CREATE INDEX - Used to create and retrieve data from the database very quickly

-- Constraint
------------------------------------------------------
--------------------PRIMARY KEY-----------------------
------------------------------------------------------
CREATE TABLE Persons(
    ID int not null primary key,
    FirstName NVARCHAR(255) not null,
    LastName NVARCHAR(255) not null,
    BirthDay DATE,
);
CREATE TABLE Persons2 (
   ID int NOT NULL,
   LastName NVARCHAR(255) NOT NULL,
   FirstName NVARCHAR(255) NOT NULL,
   Age int,
   CONSTRAINT PK_Person PRIMARY KEY (ID,LastName)
);
ALTER TABLE Persons2 DROP CONSTRAINT PK_Person;
ALTER TABLE Persons2 ADD PRIMARY KEY (ID);
ALTER TABLE Persons2 ADD CONSTRAINT PK_Person PRIMARY KEY (ID);
ALTER TABLE Persons2 ADD CONSTRAINT PK_Person PRIMARY KEY (ID,LastName);
------------------------------------------------------
--------------------FOREIGN KEY-----------------------
------------------------------------------------------
CREATE TABLE Orders (
   OrderID int NOT NULL PRIMARY KEY,
   OrderNumber int NOT NULL,
   PersonID int FOREIGN KEY REFERENCES Persons(PersonID),
);

CREATE TABLE Orders (
   OrderID int NOT NULL,
   OrderNumber int NOT NULL,
   PersonID int,
   PRIMARY KEY (OrderID),
   CONSTRAINT FK_PersonOrder FOREIGN KEY (PersonID) REFERENCES Persons(PersonID),
);

ALTER TABLE Orders
ADD FOREIGN KEY (PersonID) REFERENCES Persons(PersonID);

ALTER TABLE Orders
ADD CONSTRAINT FK_PersonOrder FOREIGN KEY (PersonID) REFERENCES Persons(PersonID);

ALTER TABLE Orders
DROP CONSTRAINT FK_PersonOrder;
------------------------------------------------------
----------------------NOT NULL------------------------
------------------------------------------------------
CREATE TABLE Persons3 (
   ID int NOT NULL,
   LastName varchar(255) NOT NULL,
   FirstName varchar(255) NOT NULL,
   Age int
);

ALTER TABLE Persons
ALTER COLUMN Age int NOT NULL;
------------------------------------------------------
-----------------------DEFAULT------------------------
------------------------------------------------------
CREATE TABLE Persons4 (
   ID int NOT NULL,
   LastName varchar(255) NOT NULL,
   FirstName varchar(255),
   Age int,
   City varchar(255) DEFAULT 'Egypt'
);

CREATE TABLE Orders2 (
   ID int NOT NULL,
   OrderNumber int NOT NULL,
   OrderDate date DEFAULT GETDATE() 
);

ALTER TABLE Persons4 ADD CONSTRAINT df_City DEFAULT 'Amman' FOR City;
ALTER TABLE Persons DROP Constraint  df_City;
------------------------------------------------------
-----------------------CHECK--------------------------
------------------------------------------------------
CREATE TABLE Persons5 (
   ID int NOT NULL,
   LastName varchar(255) NOT NULL,
   FirstName varchar(255),
   Age int CHECK (Age>=18),
);

CREATE TABLE Persons5 (
   ID int NOT NULL,
   LastName varchar(255) NOT NULL,
   FirstName varchar(255),
   Age int,
   City varchar(255),
    CONSTRAINT CHK_Person CHECK (Age>=18 AND City='cairo')
);

ALTER TABLE Persons5
DROP CONSTRAINT CHK_Person; 
------------------------------------------------------
------------------------------------------------------
------------------------------------------------------
CREATE TABLE Persons6 (
   ID int NOT NULL UNIQUE,
   LastName varchar(255) NOT NULL,
   FirstName varchar(255),
   Age int
);

CREATE TABLE Persons6 (
   ID int NOT NULL,
   LastName varchar(255) NOT NULL,
   FirstName varchar(255),
   Age int,
    CONSTRAINT UC_Person UNIQUE (ID,LastName),
    CONSTRAINT UN_PERSON UNIQUE (ID,FirstName),
);

ALTER TABLE Persons6
ADD UNIQUE (ID);

ALTER TABLE Persons6
ADD CONSTRAINT UC_Person UNIQUE (ID,LastName);

ALTER TABLE Persons6
DROP CONSTRAINT UC_Person;
------------------------------------------------------
-------------------------INDEX------------------------
------------------------------------------------------
CREATE TABLE Persons7 (
   ID int NOT NULL PRIMARY KEY,
   FirstName varchar(255)NOT NULL,
   LastName varchar(255) NOT NULL,
   Age int
);
-- CREATE INDEX index_name ON table_name (column1, column2, ...);
CREATE INDEX INDEX_FIRSTNAME ON Persons7(FirstName);
CREATE INDEX INDEX_NAME ON Persons7 (LastName, FirstName);
-- DROP INDEX table_name.index_name;
DROP INDEX Persons7.INDEX_NAME;
DROP INDEX Persons7.INDEX_FIRSTNAME;
DROP TABLE Persons7;
------------------------------------------------------
------------------------------------------------------
------------------------------------------------------
