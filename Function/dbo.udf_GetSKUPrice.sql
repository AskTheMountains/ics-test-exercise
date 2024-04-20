create or alter function dbo.udf_GetSKUPrice(
	@ID_SKU int
)
returns numeric(18, 2)
as
begin
	return (
	select sum(b.[Value]) / sum(b.Quantity)
	from dbo.Basket as b
	where b.ID_SKU = @ID_SKU
	)
end

