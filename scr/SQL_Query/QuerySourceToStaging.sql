------------------------------------------------------------
----##### K20406C_BoKho: PROJECT DW - ADVENTUREWORKS 2019 ######----
------------------------------------------------------------

----##### DIM TABLE #####----

----## DimCustomer ##----
SELECT
	SC.CustomerID,
	PP.FirstName,
	PP.MiddleName,
	PP.LastName,
	SIC.Demographics.value(
	'declare namespace SIC="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey";
	(/SIC:IndividualSurvey/SIC:Gender)[1]', 'varchar(1)') AS Gender,
	SIC.Demographics.value(
	'declare namespace SIC="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey";
	(/SIC:IndividualSurvey/SIC:BirthDate)[1]', 'varchar(10)') AS BirthDate,
	SIC.Demographics.value(
	'declare namespace SIC="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey";
	(/SIC:IndividualSurvey/SIC:YearlyIncome)[1]', 'varchar(50)') AS YearlyIncome,
	SIC.Demographics.value(
	'declare namespace SIC="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey";
	(/SIC:IndividualSurvey/SIC:DateFirstPurchase)[1]', 'varchar(10)') AS DateFirstPurchase
FROM Sales.Customer AS SC
LEFT JOIN Person.Person As PP
	ON PP.BusinessEntityID = SC.PersonID
LEFT JOIN Sales.vIndividualCustomer AS SIC
	ON SIC.BusinessEntityID = SC.PersonID
WHERE SC.PersonID IS NOT NULL
--> KQ: 19,143 rows (KH mua hàng online)
--> Tổng có 19,844 rows (khách hàng)
--> Có 701 rows (khách hàng mua offline tại store)
-------------------------


----## DimEmployee ##----
SELECT
	HE.BusinessEntityID AS EmployeeID,
	PP.FirstName,
	PP.MiddleName,
	PP.LastName,
	HE.Gender,
	HE.BirthDate,
	PP.PersonType,
	HE.JobTitle,
	HE.HireDate,
	HD.Name AS CurrentDepartment
FROM HumanResources.Employee AS HE
LEFT JOIN Person.Person AS PP
	ON PP.BusinessEntityID = HE.BusinessEntityID
LEFT JOIN HumanResources.EmployeeDepartmentHistory AS HDH
	ON HDH.BusinessEntityID = HE.BusinessEntityID
RIGHT JOIN HumanResources.Department AS HD
	ON HD.DepartmentID = HDH.DepartmentID
WHERE HDH.EndDate IS NULL
--> KQ: 290 rows (Employees)
-------------------------


----## DimProduct ##----
SELECT 
	PP.ProductID,
	PPS.ProductSubcategoryID,
	PPC.ProductCategoryID,
	PP.Name AS 'ProductName',
	PPS.Name AS 'ProductSubCategoryName',
	PPC.Name AS 'ProductCategoryName',
	PP.StandardCost,
	PP.ListPrice
FROM Production.Product AS PP
LEFT JOIN Production.ProductSubcategory AS PPS
	ON PPS.ProductSubcategoryID = PP.ProductSubcategoryID
LEFT JOIN Production.ProductCategory AS PPC
	ON PPC.ProductCategoryID = PPS.ProductCategoryID
--> KQ: 504 rows (Products)
-------------------------


----## DimGeography ##----
SELECT DISTINCT
	PA.AddressID,
    PSP.TerritoryID,
	PA.PostalCode,
	PA.City,
	PSP.Name AS 'StateProvinceName',
	PCR.Name AS 'SalesTerritoryCountry',
	SST.Name AS 'SalesTerritoryRegion',
	SST.[Group] AS 'SalesTerritoryGroup'
FROM Person.Address AS PA
LEFT JOIN Person.StateProvince AS PSP
	ON PSP.StateProvinceID = PA.StateProvinceID
LEFT JOIN Sales.SalesTerritory AS SST
	ON  PSP.TerritoryID = SST.TerritoryID
LEFT JOIN Person.CountryRegion AS PCR
	ON PCR.CountryRegionCode = SST.CountryRegionCode
ORDER BY PA.City
--> KQ: 683 rows (có các cities khác StateProvinceName)
--------------------------


----## DimShipMethod ##----
SELECT 
	ShipMethodID,
	Name AS 'ShipMethodName'
FROM Purchasing.ShipMethod
Order BY ShipMethodID
--> KQ: 5 rows
---------------------------

----## DimStore ##----
SELECT DISTINCT
	SS.BusinessEntityID AS 'StoreID',
	SS.Name AS 'StoreName',
	CASE
		WHEN SS.Demographics.value(
	'declare namespace SS="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey";
	(/SS:StoreSurvey/SS:BusinessType)[1]', 'varchar(10)') = 'BM' THEN 'Value Added Reseller'
		WHEN SS.Demographics.value(
	'declare namespace SS="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey";
	(/SS:StoreSurvey/SS:BusinessType)[1]', 'varchar(10)') = 'BS' THEN 'Specialty Bike Shop'
		WHEN SS.Demographics.value(
	'declare namespace SS="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey";
	(/SS:StoreSurvey/SS:BusinessType)[1]', 'varchar(10)') = 'OS' THEN 'Warehouse'
	END AS 'BusinessType',
	SS.Demographics.value(
	'declare namespace SS="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey";
	(/SS:StoreSurvey/SS:YearOpened)[1]', 'int') AS 'YearOpened',
	SS.Demographics.value(
	'declare namespace SS="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey";
	(/SS:StoreSurvey/SS:NumberEmployees)[1]', 'int') AS 'NumberEmployees',
	PA.City,
	PA.PostalCode,
	PSP.Name AS 'StateProvinceName'
FROM Sales.Store AS SS
LEFT JOIN Person.BusinessEntity AS PBE
	ON PBE.BusinessEntityID = SS.BusinessEntityID
LEFT JOIN Person.BusinessEntityAddress AS PBEA
	ON PBEA.BusinessEntityID = PBE.BusinessEntityID
LEFT JOIN Person.Address AS PA
	ON PBEA.AddressID = PA.AddressID
LEFT JOIN Person.StateProvince AS PSP
	ON PSP.StateProvinceID = PA.StateProvinceID
--> KQ: 701 rows
----------------------

----## DimChannel ##----
SELECT DISTINCT
     OnlineOrderFlag AS 'ChannelID',
	CASE
		WHEN OnlineOrderFlag = 0 THEN 'Offline'
		WHEN OnlineOrderFlag = 1 THEN 'Online'
	END AS 'Channel'
FROM Sales.SalesOrderHeader
--> KQ: 2 rows
---------------------


----## DimDate ##----
-- Create_DimDate.sql
---------------------


---------------------------------------------------------------

----##### FACT TABLE #####----

----## FactSales ##----
SELECT DISTINCT
	SOH.CustomerID,
	SOH.SalesPersonID,
	SOH.ShipMethodID,
	SOD.ProductID,
	SOH.ShipToAddressID,
	SOH.OnlineOrderFlag,
	SC.StoreID,
	PA.PostalCode,
	PA.City,
	PSP.Name AS 'StateProvinceName',
	SOH.SalesOrderID,
	SOD.SalesOrderDetailID,
	SOH.OrderDate,
	SOH.DueDate,
	SOH.ShipDate,
	SOH.Status AS 'OrderStatus',
	SOD.OrderQty,
	SOD.UnitPrice,
	SOH.SubTotal,
	SOH.TaxAmt,
	SOH.Freight
	--BINARY_CHECKSUM(SOD.OrderQty, SOD.UnitPrice, SOH.TaxAmt, SOH.Freight, SOH.SubTotal, SOH.Status) AS BSM
FROM Sales.SalesOrderHeader AS SOH
LEFT JOIN Sales.SalesOrderDetail AS SOD
	ON SOD.SalesOrderID = SOH.SalesOrderID
LEFT JOIN Person.Address AS PA
	ON PA.AddressID = SOH.ShipToAddressID
LEFT JOIN Person.StateProvince AS PSP
	ON PSP.StateProvinceID = PA.StateProvinceID
LEFT JOIN Sales.Customer AS SC
		ON SC.CustomerID = SOH.CustomerID
--> KQ: 121,317 rows ( = rows Sales.SalesOrderDetail)
-----------------------