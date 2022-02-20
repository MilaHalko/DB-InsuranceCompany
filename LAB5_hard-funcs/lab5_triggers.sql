use master
use InsuranceCompany
go

--------------------------------------------------------------------------------
--(1) INSERT TRIGGER------------------------------------------------------------
create trigger AddSalary 
on InsContract AFTER INSERT
as begin
	declare @InsAmount real
	declare @TarrifRate real
	declare @ID int
	select @InsAmount = (select InsAmount from inserted)
	select @TarrifRate = (select TariffRate from inserted)
	select @ID = (select ID from inserted)
	insert into Salary(Amount, FkInsContractID) values (@InsAmount * @TarrifRate, @ID)
end
go

insert into InsContract(RegistrationDate, InsAmount, TariffRate, FkAgentID) values
('2022-01-01', 10.94, 9.35, 20)
insert into InsType(Item, Risk, FkInsContractID) values
('Speaker', 'Inverse zero administration toolset', 33)
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


--------------------------------------------------------------------------------
--(2) UPDATE TRIGGER------------------------------------------------------------
create trigger updateSalaryByNewAmountOrTariff
on InsContract after update
as begin
	if update(InsAmount) or update(TariffRate)
	begin
		declare @amount real
		declare @tariff real
		declare @id int

		declare curs cursor local for
		select InsAmount, TariffRate, ID from inserted 
		open curs
		fetch next from curs into @amount, @tariff, @id

		while @@FETCH_STATUS = 0
		begin
			update Salary
			set Amount = @amount * @tariff
			where Salary.FkInsContractID = @id
			fetch next from curs into @amount, @tariff, @id
		end
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
