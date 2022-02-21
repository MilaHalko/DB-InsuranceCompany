use master
use InsuranceCompany
go

--------------------------------------------------------------------------------
--(1) INSERT TRIGGER------------------------------------------------------------
create trigger AddSalary 
on InsContract AFTER INSERT
as begin
	declare @InsAmount real = (select InsAmount from inserted)
	declare @TarrifRate real = (select TariffRate from inserted)
	declare @ID int = (select ID from inserted)
	declare @agent int = (select FkAgentID from inserted)
	insert into Salary(Amount, FkInsContractID, FkAgentID) values 
	(@InsAmount * @TarrifRate, @ID, @agent)
end
go

insert into InsContract(RegistrationDate, InsAmount, TariffRate, FkAgentID) values
('2022-01-01', 10.94, 9.35, 20)
insert into InsType(Item, Risk, FkInsContractID) values
('Speaker', 'Inverse zero administration toolset', IDENT_CURRENT('InsContract'))
go

insert into InsContract(RegistrationDate, InsAmount, TariffRate, FkAgentID) values
('2022-02-11', 15.67, 27.5, 15)
insert into InsType(Item, Risk, FkInsContractID) values
('Mac', 'Radical Graphic Interface', 34)
go

insert into InsContract(RegistrationDate, InsAmount, TariffRate, FkAgentID) values
('2022-01-25', 25.56, 15.87, 7)
insert into InsType(Item, Risk, FkInsContractID) values
('Cafe', 'Empowering customer loyalty', 35)
go

delete from InsContract where id = 37
select * from InsContract order by RegistrationDate
--------------------------------------------------------------------------------
--(2) UPDATE TRIGGER------------------------------------------------------------
alter trigger updateSalaryByNewAmountOrTariff
on InsContract after update
as begin
	if update(InsAmount) or update(TariffRate) or update(FkAgentID)
	begin
		declare @amount real
		declare @tariff real
		declare @agentID int
		declare @id int

		declare cur cursor local for
		select InsAmount, TariffRate, FkAgentID, ID from InsContract 
		open cur
		fetch next from cur into @amount, @tariff, @agentID, @id

		while @@FETCH_STATUS = 0
		begin
			if exists(select * from Salary s where s.FkInsContractID in (select c.ID from InsContract c))
			begin
				update Salary
				set Amount = @amount * @tariff, 
					FkAgentID = @agentID
				where Salary.FkInsContractID = @id
				print 'Updated'
			end
			else 
			begin
				insert into Salary(Amount, FkInsContractID, FkAgentID) values 
				(@amount * @tariff, @id, @agentID)
				print 'Inserted'
			end
			fetch next from cur into @amount, @tariff, @agentID, @id
		end
		close cur
	end
end
go

select c.*, Amount from InsContract c
join Salary s on s.FkInsContractID = c.ID
where id = IDENT_CURRENT('InsContract')
go
update InsContract set InsAmount = 24, TariffRate = 13 where id = IDENT_CURRENT('InsContract')
select c.*, Amount from InsContract c
join Salary s on s.FkInsContractID = c.ID
where id = IDENT_CURRENT('InsContract')
go

exec updateContractOnTheSameValue
select * from Salary
select *, c.InsAmount * c.TariffRate from InsContract c


--------------------------------------------------------------------------------
--(3) DELETE TRIGGER------------------------------------------------------------
create trigger deleteInsTypeUpdateContractPrice
on InsType after delete
as begin
	declare @id int = (select FkInsContractID from deleted)
	update InsContract 
	set InsAmount = 0,
	    TariffRate = 1 
	where ID = @id
	print 'Deleted item caused updating price in InsContract and Salary (Amount = 0, Tariff = 1) for ContractID = ' + cast(@id as varchar)
end
go

select * from InsContract c left join InsType t on t.FkInsContractID = c.ID left join Salary s on s.FkInsContractID = c.ID 
delete from InsType where FkInsContractID = IDENT_CURRENT('InsContract')
select * from InsContract c left join InsType t on t.FkInsContractID = c.ID left join Salary s on s.FkInsContractID = c.ID


create trigger 