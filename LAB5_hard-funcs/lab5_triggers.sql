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

insert into InsContract (RegistrationDate, InsAmount, TariffRate, FkAgentID, FkInsTypeID) values
('2022-01-01', 10.94, 9.35, 20, 13)
go
insert into InsContract (RegistrationDate, InsAmount, TariffRate, FkAgentID, FkInsTypeID) values
('2022-02-11', 15.67, 27.5, 15, 52)
go
insert into InsContract (RegistrationDate, InsAmount, TariffRate, FkAgentID, FkInsTypeID) values
('2022-01-25', 25.56, 15.87, 7, 36);
go

delete from InsContract where FkInsTypeID = 13 and RegistrationDate = '2022-01-01'
delete from InsContract where FkInsTypeID = 52 and RegistrationDate = '2022-02-11'
delete from InsContract where FkInsTypeID = 36 and RegistrationDate = '2022-01-25'
go
select * from InsContract order by id
go
select * from salary order by FkInsContractID
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
			if exists (select FkInsContractID from Salary s where FkInsContractID = @id)
			begin
				update Salary set Amount = @amount * @tariff, FkAgentID = @agentID
				where Salary.FkInsContractID = @id
			end
			else
			begin
				insert into Salary(Amount, FkInsContractID, FkAgentID) values 
				(@amount * @tariff, @id, @agentID)
			end
			fetch next from cur into @amount, @tariff, @agentID, @id
		end
		close cur
	end
end
go

select c.*, Amount, s.FkAgentID from InsContract c
join Salary s on s.FkInsContractID = c.ID
go
update InsContract set InsAmount = 22, TariffRate = 13, FkAgentID = 13 where id = (select max(id) from InsContract) 
go
select c.*, Amount, s.FkAgentID from InsContract c
join Salary s on s.FkInsContractID = c.ID
go


--------------------------------------------------------------------------------
--(3) DELETE TRIGGER------------------------------------------------------------
create trigger deleteSalaryUpdateContractPrice
on Salary after delete
as begin
	declare @cID int = (select FkInsContractID from deleted)
	update InsContract 
	set InsAmount = 0,
	    TariffRate = 1 
	where ID = @cID
	print 'Deleted item caused updating price in InsContract and Salary (Amount = 0, Tariff = 1) for ContractID = ' + cast(@cID as varchar)
end
go

select c.ID ContractID, InsAmount, TariffRate, s.ID SalaryID, Amount
from InsContract c 
left join Salary s on s.FkInsContractID = c.ID 
where c.id = 100
go
delete Salary where FkInsContractID = 100
go
select c.ID ContractID, InsAmount, TariffRate, s.ID SalaryID, Amount
from InsContract c 
left join Salary s on s.FkInsContractID = c.ID 
where c.id = 100
go

update InsContract set InsAmount = 22, TariffRate = 13 where id = 100 
go
