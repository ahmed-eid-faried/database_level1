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
------------------------------------------------------
CREATE TABLE Persons (
   ID int NOT NULL,
   LastName varchar(255) NOT NULL,
   FirstName varchar(255) NOT NULL,
   Age int
);

ALTER TABLE Persons
ALTER COLUMN Age int NOT NULL;
------------------------------------------------------
------------------------------------------------------

