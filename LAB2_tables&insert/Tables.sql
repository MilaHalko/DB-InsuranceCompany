--DROP DATABASE InsuranceCompany
--CREATE DATABASE InsuranceCompany

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


-------------------------------------------------------------------------------------
CREATE TABLE InsContract (
	ID int IDENTITY(1,1) PRIMARY KEY,
	RegistrationDate datetime DEFAULT (getdate()),
	CONSTRAINT "CK_InsContract_RegistrationDate" CHECK(RegistrationDate<=getdate()),
	InsAmount real DEFAULT(0),
	CONSTRAINT "CK_InsContract_InsAmount" CHECK(InsAmount>=0),
	TariffRate real DEFAULT(0),
	FkAgentID int NOT NULL FOREIGN KEY REFERENCES Agent(ID)
);
GO
--------------
ALTER TABLE InsContract
ADD FkSalaryID int FOREIGN KEY REFERENCES Salary(ID)
--------------
--added data
--------------
ALTER TABLE InsContract
ALTER COLUMN FkSalaryID int NOT NULL
GO

--------------
ALTER TABLE InsContract
ADD FkInsTypeID int FOREIGN KEY REFERENCES InsType(ID)
--------------
--added data
--------------
ALTER TABLE InsContract
ALTER COLUMN FkSalaryID int NOT NULL
GO


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
--------------
--added data
--------------
ALTER TABLE InsContract
ALTER COLUMN FkSalaryID int NOT NULL
GO

