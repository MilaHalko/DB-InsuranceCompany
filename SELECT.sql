USE [master]
USE InsuranceCompany
GO

--SIMPLE
SELECT FkPhiliaID AS [Philia ID], Surname, Name, Patronymic
FROM Agent
WHERE FkPhiliaID = 5
GO

SELECT ID, Name, Address
FROM Philia
WHERE ID = 4
GO

--COMPARISON
SELECT FkInsContractID AS [Contract ID], Amount
FROM Salary
WHERE Amount >= 350
ORDER BY Amount DESC
GO

--COMPARISON + AND|OR|NOT
SELECT FkInsContractID AS [Contract ID], Item 
FROM InsType
WHERE FkInsContractID > 11 AND FkInsContractID <= 20
ORDER BY Item DESC
GO

--COMBINATION OF LOGICAL OPERATORS
SELECT ID, FkPhiliaID AS [Philia ID], Name, Surname
FROM Agent
WHERE ID >= 25 AND NOT (ID BETWEEN 28 AND 32) 
ORDER BY FkPhiliaID
GO

SELECT * FROM InsContract
SELECT InsAmount AS Amount, TariffRate AS [Tariff rate], FkAgentID AS [Agent ID] 
FROM InsContract
WHERE InsAmount >= 25 AND NOT (InsAmount BETWEEN 27 AND 35) AND NOT TariffRate BETWEEN 7 AND 10
ORDER BY InsAmount DESC
GO

--OUTPUT
SELECT ID, TRIM(Name) + ' * ' + TRIM(Surname) + ' * ' + TRIM(Patronymic) as Name
FROM Agent 
WHERE (ID * 2 > 10)
ORDER BY ID
GO

SELECT ID AS [Contract ID], InsAmount AS Amount, InsAmount * 2 AS [Doubled amount]
FROM InsContract
WHERE TariffRate BETWEEN 8 AND 11
ORDER BY ID
GO

--SET
SELECT *
FROM Agent
WHERE Name IN ('Haley', 'Marlo', 'Silvia', 'Roderigo', 'Jozef')
GO

SELECT Item, Risk
FROM InsType
WHERE Item IN ('Cooper', 'Corolla', 'LeSabre', 'Regal', 'Freelander')
ORDER BY Item
GO

--RANGE
SELECT Surname, Name, FkPhiliaID AS [Philia ID]
FROM Agent
WHERE FkPhiliaID BETWEEN 5 AND 10
ORDER BY FkPhiliaID DESC
GO

SELECT CONVERT(DATE, RegistrationDate) AS Date, FkAgentID AS [Agent ID], ID AS [Contract ID]
FROM InsContract
WHERE RegistrationDate BETWEEN '2021-10-01' AND '2021-11-30'
ORDER BY RegistrationDate
GO

--TEMPLATE
SELECT * 
FROM Agent
WHERE Name LIKE 'S%'
ORDER BY Name
GO 

--EXPRESSION
SELECT Name, Address, Phone
FROM Philia
WHERE Phone LIKE '5%-___5'
GO

--IS NULL
SELECT ID AS [Contract ID], CONVERT(DATE, RegistrationDate) AS Date, TariffRate AS [Tariff rate], InsAmount AS [Amount]
FROM InsContract
WHERE TariffRate IS NOT NULL AND RegistrationDate > '2021-11-01'
ORDER BY RegistrationDate
GO

--2ND
--field and table's selection
SELECT Name + ' ' + Surname AS Name, 
	  (SELECT ID
	   FROM InsContract
       WHERE FkAgentID = Agent.ID) AS ContractID,
	  (SELECT Name
	   FROM Philia
	   WHERE ID = Agent.FkPhiliaID) AS PhiliaID
FROM Agent
GO

SELECT CONVERT(DATE, RegistrationDate) AS [Date], 
	  (SELECT Item
	   FROM InsType
	   WHERE FkInsContractID = ID) AS Item
FROM InsContract
WHERE RegistrationDate > '2021-08-01'
GO

--exist/in
SELECT Name + ' ' + Surname AS Name, InsAmount * TariffRate * 0.9 AS Salary
FROM Agent, InsContract
WHERE EXISTS (SELECT InsAmount * TariffRate * 0.9
			  WHERE InsAmount * TariffRate * 0.9 > 300)
      AND Agent.ID = InsContract.FkAgentID
ORDER BY Salary DESC
GO

SELECT Surname, Amount
FROM Agent, Salary
WHERE Amount IN (SELECT MAX(Amount)
				 FROM Salary)
	  AND ID = (SELECT FkAgentID
				FROM InsContract
				WHERE InsContract.ID = FkInsContractID)
GO

--cartesian product 
SELECT Item, Name + ' ' + Surname AS Agent, CONVERT(DATE, RegistrationDate) AS Date
FROM InsType
CROSS JOIN Agent
CROSS JOIN InsContract
GO

--merge tables >2 by '='
SELECT Philia.Name AS Philia, Item, Agent.Name + ' ' + Agent.Surname AS Agent
FROM Philia, InsType, Agent
WHERE Agent.FkPhiliaID = Philia.ID AND InsType.FkInsContractID = (SELECT InsContract.ID
																  FROM InsContract
																  WHERE Agent.ID = InsContract.ID)
GO

SELECT Amount, Item, FkAgentID AS AgentID
FROM InsType, InsContract, Salary
WHERE InsContract.ID = InsType.FkInsContractID AND InsContract.ID = Salary.FkInsContractID
ORDER BY Amount DESC
GO

--merge table >2 by '=' && condition
SELECT Item, CONVERT(DATE, RegistrationDate) AS Date, Phone AS AgentPhone
FROM InsContract, InsType, Agent 
WHERE FkInsContractID = InsContract.ID AND FkAgentID = Agent.ID AND RegistrationDate > '2021-08-15'
GO

SELECT InsContract.ID AS GoldContracts2021, Amount, CONVERT(DATE, RegistrationDate) AS Date
FROM InsContract, Salary
WHERE FkInsContractID = InsContract.ID
	  AND Amount > (SELECT AVG(Amount) FROM Salary)
	  AND YEAR(RegistrationDate) = 2021
GO

--inner join
SELECT Item, CONVERT(DATE, RegistrationDate) AS Date, Phone AS AgentPhone
FROM InsContract
JOIN Agent ON Agent.ID = FkAgentID
JOIN InsType ON InsContract.ID = FkInsContractID
GO

SELECT Agent.ID AS AgentID, Philia.Address AS PhiliaAddress, Item
FROM Agent
JOIN Philia ON Philia.ID = FkPhiliaID
JOIN InsType ON FkInsContractID = (SELECT InsContract.ID FROM InsContract WHERE FkAgentID = Agent.ID)
GO

--left join
SELECT Name + ' ' + Surname AS Agent, Item
FROM Agent
LEFT JOIN InsType ON FkInsContractID = (SELECT InsContract.ID FROM InsContract WHERE FkAgentID = Agent.ID)
ORDER BY Surname
GO

SELECT Surname AS Agent, Amount * 0.7 AS Salary
FROM Agent
LEFT JOIN Salary ON FkInsContractID = (SELECT InsContract.ID FROM InsContract WHERE FkAgentID = Agent.ID) 
ORDER BY Amount
GO

--right join
SELECT CONVERT(DATE, RegistrationDate) AS Date, Surname
FROM InsContract
RIGHT JOIN Agent ON FkAgentID = Agent.ID
ORDER BY Date
GO

--table union
SELECT Name AS AllNames FROM Agent
UNION
SELECT Name FROM Philia
UNION
SELECT Item FROM InsType
GO
