create or alter procedure dbo.usp_MakeFamilyPurchase(
	@FamilySurName varchar(255)
)
as
declare
	@ErrorMessage varchar(255)
	,@SumBasketValue decimal(18, 2)

begin
	-- Проверка на наличие переданного SurName в таблице dbo.Family
	if not exists (
		select 1
		from dbo.Family as f
		where f.SurName = @FamilySurName
	)
	-- Если такого SurName нет, выводится ошибка
	begin
		set @ErrorMessage = 'Указанной семьи не существует'
		raiserror(@ErrorMessage, 1, 1)

		return
	end

	-- Расчет суммы из таблицы dbo.Basket по переданному SurName
	select @SumBasketValue = sum(b.[Value])
	from dbo.Family as f
		inner join dbo.Basket as b on b.ID_Family = f.ID
	where f.SurName = @FamilySurName

	-- Обновление данных в таблице dbo.Family
	update f
	set f.BudgetValue = f.BudgetValue - @SumBasketValue
	from dbo.Family f
	where f.SurName = @FamilySurName
end
