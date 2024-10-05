CREATE TABLE Persons
(
  PersonID INT NOT NULL IDENTITY(1,1),
  Name VARCHAR NOT NULL,
  Email VARCHAR NOT NULL,
  Address VARCHAR NOT NULL,
  Phone VARCHAR NOT NULL,
  PRIMARY KEY (PersonID)
);

CREATE TABLE Instructors
(
  InstructorID INT NOT NULL IDENTITY(1,1),
  Qualifications VARCHAR NOT NULL,
  PersonID INT NOT NULL,
  PRIMARY KEY (InstructorID),
  FOREIGN KEY (PersonID) REFERENCES Persons(PersonID)
);

CREATE TABLE BeltRank
(
  BeltRankID INT NOT NULL IDENTITY(1,1),
  BeltRankName INT NOT NULL,
  FeesTest FLOAT NOT NULL,
  SubscriptionPeriodFees INT NOT NULL,
  PRIMARY KEY (BeltRankID)
);

CREATE TABLE Members
(
  MemberID INT NOT NULL IDENTITY(1,1),
  MembershipStatus INT NOT NULL,
  EmergencyContact VARCHAR NOT NULL,
  PersonID INT NOT NULL,
  PRIMARY KEY (MemberID),
  FOREIGN KEY (PersonID) REFERENCES Persons(PersonID)
);

CREATE TABLE SubscriptionPeriods
(
  SubscriptionPeriodID INT NOT NULL IDENTITY(1,1),
  StartDate DATE NOT NULL,
  EndDate DATE NOT NULL,
  IsPaid INT NOT NULL,
  MemberID INT NOT NULL,
  BeltRankID INT NOT NULL,
  PRIMARY KEY (SubscriptionPeriodID),
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
  FOREIGN KEY (BeltRankID) REFERENCES BeltRank(BeltRankID)
);

CREATE TABLE Instructation
(
  InstructationID INT NOT NULL IDENTITY(1,1),
  InstructorID INT NOT NULL,
  MemberID INT NOT NULL,
  PRIMARY KEY (InstructationID),
  FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID),
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

CREATE TABLE Payments
(
  PaymentID INT NOT NULL IDENTITY(1,1),
  Fees FLOAT NOT NULL,
  PayDate DATE NOT NULL,
  PaymentStatus INT NOT NULL,
  SubscriptionPeriodID INT NOT NULL,
  PRIMARY KEY (PaymentID),
  FOREIGN KEY (SubscriptionPeriodID) REFERENCES SubscriptionPeriods(SubscriptionPeriodID)
);

CREATE TABLE Tests
(
  TestID INT NOT NULL IDENTITY(1,1),
  TestDate DATE NOT NULL,
  Result INT NOT NULL,
  MemberID INT NOT NULL,
  InstructorID INT NOT NULL,
  BeltRankID INT NOT NULL,
  PRIMARY KEY (TestID),
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
  FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID),
  FOREIGN KEY (BeltRankID) REFERENCES BeltRank(BeltRankID)
);