use master 
use InsuranceCompany

--CURSORS---------------------------------------------------------------------
--(1) CREATE CURSOR-----------------------------------------------------------
alter proc PrintAllAgentsUpperSurname
as
declare @name nvarchar(50)
declare @surname nvarchar(50)
declare @patronymic nvarchar(50)

declare cur cursor 
for select Name, Surname, Patronymic
from Agent

open cur
fetch next from cur into @name, @surname, @patronymic
while @@FETCH_STATUS = 0
begin
	set @name = UPPER(SUBSTRING(@name, 1, 1))
	set @patronymic = UPPER(SUBSTRING(@patronymic, 1, 1))
	print UPPER(@surname) + ' ' + @name + '.' + @patronymic + '.'
	fetch next from cur into @name, @surname, @patronymic
end
close cur
deallocate cur
go

exec PrintAllAgentsUpperSurname