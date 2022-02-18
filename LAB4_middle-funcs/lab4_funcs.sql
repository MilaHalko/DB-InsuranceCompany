USE master
USE InsuranceCompany
GO

--COUNT
SELECT COUNT(*) AS TopSalary 
FROM Salary 
WHERE Amount > 400
GO

SELECT COUNT(Address) AS AllAddressesNum 
FROM Philia
GO

--SUM
SELECT SUM(Amount) AS TopSalary 
FROM Salary 
WHERE Amount < 200
GO 

SELECT SUM(TariffRate) AS [SUM TariffRate FOR first 5 Philias]
FROM InsContract, Agent, Philia
WHERE Philia.ID = Agent.FkPhiliaID AND Agent.ID = InsContract.FkAgentID AND Philia.ID <= 5
GO

--UPPER/LOWER
SELECT UPPER(LEFT(Surname, 1) + LEFT(Name, 1) + LEFT(Patronymic, 1)) as Initials, Surname + ' ' + Name + ' ' + Patronymic AS [Agent Name]
FROM Agent, InsContract
WHERE TariffRate * InsAmount > 300 AND Agent.ID = FkAgentID
GO

SELECT UPPER(Item) AS Item, LOWER(Risk) AS Risk
FROM InsType
WHERE LEN(Risk) > 35
GO

--DATES
SELECT Amount, Item, CONVERT(DATE, RegistrationDate) AS Date
FROM Salary, InsType, InsContract
WHERE InsContract.ID = InsType.FkInsContractID 
	  AND InsContract.ID = Salary.FkInsContractID 
	  AND DAY(RegistrationDate) BETWEEN 10 AND 20
ORDER BY DAY(RegistrationDate)
GO

--GROUP BY 1 COLUMN
SELECT FkPhiliaID AS Philia, COUNT(*) AS AgentsNum
FROM Agent
GROUP BY FkPhiliaID
ORDER BY AgentsNum DESC
GO

--GROUP BY COLUMNS
SELECT P.NAME AS Philia, Surname AS Agent, SUM(Amount) AS TotalSalary, COUNT(Amount) AS ContractsNum
FROM Philia P, Agent A, Salary S, InsContract C
WHERE P.ID = A.FkPhiliaID AND S.FkInsContractID = C.ID AND C.FkAgentID = A.ID
GROUP BY P.Name, A.Surname 
ORDER BY A.Surname
GO 

--HAVING
SELECT A.Surname, COUNT(C.ID) AS ContractsNum
FROM InsContract C, Agent A
WHERE A.ID = C.FkAgentID
GROUP BY Surname
HAVING COUNT(C.ID) >= 2
ORDER BY COUNT(C.ID) DESC
GO

--SORTING
SELECT Name, Address
FROM Philia
ORDER BY Name
GO

--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------

--CREATE VIEW (TABLES)
CREATE VIEW ItemFullInfo AS
SELECT Item, CONVERT(DATE, RegistrationDate) AS Date, Agent.Name + Surname AS Agent, Philia.Name AS Philia, Philia.Address AS Address
FROM InsContract
JOIN InsType ON InsContract.ID = InsType.FkInsContractID
JOIN Agent ON Agent.ID = InsContract.FkAgentID
JOIN Philia ON Philia.ID = Agent.FkPhiliaID
GO

SELECT * FROM ItemFullInfo
GO

DROP VIEW ItemFullInfo
GO

--CREATE NEW VIEW FROM OLD
CREATE VIEW ItemPriceInfo AS
SELECT Item, Date, Salary.Amount AS Amount
FROM ItemFullInfo
JOIN Salary ON Salary.FkInsContractID = (SELECT InsContract.ID
										 FROM InsContract
										 WHERE InsContract.ID = (SELECT InsType.FkInsContractID 
																 FROM InsType
																 WHERE InsType.Item = ItemFullInfo.Item))
GO

SELECT * FROM ItemPriceInfo
ORDER BY Item
GO

--ÏÐÎÂÅÐÊÀ
SELECT Item, Amount
FROM InsType, Salary
WHERE InsType.FkInsContractID = Salary.FkInsContractID
ORDER BY Item
GO

--ALTER VIEW
ALTER VIEW ItemFullInfo AS
SELECT Item, InsAmount, TariffRate, Amount,
       CONVERT(Date, RegistrationDate) AS Date, Phone, 
	   Agent.Name + ' ' + Surname AS Agent, Risk
FROM InsContract
JOIN InsType ON InsType.FkInsContractID = InsContract.ID
JOIN Salary ON Salary.FkInsContractID = InsContract.ID
JOIN Agent ON Agent.ID = InsContract.FkAgentID
WHERE Amount > 300
GO

SELECT * FROM ItemFullInfo
GO

ALTER VIEW ItemPriceInfo AS
SELECT Item, Amount, TariffRate, InsAmount AS InsuranceAmount
FROM InsType
JOIN InsContract ON InsType.FkInsContractID = InsContract.ID
JOIN Salary ON Salary.FkInsContractID = InsContract.ID
GO

SELECT * FROM ItemPriceInfo
GO

DROP VIEW ItemPriceInfo
GO

--SP_HELP / SP_HELPTEXT / SP_DEPENDS
sp_help ItemFullInfo
GO
sp_helptext ItemFullInfo
GO
sp_depends ItemFullInfo
GO

sp_help ItemPriceInfo
GO
sp_helptext ItemPriceInfo
GO
sp_depends ItemPriceInfo
GO