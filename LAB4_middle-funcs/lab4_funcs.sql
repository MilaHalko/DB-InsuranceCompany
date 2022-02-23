USE master
USE InsuranceCompany
GO

--------------------------------------------------------------------------------
--(1)(1)(1)(1)(1)(1)(1)(1)(1)(1)(1)(1)(1)(1)(1)(1)(1)(1)(1)(1)(1)(1)(1)(1)(1)---
--a. ����� � ������������� ������� COUNT
SELECT COUNT(*) AS TopSalaryQuantity 
FROM Salary 
WHERE Amount > 200
GO

SELECT COUNT(Address) AS PhiliaAddressesQuantity
FROM Philia
GO


--------------------------------------------------------------------------------
--b. ����� � ������������� ������� SUM
SELECT SUM(Amount) AS [Total salary for small amounts]
FROM Salary 
WHERE Amount < 200
GO 

SELECT SUM(TariffRate) AS [Total tariff rate of first 5 Philias]
FROM Agent a
JOIN Philia p ON p.ID = a.FkPhiliaID
JOIN InsContract c ON c.FkAgentID = a.ID
WHERE p.ID <= 5
GO


--------------------------------------------------------------------------------
--c. ����� � ������������� ������� UPPER, LOWER
SELECT UPPER(LEFT(Surname, 1) + LEFT(Name, 1) + LEFT(Patronymic, 1)) as Initials, Surname + ' ' + Name + ' ' + Patronymic AS [Agent Name]
FROM Agent, InsContract
WHERE TariffRate * InsAmount > 200 AND Agent.ID = FkAgentID
GO

SELECT UPPER(Item) AS Item, LOWER(Risk) AS Risk
FROM InsType
WHERE LEN(Risk) > 30
GO


--------------------------------------------------------------------------------
--d. ����� � ������������� ������� ��� ������ � ������
SELECT Amount, Item, CONVERT(DATE, RegistrationDate) AS Date
FROM InsContract c
JOIN InsType t ON t.ID = c.FkInsTypeID
JOIN Salary s ON s.FkInsContractID = c.ID
WHERE DAY(RegistrationDate) BETWEEN 10 AND 20
ORDER BY DAY(RegistrationDate)
GO


--------------------------------------------------------------------------------
--e. ����� � ������������� ���������� �� ������ �������
SELECT FkPhiliaID AS PhiliaID, COUNT(*) AS AgentsQuantity
FROM Agent
GROUP BY FkPhiliaID
ORDER BY AgentsQuantity DESC, FkPhiliaID
GO


--------------------------------------------------------------------------------
--f. ����� � ������������� ���������� �� �������� ��������
SELECT p.ID AS Philia, a.ID AS Agent, 
	  (select COUNT(*) from InsContract c where c.FkAgentID = a.ID) AS ContractsQuantity
FROM Agent a
JOIN Philia p ON p.ID = a.FkPhiliaID
GROUP BY a.ID, p.ID
ORDER BY p.ID
GO 


--------------------------------------------------------------------------------
--g. ����� � ������������� ����� ������ ���� HAVING
SELECT a.Surname, COUNT(c.ID) AS ContractsQuantity
FROM InsContract c
JOIN Agent a ON a.ID = c.FkAgentID
GROUP BY Surname
HAVING COUNT(C.ID) >= 2
ORDER BY COUNT(C.ID) DESC
GO


--------------------------------------------------------------------------------
--i. ����� � ������������� ���������� �� �������
SELECT Name, Address
FROM Philia
ORDER BY Name DESC
GO


--------------------------------------------------------------------------------------
--(2)(2)(2)(2)(2)(2)(2)(2)(2)(2)(2)(2)(2)(2)(2)(2)(2)(2)(2)(2)(2)(2)(2)(2)(2)(2)(2)---
--a. �������� �������������, ����� ������ ��� � �������� �������
CREATE VIEW ItemFullInfo AS
SELECT t.ID, Item, 
	   CONVERT(DATE, RegistrationDate) AS Date, 
	   a.Name + Surname AS Agent, 
	   p.Name AS Philia, p.Address AS Address
FROM InsContract c
JOIN InsType t ON c.FkInsTypeID = t.ID
JOIN Agent a ON a.ID = c.FkAgentID
JOIN Philia p ON p.ID = a.FkPhiliaID
GO

SELECT * FROM ItemFullInfo ORDER BY ID
GO

--DROP VIEW ItemFullInfo
GO
--------------------------------------------------------------------------------------
--b. �������� �������������, ����� ������ ��� � �������� ������� �� ���������, ����� �������� � �.a
alter VIEW ItemPriceInfo AS
SELECT Item, Date, s.Amount
FROM ItemFullInfo
JOIN Salary s ON s.FkInsContractID in (SELECT c.ID FROM InsContract c
									  WHERE c.FkInsTypeID = (SELECT t.ID FROM InsType t
															 WHERE t.ID = ItemFullInfo.ID))
GO

SELECT * FROM ItemPriceInfo
ORDER BY Item
GO

--DROP VIEW ItemPriceInfo
GO


--------------------------------------------------------------------------------------
--c. ������������ ������ � ������������� ������� ALTER VIEW
ALTER VIEW ItemFullInfo AS
SELECT Item, InsAmount, TariffRate, Amount,
       CONVERT(Date, RegistrationDate) AS Date, Phone, 
	   a.Name + ' ' + Surname AS Agent, Risk
FROM InsContract c
JOIN InsType t ON t.ID = c.FkInsTypeID
JOIN Salary s ON s.FkInsContractID = c.ID
JOIN Agent a ON a.ID = c.FkAgentID
WHERE Amount > 100
GO

SELECT * FROM ItemFullInfo ORDER BY Amount
GO

ALTER VIEW ItemPriceInfo AS
SELECT Item, Amount, TariffRate, InsAmount AS InsuranceAmount
FROM InsType t
JOIN InsContract c ON t.ID = c.FkInsTypeID
JOIN Salary s ON s.FkInsContractID = c.ID
GO

SELECT * FROM ItemPriceInfo ORDER BY Amount
GO


--------------------------------------------------------------------------------------
--d. �������� ���������� ���������� ��� �� ������������� � ������������� ���������� �������� (��������� � MsSQL sp_help, sp_helptexst � sp_depends)S
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