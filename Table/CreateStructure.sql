if object_id('dbo.SKU') is null
begin
	create table dbo.SKU (
		ID int not null identity,
		Code as 's' + cast(ID as varchar(max)),
		[Name] varchar(255) not null,
		constraint PK_SKU primary key (ID)
	)
end

if object_id('dbo.Family') is null
begin
	create table dbo.Family (
		ID int not null identity,
		SurName varchar(255) not null,
		BudgetValue decimal(18, 2),
		constraint PK_Family primary key (ID)
	)
end

if object_id('dbo.Basket') is null
begin
	create table dbo.Basket (
		ID int not null identity,
		ID_SKU int not null,
		ID_Family int not null,
		Quantity decimal(18, 2),
		Value decimal(18, 2),
		PurchaseDate date,
		DiscountValue decimal(18, 2),
		constraint PK_Basket primary key (ID)
	)
	alter table dbo.Basket add constraint FK_Basket_ID_SKU_SKU foreign key (ID_SKU) references dbo.SKU(ID)
	alter table dbo.Basket add constraint FK_Basket_ID_Family_Family foreign key (ID_Family) references dbo.Family(ID)
	alter table dbo.Basket add constraint DF_Family_PurchaseDate default cast(getdate() as date) for PurchaseDate
	alter table dbo.Basket add constraint CK_Family_Quantity_Value check (Quantity > 0 and [Value] >0)
end
