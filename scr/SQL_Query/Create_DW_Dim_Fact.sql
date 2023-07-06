------------------------------------------------------------
----##### K20406C_BoKho: SCRIPT CREATE DIM // FACT TABLES ######----
------------------------------------------------------------

----##### SCHEMA: DW #####----
CREATE SCHEMA DW
-------------------------

----##### DIM TABLE #####----

----## DimCustomer ##----
CREATE TABLE DW.DimCustomer(
	[CustomerKey]		[int]			IDENTITY(1,1)	NOT NULL,
	[CustomerID]		[int]							NOT NULL,
	[FirstName]			[nvarchar](50)					NULL,
	[MiddleName]		[nvarchar](50)					NULL,
	[LastName]			[nvarchar](50)					NULL,
	[Gender]			[varchar](1)					NULL,
	[BirthDate]			[varchar](10)					NULL,
	[YearlyIncome]		[varchar](50)					NULL,
	[DateFirstPurchase] [varchar](10)					NULL,
	[ActiveFrom]		[datetime]						NOT NULL,
	[ActiveTo]			[datetime]						NULL
)
-------------------------


----## DimEmployee ##----
CREATE TABLE DW.DimEmployee(
	[EmployeeKey]		[int]			IDENTITY(1,1)	NOT NULL,
	[EmployeeID]		[int]							NOT NULL,
	[FirstName]			[nvarchar](50)					NOT NULL,
	[MiddleName]		[nvarchar](50)					NULL,
	[LastName]			[nvarchar](50)					NOT NULL,
	[Gender]			[nvarchar](1)					NOT NULL,
	[BirthDate]			[date]							NOT NULL,
	[PersonType]		[nvarchar](2)					NOT NULL,
	[JobTitle]			[nvarchar](50)					NOT NULL,
	[HireDate]			[date]							NOT NULL,
	[CurrentDepartment] [nvarchar](50)					NOT NULL,
	[ActiveFrom]		[datetime]						NOT NULL,
	[ActiveTo]			[datetime]						NULL
)
-------------------------


----## DimProduct ##----
CREATE TABLE DW.DimProduct(
	[ProductKey]				[int]			IDENTITY(1,1)	NOT NULL,
	[ProductID]					[int]							NOT NULL,
	[ProductSubcategoryID]		[int]							NULL,
	[ProductCategoryID]			[int]							NULL,
	[ProductName]				[nvarchar](50)					NOT NULL,
	[ProductSubCategoryName]	[nvarchar](50)					NULL,
	[ProductCategoryName]		[nvarchar](50)					NULL,
	[StandardCost]				[money]							NOT NULL,
	[ListPrice]					[money]							NOT NULL,
	[ActiveFrom]				[datetime]						NOT NULL,
	[ActiveTo]					[datetime]						NULL
 )
 -------------------------


 ----## DimGeography ##----
 CREATE TABLE DW.DimGeography(
	[GeographyKey]				[int]			IDENTITY(1,1)	NOT NULL,
	[PostalCode]				[nvarchar](15)					NOT NULL,
	[City]						[nvarchar](30)					NOT NULL,
	[StateProvinceName]			[nvarchar](50)					NOT NULL,
	[SalesTerritoryCountry]		[nvarchar](50)					NOT NULL,
	[SalesTerritoryRegion]		[nvarchar](50)					NOT NULL,
	[SalesTerritoryGroup]		[nvarchar](50)					NOT NULL,
	[TerritoryID]				[int]							NOT NULL
)
 -------------------------


 ----## DimShipMethod ##----
 CREATE TABLE DW.DimShipMethod(
	[ShipMethodKey]				[int]			IDENTITY(1,1)	NOT NULL,
	[ShipMethodID]				[int]							NOT NULL,
	[ShipMethodName]			[nvarchar](50)					NOT NULL
)
 -------------------------


 ----## DimChannel ##----
 CREATE TABLE DW.DimChannel(
	[ChannelKey]				[int]			IDENTITY(1,1)	NOT NULL,
	[ChannelID]					[int]							NOT NULL,
	[Channel]					[varchar](7)					NOT NULL
)
 -------------------------


 ----## DimStore ##----
 CREATE TABLE DW.DimStore(
	[StoreKey]					[int]			IDENTITY(1,1)	NOT NULL,
	[GeographyKey]				[int]							NOT NULL,
	[StoreID]					[int]							NOT NULL,
	[StoreName]					[nvarchar](50)					NOT NULL,
	[BusinessType]				[varchar](20)					NOT NULL,
	[YearOpened]				[int]							NOT NULL,
	[NumberEmployees]			[int]							NOT NULL
)
 -------------------------


 ----## DimStore ##----
 -- Create_DimDate.sql
 -------------------------


----##### FACT TABLE #####----

----## FactSales ##----
CREATE TABLE DW.FactSales (
	[DateKey]					[int]		NOT NULL,
	[CustomerKey]				[int]		NOT NULL,
	[EmployeeKey]				[int]		NULL,
	[ProductKey]				[int]		NOT NULL,
	[GeographyKey]				[int]		NOT NULL,
	[ShipMethodKey]				[int]		NOT NULL,
	[StoreKey]					[int]		NULL,
	[ChannelKey]				[int]		NOT NULL,
	[SalesOrderID]				[int]		NOT NULL,
	[SalesOrderDetailID]		[int]		NOT NULL,
	[OrderDate]					[datetime]	NOT NULL,
	[DueDate]					[datetime]	NOT NULL,
	[ShipDate]					[datetime]	NULL,
	[OrderStatus]				[tinyint]	NOT NULL,
	[OrderQty]					[smallint]	NOT NULL,
	[UnitPrice]					[money]		NOT NULL,
	[SubTotal]					[money]		NOT NULL,
	[TaxAmt]					[money]		NOT NULL,
	[Freight]					[money]		NOT NULL
)
 -------------------------


----## FactSales_Updated ##----
CREATE TABLE DW.FactSales_Updated (
	[DateKey]					[int]		NOT NULL,
	[CustomerKey]				[int]		NOT NULL,
	[EmployeeKey]				[int]		NULL,
	[ProductKey]				[int]		NOT NULL,
	[GeographyKey]				[int]		NOT NULL,
	[ShipMethodKey]				[int]		NOT NULL,
	[StoreKey]					[int]		NULL,
	[ChannelKey]				[int]		NOT NULL,
	[SalesOrderID]				[int]		NOT NULL,
	[SalesOrderDetailID]		[int]		NOT NULL,
	[OrderDate]					[datetime]	NOT NULL,
	[DueDate]					[datetime]	NOT NULL,
	[ShipDate]					[datetime]	NULL,
	[OrderStatus]				[tinyint]	NOT NULL,
	[OrderQty]					[smallint]	NOT NULL,
	[UnitPrice]					[money]		NOT NULL,
	[SubTotal]					[money]		NOT NULL,
	[TaxAmt]					[money]		NOT NULL,
	[Freight]					[money]		NOT NULL
)
 -------------------------


-----------------------------------
-----------------------------------


----#### LOOK UP ####----

----## DimCustomer ##----
SELECT 
	CustomerKey,
	CustomerID
FROM DW.DimCustomer
WHERE ActiveTo IS NULL
----------------

----## DimEmployee ##----
SELECT 
	EmployeeKey,
	EmployeeID
FROM DW.DimEmployee
WHERE ActiveTo IS NULL
----------------

----## DimProduct ##----
SELECT 
	ProductKey,
	ProductID
FROM DW.DimProduct
WHERE ActiveTo IS NULL
----------------

----## DimShipMethod ##----
SELECT
	ShipMethodKey,
	ShipMethodID
FROM DW.DimShipMethod
----------------

----## DimGeography ##----
SELECT
	GeographyKey,
	TerritoryID,
	City,
	StateProvinceName
FROM DW.DimGeography
----------------

----## DimChannel ##----
SELECT 
    ChannelKey,
	CONVERT(BIT, ChannelID) AS ChannelID 
FROM DW.DimChannel
----------------

----## DimStore ##----
SELECT 
	StoreKey,
	StoreID
FROM DW.DimStore
----------------

----## DimDate ##----
SELECT
	DateKey,
	Date
FROM DW.DimDate
----------------

-----------------------------------
-----------------------------------

----#### Script: FactSales_Updated ####----
UPDATE DW.FactSales
	SET 
		DateKey = b.DateKey,
		CustomerKey = b.CustomerKey,
		EmployeeKey = b.EmployeeKey,
		ProductKey = b.ProductKey,
		GeographyKey = b.GeographyKey,
		ShipMethodKey = b.ShipMethodKey,
		StoreKey = b.StoreKey,
		ChannelKey = b.ChannelKey,
		OrderDate = b.OrderDate,
		DueDate = b.DueDate,
		ShipDate = b.ShipDate,
		OrderStatus = b.OrderStatus,
		OrderQty = b.OrderQty,
		UnitPrice = b.UnitPrice,
		SubTotal = b.SubTotal,
		TaxAmt = b.TaxAmt,
		Freight = b.Freight
FROM DW.FactSales AS a INNER JOIN DW.FactSales_Updated AS b
	ON a.SalesOrderDetailID = b.SalesOrderDetailID
-----------------------------------

