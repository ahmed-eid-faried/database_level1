CREATE TABLE Books
(
  BookID INT NOT NULL IDENTITY(1,1),
  Title NVARCHAR(255) NOT NULL,
  Authors NVARCHAR(255) NOT NULL,
  ISBN NVARCHAR(255) NOT NULL,
  PublicationDate DATE NOT NULL,
  genre NVARCHAR(255) NOT NULL,
  AdditionalDetails NVARCHAR(255) NOT NULL,
  PRIMARY KEY (BookID)
);

CREATE TABLE CopiesOfABook
(
  CopyID INT NOT NULL IDENTITY(1,1),
  AvailabilityStatus INT NOT NULL,
  BookID INT NOT NULL,
  PRIMARY KEY (CopyID),
  FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

CREATE TABLE Users
(
  UserID INT NOT NULL IDENTITY(1,1),
  Name INT NOT NULL,
  Phone NVARCHAR(255) NOT NULL,
  Address NVARCHAR(255) NOT NULL,
  Email NVARCHAR(255) NOT NULL,
  LibraryCardNumber NVARCHAR(255) NOT NULL,
  PRIMARY KEY (UserID)
);

CREATE TABLE BorrowingRecords
(
  BorrowingRecordID INT NOT NULL IDENTITY(1,1),
  BorrowingDate DATE NOT NULL,
  DueDate DATE NOT NULL,
  ActualReturnDate DATE,
  UserID INT NOT NULL,
  CopyID INT NOT NULL,
  PRIMARY KEY (BorrowingRecordID),
  FOREIGN KEY (UserID) REFERENCES Users(UserID),
  FOREIGN KEY (CopyID) REFERENCES CopiesOfABook(CopyID)
);

CREATE TABLE Fines
(
  FineID INT NOT NULL IDENTITY(1,1),
  ReasonOfFine INT NOT NULL,
  FineAmount FLOAT NOT NULL,
  NumberOfLateDays INT NOT NULL,
  PaymentStatus INT NOT NULL,
  BorrowingRecordID INT,
  UserID INT NOT NULL,
  PRIMARY KEY (FineID),
  FOREIGN KEY (BorrowingRecordID) REFERENCES BorrowingRecords(BorrowingRecordID),
  FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE Reservations
(
  ReservationID INT NOT NULL IDENTITY(1,1),
  ReservationDate DATE NOT NULL,
  UserID INT NOT NULL,
  CopyID INT NOT NULL,
  PRIMARY KEY (ReservationID),
  FOREIGN KEY (UserID) REFERENCES Users(UserID),
  FOREIGN KEY (CopyID) REFERENCES CopiesOfABook(CopyID)
);

CREATE TABLE Settings
(
  DefualtBorrrowDays INT NOT NULL,
  DefaultFinePerDay INT NOT NULL
);