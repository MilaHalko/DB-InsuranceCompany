USE [master]
USE InsuranceCompany
GO

--------------------------------------------------------------------------------
--(1)(1)(1)(1)(1)(1)(1)(1)(1)(1)(1)(1)(1)(1)(1)(1)(1)(1)(1)(1)(1)(1)(1)(1)(1)---
--a. Найпростіші умов
SELECT FkPhiliaID AS PhiliaID, Surname, Name, Patronymic
FROM Agent
WHERE FkPhiliaID = 6
GO

SELECT ID, Name, Address
FROM Philia
WHERE ID = 4
GO


--------------------------------------------------------------------------------
--b. Операторів порівняння
SELECT FkInsContractID AS [Contract ID], Amount
FROM Salary
WHERE Amount >= 211
ORDER BY Amount DESC
GO


--------------------------------------------------------------------------------
--c. Умов з використанням логічних операторів AND, OR та NOT
SELECT ID, Item 
FROM InsType
WHERE ID > 11 AND ID <= 20
ORDER BY Item DESC
GO


--------------------------------------------------------------------------------
--d. Умов з використанням комбінацій логічних операторів
SELECT ID, FkPhiliaID AS PhiliaID, Name, Surname
FROM Agent
WHERE ID >= 25 AND NOT (ID BETWEEN 28 AND 32)
GO

SELECT * FROM InsContract
SELECT InsAmount AS Amount, TariffRate, FkAgentID AS AgentID 
FROM InsContract
WHERE InsAmount >= 20 AND NOT (InsAmount BETWEEN 23 AND 24) AND NOT TariffRate BETWEEN 7 AND 10
ORDER BY InsAmount
GO
SELECT InsAmount AS Amount, TariffRate, FkAgentID AS AgentID 
FROM InsContract
ORDER BY InsAmount
GO

--------------------------------------------------------------------------------
--e. З використанням виразів над стовпцями, як в якості новостворених стовпців, так і умовах
SELECT ID, TRIM(Name) + '*' + TRIM(Surname) + '*' + TRIM(Patronymic) as Name
FROM Agent 
WHERE (ID * 2 > 10)
ORDER BY ID
GO

SELECT ID AS ContractID, InsAmount AS Amount, InsAmount * 2 AS DoubledAmount
FROM InsContract
WHERE TariffRate BETWEEN 8 AND 11
ORDER BY ID
GO


--------------------------------------------------------------------------------
--i. Використання оператора: приналежності множині
SELECT *
FROM Agent
WHERE Name IN ('Haley', 'Marlo', 'Silvia', 'Roderigo', 'Jozef')
GO

SELECT Item, Risk
FROM InsType
WHERE Item IN ('Cooper', 'Corolla', 'LeSabre', 'Regal', 'Freelander')
ORDER BY Item
GO


--------------------------------------------------------------------------------
--ii. Використання оператора: приналежності діапазону
SELECT Surname, Name, FkPhiliaID AS PhiliaID
FROM Agent
WHERE FkPhiliaID BETWEEN 5 AND 10
ORDER BY FkPhiliaID
GO

SELECT CONVERT(DATE, RegistrationDate) AS Date, FkAgentID AS AgentID, ID AS ContractID
FROM InsContract
WHERE RegistrationDate BETWEEN '2021-10-01' AND '2021-11-30'
ORDER BY RegistrationDate
GO


--------------------------------------------------------------------------------
--iii. Використання оператора: відповідності шаблону
SELECT * 
FROM Agent
WHERE Name LIKE 'S%'
ORDER BY Name
GO 


--------------------------------------------------------------------------------
--iv. Використання оператора: відповідності регулярному виразу
SELECT Name, Address, Phone
FROM Philia
WHERE Phone LIKE '5%5'
GO


--------------------------------------------------------------------------------
--v. Використання оператора: перевірка на невизначене значення
SELECT ID, Surname, Name, Patronymic
FROM Agent
WHERE Patronymic IS NOT NULL AND FkPhiliaID > 10
GO
select * from agent
go

--------------------------------------------------------------------------------
--(2)(2)(2)(2)(2)(2)(2)(2)(2)(2)(2)(2)(2)(2)(2)(2)(2)(2)(2)(2)(2)(2)(2)(2)(2)---
--a. Використання підзапитів в рядку вибірки полів та вибірки з таблиць
SELECT a.ID,
	   Name + ' ' + Surname AS Agent,
	  (SELECT Name
	   FROM Philia p
	   WHERE p.ID = FkPhiliaID) AS Philia
FROM Agent a
GO

SELECT CONVERT(DATE, RegistrationDate) AS Date, 
	  (SELECT Item
	   FROM InsType t
	   WHERE FkInsTypeID = t.ID) AS Item
FROM InsContract
WHERE RegistrationDate > '2021-08-01'
ORDER BY Date
GO


--------------------------------------------------------------------------------
--b. Використання підзапитів в умовах з конструкціями EXISTS, IN
SELECT Name + ' ' + Surname AS Name, InsAmount, InsAmount * TariffRate * 0.9 AS Salary
FROM Agent, InsContract
WHERE EXISTS (SELECT InsAmount * TariffRate * 0.9
			  WHERE InsAmount * TariffRate * 0.9 > 100)
      AND Agent.ID = InsContract.FkAgentID
ORDER BY InsAmount
GO


SELECT Surname, Amount
FROM Agent a, Salary
WHERE Amount IN (SELECT MAX(Amount)
				 FROM Salary)
	  AND a.ID = (SELECT FkAgentID
				FROM InsContract
				WHERE InsContract.ID = FkInsContractID)
GO


--------------------------------------------------------------------------------
--c. Декартовий добуток 
SELECT Item, Name + ' ' + Surname AS Agent, CONVERT(DATE, RegistrationDate) AS Date
FROM InsType
CROSS JOIN Agent
CROSS JOIN InsContract
GO

SELECT Item, Name + ' ' + Surname AS Agent, CONVERT(DATE, RegistrationDate) AS Date
FROM InsType, Agent, InsContract
GO


--------------------------------------------------------------------------------
--d. З’єднання декількох таблиць (більше 2) за рівністю
SELECT p.Name AS Philia, Item, a.Name + ' ' + Surname AS Agent
FROM Philia p, InsType t, Agent a
WHERE a.FkPhiliaID = p.ID AND t.ID = (SELECT c.FkInsTypeID
									  FROM InsContract c
									  WHERE a.ID = c.ID)
GO

SELECT c.FkAgentID AS AgentID, Item, Amount
FROM InsType t, InsContract c, Salary s
WHERE c.FkInsTypeID = t.ID AND c.ID = s.FkInsContractID
ORDER BY c.FkAgentID
GO


--------------------------------------------------------------------------------
--e. З’єднання декількох таблиць (більше 2) за рівністю та умовою відбору
SELECT Item, CONVERT(DATE, RegistrationDate) AS Date, Phone AS AgentPhone
FROM InsContract c, InsType t, Agent a
WHERE c.FkInsTypeID = t.ID 
	  AND a.ID = c.FkAgentID 
	  AND RegistrationDate > '2021-08-15'
ORDER BY RegistrationDate
GO

SELECT c.ID AS Gold2021, Amount, CONVERT(DATE, RegistrationDate) AS Date
FROM InsContract c, Salary s, InsType t
WHERE c.FkInsTypeID = t.ID
	  AND s.FkInsContractID = c.ID
	  AND Amount > (SELECT AVG(Amount) FROM Salary)
	  AND YEAR(RegistrationDate) = 2021
GO


--------------------------------------------------------------------------------
--f. Внутрішнього з’єднання
SELECT Item, CONVERT(DATE, RegistrationDate) AS Date, Phone AS AgentPhone
FROM InsContract c
JOIN Agent a ON a.ID = c.FkAgentID
JOIN InsType t ON t.ID = c.FkInsTypeID
GO

SELECT a.ID AS AgentID, p.Address AS PhiliaAddress, Item
FROM Agent a
JOIN Philia p ON p.ID = a.FkPhiliaID
JOIN InsType t ON t.ID in(SELECT c.ID FROM InsContract c WHERE FkAgentID = a.ID)
ORDER BY a.ID
GO


--------------------------------------------------------------------------------
--g. Лівого зовнішнього з’єднання
SELECT a.Name + ' ' + Surname AS Agent, p.ID
FROM Agent a
LEFT JOIN Philia p ON p.ID = a.FkPhiliaID
ORDER BY a.Name
GO

SELECT Surname AS Agent, Amount * 0.7 AS Salary
FROM Salary s
LEFT JOIN Agent a ON a.ID = s.FkAgentID
ORDER BY Amount
GO


--------------------------------------------------------------------------------
--h. Правого зовнішнього з’єднання
SELECT Surname, CONVERT(DATE, RegistrationDate) AS Date
FROM Agent a
RIGHT JOIN InsContract c ON c.FkAgentID = a.ID
ORDER BY Date
GO

SELECT Name + ' ' + Surname AS Agent, Item
FROM Agent a
RIGHT JOIN InsType t ON t.ID IN(SELECT c.ID FROM InsContract c WHERE FkAgentID = a.ID)
ORDER BY Surname
GO


--------------------------------------------------------------------------------
--i. Об’єднання таблиць
SELECT ID, Name AS AllNames, 'Agent' AS Status FROM Agent
UNION
SELECT ID, Name, 'Philia' FROM Philia
UNION
SELECT ID, Item, 'Item' FROM InsType
ORDER BY Status
GO
