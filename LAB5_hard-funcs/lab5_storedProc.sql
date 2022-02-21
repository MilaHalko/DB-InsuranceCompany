use InsuranceCompany
go

--PROCEDURES--------------------------------------------------------------------
--(A) TEMPORARY TABLE-----------------------------------------------------------
 create type agentInfo as table(
 Name varchar(50),
 Surname varchar(50),
 Address varchar(50),
 Phone varchar(15),
 PhID int)
 go

 create proc AddAgents @agents agentInfo readonly
 as
 insert into Agent(Name, Surname, Address, Phone, FkPhiliaID)
 select			   Name, Surname, Address, Phone, PhID
 from @agents
 go

 declare @tempAgents as agentInfo
 insert into @tempAgents(Name, Surname, Address, Phone, PhID) values
 ('Denis', 'Challek', '2765 st.Victory', '098-765-4321', 6),
 ('Alina', 'Shyvckevich', '6743 Kiev, st.Budivelinyk', '044-873-2834', 12),
 ('Anastasia', 'Tarrantino', '563421 American avenue', '777-435-2643', 3),
 ('Dmytriy', 'Byliko', '3245 Cherkasy st.Richna', '096-564-9831', 7)

 select * from Agent
 exec AddAgents @tempAgents
 select * from Agent
 go

 delete Agent
 where Surname in ('Challek', 'Shyvckevich', 'Tarrantino', 'Byliko')
 go


--------------------------------------------------------------------------------
--(B) IF------------------------------------------------------------------------
alter proc isForeigner (@Name varchar(50), @Surname varchar(50))
as begin
	if @Name = (select Name from Agent where Surname = @Surname)
		begin
		declare @Patronymic varchar(50)
		set @Patronymic = (select Patronymic from Agent
						   where Name = @Name and Surname = @Surname)
		if @Patronymic is not null
			print @Name + ' ' + @Surname + ' ' + @Patronymic + ' is not foreigner.'
		else
			print @Name + ' ' + @Surname + ' is foreigner.'
		end
	else 
		print 'There is no person named ' + @Name + ' ' + @Surname
end
go

exec isForeigner @Name = 'Mila', @Surname = 'Halko'
exec isForeigner @Name = 'a', @Surname = 'b'
exec isForeigner @name = 'Denis', @Surname = 'Challek'
go


--------------------------------------------------------------------------------
--(C) WHILE---------------------------------------------------------------------
create proc topContracts @quantity int
as begin
	declare @topC table(ID int, FinalAmount real)
	declare @id int
	declare @currQ int = 0
	if @quantity > (select count(*) from InsContract)
		set @quantity = (select count(*) from InsContract)

	while @currQ < @quantity
	begin
		set @currQ = @currQ + 1
		set @id = (select ID from (
						select *, ROW_NUMBER() over(order by InsAmount * TariffRate desc) as row
						from InsContract
				  ) as temp
				  where row = @currQ)
		insert into @topC (ID, FinalAmount) values 
		(@id, 
		(select InsAmount * TariffRate from InsContract c 
		 where @id = c.ID)) 
	end
	select * from @topC
end
go

exec topContracts 10
exec topContracts 3
go


--------------------------------------------------------------------------------
--(D) PROCEDURE WITHOUT PARAMETRES 
create proc show3ItemsAfterBest
as begin
	select Item, InsAmount * TariffRate as Price
	from InsType t
	join InsContract c on c.FkInsTypeID = t.ID
	order by Price desc
	offset 1 rows
	fetch next 3 rows only
end
go

exec show3ItemsAfterBest
go

select Item, InsAmount * TariffRate as price from InsContract c join InsType t on t.ID = c.FkInsTypeID order by price desc
go


--------------------------------------------------------------------------------
--(E) PROCEDURE WITH PARAMETRE
create proc getPhilliaByName
@NameAndSurname varchar(100)
as begin
	declare @name varchar(50) = left(@NameAndSurname, charindex(' ', @NameAndSurname) - 1)
	declare @sur varchar(50) = right(@NameAndSurname, charindex(' ', @NameAndSurname))
	if @name = (select Name from Agent
				where Surname = @sur)
		select Philia.ID as PhiliaID, Philia.Name as Philia, @NameAndSurname as Agent
		from Philia
		right join Agent on Agent.FkPhiliaID = Philia.ID
		where @name = Agent.Name and @sur = Surname
	else
		print 'There is no agent named ' + @name + @sur
end
go

exec getPhilliaByName @NameAndSurname = 'Mila Halko'
go

select * from Agent where Name = 'Mila'
go


--------------------------------------------------------------------------------
--(F) PROCEDURE WITH PARAMETRE RETURN
create proc numOfContractsForYearAndMonth @year int, @month int
as begin
declare @numC int
set @numC = (select count(*) from InsContract 
			 where cast(YEAR(RegistrationDate) as int) = @year 
			 and  cast(MONTH(RegistrationDate) as int) = @month)
return @numC
end
go

declare @result int
exec @result = numOfContractsForYearAndMonth @year = '2021', @month = '10'
print 'Number of contracts: ' + cast(@result as varchar) 
go


--------------------------------------------------------------------------------
--(G) PROCEDURE FOR TABLE UPDATE
create proc UpdateTariffByContractID @contractID int, @newTariff real
as begin
	update InsContract set TariffRate = @newTariff where ID = @contractID
end
go

declare @id int = 5
exec UpdateTariffByContractID @contractID = @id, @newTariff = 14.12

select ID, TariffRate
from InsContract
where ID = @id
go


--------------------------------------------------------------------------------
--(H) PROCEDURE FOR DATA SAMPLING
alter proc selectAgentsByPhilliaID @phID int
as begin
	select a.ID,
		   a.Surname as Agent, 
		   a.Phone as AgentPhone,
		   round(sum(InsAmount * TariffRate), 2)as Salary
	from Agent a
	left join InsContract c on c.FkAgentID = a.ID
	where a.FkPhiliaID = @phID
	group by a.ID, Surname, Phone
end
go

exec selectAgentsByPhilliaID @phID = 7
go

select p.ID, count(*) as AgentsQuantity from Philia p join Agent a on a.FkPhiliaID = p.ID group by p.ID order by AgentsQuantity desc
go