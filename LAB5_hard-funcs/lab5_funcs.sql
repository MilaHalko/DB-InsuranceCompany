use master
use InsuranceCompany
go

--FUNCTIONS---------------------------------------------------------------------
--(A) FUNC RETURNS SCALAR VALUE-------------------------------------------------
create function PhiliaByAgent (@agentID int)
returns varchar(50)
as begin
	declare @phName varchar(50)
	select @phName = Name from Philia
	where ID = (select FkPhiliaID from Agent a
				where a.ID = @agentID)
	return (@phName)
end
go

select dbo.PhiliaByAgent(7) Philia
go

--CHECKING
select * from agent a
join Philia p on p.id = a.FkPhiliaID
where a.ID = 7
go


--------------------------------------------------------------------------------
--(B) FUNC RETURNS TABLE WITH DYNAMIC COLUMN SET -------------------------------
create function ItemInfoTableByItem (@item varchar(50))
returns table
as 
return(select Item, Risk, c.ID as ContractID, 
			  InsAmount * TariffRate as Amount,
			  a.Surname as Agent, a.Phone
from InsType t
left join InsContract c on c.ID = t.FkInsContractID
left join Agent a on a.id = c.FkAgentID
where t.Item = @item)
go

select * from ItemInfoTableByItem('Cooper')
select * from InsType
go


--------------------------------------------------------------------------------
--(C) FUNC RETURNS TABLE SPECIFIED STRUCTURE------------------------------------
alter function getAgentsItemsByAgentID (@id int)
returns @AgentsItems table (Agent varchar(100), ContractID int, Item varchar(50), Amount real)
as begin
insert into @AgentsItems select a.Name + ' ' + a.Surname, c.ID, t.Item, InsAmount * TariffRate 
						 from Agent a
						 join InsContract c on c.FkAgentID = @id
						 join InsType t on t.FkInsContractID = c.id
						 where a.id = @id
return
end
go

select * from getAgentsItemsByAgentID(30)

--CHECKING ALL AGENTS
select a.Name + ' ' + Surname as Agent, c.id as ContractID, t.Item, InsAmount * TariffRate as Amount
from InsContract c
join Agent a on a.id = c.FkAgentID
join InsType t on t.FkInsContractID = c.id 
--order by a.id
--where a.id = 30