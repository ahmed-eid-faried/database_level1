SELECT   *  FROM CarDetialsTable;
SELECT TOP (1000) *  FROM CarDetialsTable;
SELECT   Count(*)  FROM CarDetialsTable;
SELECT   Count(*)  FROM CarDetialsTable WHERE Make='BMW';

--create new copy from table
SELECT * INTO CarDetialsTable2 FROM CarDetialsTable;
 
SELECT DISTINCT Make FROM CarDetialsTable Order by Make Asc;

CREATE TABLE Makes(
    MakeID INT NOT NULL identity(1,1),
    Make VARCHAR(50) UNIQUE NOT NULL,
    PRIMARY KEY(MakeID),
)

INSERT INTO Makes
SELECT DISTINCT Make FROM CarDetialsTable Order by Make Asc;

SELECT * FROM Makes;

ALTER TABLE CarDetialsTable2 ADD MakeID INT ;
 
UPDATE CarDetialsTable2
set MakeID =(SELECT MakeID FROM Makes WHERE (Makes.Make=CarDetialsTable2.Make));

SELECT TOP (1000) *  FROM CarDetialsTable2;

ALTER TABLE CarDetialsTable2  DROP Make;
