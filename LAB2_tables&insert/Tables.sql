--DROP DATABASE InsuranceCompany
GO
--CREATE DATABASE InsuranceCompany
GO

USE master;
USE InsuranceCompany;
GO

CREATE TABLE Philia (
	ID int IDENTITY(1,1) PRIMARY KEY,
	Name varchar(50) NOT NULL,
	Address varchar(100) NOT NULL UNIQUE,
	Phone varchar(15) NOT NULL UNIQUE
);
GO

/*
ALTER TABLE Philia
DROP COLUMN Phone
GO */

DELETE FROM Philia WHERE LEN(Address) > 50
GO 

ALTER TABLE Philia 
ADD Size float NOT NULL DEFAULT(0)
GO

ALTER TABLE Philia
ADD CONSTRAINT CH_Philia_Size CHECK(Size >= 0)
GO

UPDATE Philia 
SET Size = -1
WHERE ID = 1
GO

UPDATE Philia
SET Size = ID * 1.7
GO

ALTER TABLE Philia 
DROP CONSTRAINT CH_Philia_Size
GO

ALTER TABLE Philia 
DROP CONSTRAINT DF__Philia__Size__37FA4C37
GO

ALTER TABLE Philia
DROP COLUMN Size
GO

select * from Philia

-------------------------------------------------------------------------------------
CREATE TABLE Agent (
	ID int IDENTITY(1,1) PRIMARY KEY,
	Name varchar(50) NOT NULL,
	Surname varchar(50) NOT NULL,
	Patronymic varchar(50) NULL,
	Address varchar(50) NOT NULL,
	Phone varchar(15) NOT NULL,
	FkPhiliaID int NOT NULL FOREIGN KEY REFERENCES Philia(ID)
);
GO

ALTER TABLE Agent
ADD temp int
GO

ALTER TABLE Agent
ADD CONSTRAINT df_temp DEFAULT(2) FOR temp
GO

ALTER TABLE Agent
DROP CONSTRAINT df_temp
GO

ALTER TABLE Agent
DROP COLUMN temp
GO


-------------------------------------------------------------------------------------
CREATE TABLE InsContract (
	ID int IDENTITY(1,1) PRIMARY KEY,
	RegistrationDate date DEFAULT (getdate()),
	CONSTRAINT "CK_InsContract_RegistrationDate" CHECK(RegistrationDate<=getdate()),
	InsAmount real DEFAULT(0),
	CONSTRAINT "CK_InsContract_InsAmount" CHECK(InsAmount>=0),
	TariffRate real DEFAULT(0),
	FkAgentID int NOT NULL FOREIGN KEY REFERENCES Agent(ID)
);
GO

dbcc checkident('InsContract', reseed, 0)
GO
--------------
ALTER TABLE InsContract
ADD FkInsTypeID int FOREIGN KEY REFERENCES InsType(ID)
GO
--------------
--added data
--------------
ALTER TABLE InsContract
ALTER COLUMN FkInsTypeID int NOT NULL
GO

ALTER TABLE InsContract
ADD Active BIT 
GO

UPDATE InsContract
SET Active = 0
GO

UPDATE InsContract
SET Active = 1
WHERE ID % 2 = 1
GO

ALTER TABLE InsContract
ALTER COLUMN Active BIT NOT NULL
GO

ALTER TABLE InsContract
DROP COLUMN Active
GO

DELETE FROM InsContract 
WHERE TariffRate * InsAmount = 0
GO

SELECT * FROM InsContract
-------------------------------------------------------------------------------------
CREATE TABLE InsType (
	Item varchar(50) NOT NULL,
	Risk varchar(50) NOT NULL,
	FkInsContractID int NOT NULL UNIQUE FOREIGN KEY REFERENCES InsContract(ID)
	ON UPDATE CASCADE 
	ON DELETE CASCADE
);
GO
--------------
ALTER TABLE InsType 
ADD ID int IDENTITY(1,1) PRIMARY KEY
GO
--------------
ALTER TABLE InsType
DROP CONSTRAINT UQ__InsType__79EC96B5672C265B
--------------
ALTER TABLE InsType 
DROP CONSTRAINT FK__InsType__FkInsCo__43D61337
--------------
ALTER TABLE InsType 
DROP COLUMN FkInsContractID
GO


-------------------------------------------------------------------------------------
CREATE TABLE Salary (
	Amount real NOT NULL,
	FkInsContractID int NOT NULL FOREIGN KEY REFERENCES InsContract(ID)
);
GO
--------------
ALTER TABLE Salary 
ADD ID int IDENTITY(1,1) PRIMARY KEY
GO
--------------
ALTER TABLE Salary
ADD FkAgentID int FOREIGN KEY REFERENCES Agent(ID)
GO
--------------
alter table Salary add FkInsContractID int FOREIGN KEY REFERENCES InsContract(ID)
ON UPDATE CASCADE 
ON DELETE CASCADE
GO
--------------
ALTER TABLE Salary 
ADD UNIQUE(FkInsContractID)
GO


-------------------------------------------------------------------------------------
/*
TRUNCATE TABLE Philia
GO
TRUNCATE TABLE Agent
GO
TRUNCATE TABLE InsContract
GO
TRUNCATE TABLE InsType
GO
TRUNCATE TABLE Salary
GO

DROP TABLE Philia
GO
DROP TABLE Agent
GO
DROP TABLE InsContract
GO
DROP TABLE InsType
GO
DROP TABLE Salary
GO

DELETE FROM Philia
GO
DELETE FROM Agent
GO
DELETE FROM InsContract
GO
DELETE FROM InsType
GO
DELETE FROM Salary
GO
*/