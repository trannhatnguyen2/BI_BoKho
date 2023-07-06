------------------------------------------------------------
----##### K20406C_BoKho: SCRIPT CREATE TABLES STAGING ######----
------------------------------------------------------------

----##### SCHEMA: Integration #####----
CREATE SCHEMA Integration
-------------------------

----##### STAGING TABLE #####----
----## Customer_Staging ##----
CREATE TABLE Integration.Customer_Staging (
    [CustomerID]				int,
    [FirstName]					nvarchar(50),
    [MiddleName]				nvarchar(50),
    [LastName]					nvarchar(50),
    [Gender]					varchar(1),
    [BirthDate]					varchar(10),
    [YearlyIncome]				varchar(50),
    [DateFirstPurchase]			varchar(10)
)
-------------------------


----## Employee_Staging ##----
CREATE TABLE Integration.Employee_Staging (
    [EmployeeID]				int,
    [FirstName]					nvarchar(50),
    [MiddleName]				nvarchar(50),
    [LastName]					nvarchar(50),
    [Gender]					nvarchar(1),
    [BirthDate]					date,
    [PersonType]				nvarchar(2),
    [JobTitle]					nvarchar(50),
    [HireDate]					date,
    [CurrentDepartment]			nvarchar(50)
)
-------------------------


----## Product_Staging ##----
CREATE TABLE Integration.Product_Staging (
    [ProductID]					int,
    [ProductSubcategoryID]		int,
    [ProductCategoryID]			int,
    [ProductName]				nvarchar(50),
    [ProductSubCategoryName]	nvarchar(50),
    [ProductCategoryName]		nvarchar(50),
    [StandardCost]				money,
    [ListPrice]					money
)
-------------------------


----## ShipMethod_Staging ##----
CREATE TABLE Integration.ShipMethod_Staging (
    [ShipMethodID]				int,
    [ShipMethodName]			nvarchar(50)
)
-------------------------


----## Channel_Staging ##----
CREATE TABLE Integration.Channel_Staging (
    [ChannelID]					int,
    [Channel]					varchar(7)
)
-------------------------


----## Store_Staging ##----
CREATE TABLE Integration.Store_Staging (
    [StoreID]					int,
    [StoreName]					nvarchar(50),
    [BusinessType]				varchar(20),
    [YearOpened]				int,
    [NumberEmployees]			int,
    [City]						nvarchar(30),
    [PostalCode]				nvarchar(15),
    [StateProvinceName]			nvarchar(50)
)
-------------------------

----## Geography_Staging ##----
CREATE TABLE Integration.Geography_Staging (
    [TerritoryID]				int,
    [AddressID]					int,
    [PostalCode]				nvarchar(15),
    [City]						nvarchar(30),
    [StateProvinceName]			nvarchar(50),
    [SalesTerritoryCountry]		nvarchar(50),
    [SalesTerritoryRegion]		nvarchar(50),
    [SalesTerritoryGroup]		nvarchar(50
)
-------------------------


----## SalesOrder_Staging ##----
CREATE TABLE Integration.SalesOrder_Staging (
    [CustomerID]				int,
    [SalesPersonID]				int,
    [ShipMethodID]				int,
    [ProductID]					int,
    [ShipToAddressID]			int,
    [OnlineOrderFlag]			bit,
    [StoreID]					int,
    [PostalCode]				nvarchar(15),
    [City]						nvarchar(30),
    [StateProvinceName]			nvarchar(50),
    [SalesOrderID]				int,
    [SalesOrderDetailID]		int,
    [OrderDate]					datetime,
    [DueDate]					datetime,
    [ShipDate]					datetime,
    [OrderStatus]				tinyint,
    [OrderQty]					smallint,
    [UnitPrice]					money,
    [SubTotal]					money,
    [TaxAmt]					money,
    [Freight]					money
)
-------------------------
