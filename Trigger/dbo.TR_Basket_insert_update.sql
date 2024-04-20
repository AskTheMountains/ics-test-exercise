create or alter trigger dbo.TR_Basket_insert_update
on dbo.Basket
after insert
as
-- Подсчет количества вставленных записей по каждому ID_SKU
;with cte_InsertedCount as (
	select
		i.ID
		,count(ID) over(partition by ID_SKU) as InsertedRowsCount
		from inserted i
)
-- Обновление данных в таблице через join с таблицей вставленных записей
update b
set b.DiscountValue =
	case
		when ic.InsertedRowsCount >= 2
			then b.[Value] * 0.05
		else 0
	end
from dbo.Basket b
	inner join cte_InsertedCount ic on ic.ID = b.ID
