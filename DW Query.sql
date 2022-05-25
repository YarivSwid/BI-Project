-- drop table SuperStore_DW.dbo.DIM_Provinces
-- drop table SuperStore_DW.dbo.DIM_Cities
-- drop table SuperStore_DW.dbo.DIM_Warehouses
-- drop table SuperStore_DW.dbo.DIM_Products
-- drop table SuperStore_DW.dbo.DIM_Customers
-- drop table SuperStore_DW.dbo.Fact_Stock
-- drop table SuperStore_DW.dbo.Fact_Customers_Sales
-- drop table SuperStore_DW.dbo.Fact_Reviews
-- drop table SuperStore_DW.dbo.Fact_Orders_Items
-- drop table SuperStore_DW.dbo.Fact_Summary
-- drop table SuperStore_DW.dbo.Fact_Covid19
 --drop table SuperStore_DW.dbo.DIM_DATE
 /*
 truncate table SuperStore_DW.dbo.DIM_Provinces
 truncate table SuperStore_DW.dbo.DIM_Cities
 truncate table SuperStore_DW.dbo.DIM_Warehouses
 truncate table SuperStore_DW.dbo.DIM_Products
 truncate table SuperStore_DW.dbo.DIM_Customers
 truncate table SuperStore_DW.dbo.Fact_Stock
 truncate table SuperStore_DW.dbo.Fact_Customers_Sales
 truncate table SuperStore_DW.dbo.Fact_Reviews
 truncate table SuperStore_DW.dbo.Fact_Orders_Items
 truncate table SuperStore_DW.dbo.Fact_Summary
 truncate table SuperStore_DW.dbo.Fact_Covid19
 truncate table SuperStore_DW.dbo.DIM_DATE
*/
--select *
--from SuperStore_DW.dbo.DIM_DATE
create table SuperStore_DW.dbo.DIM_DATE
(
	[Date] date,
	[Year] int,
	[Quarter] int,
	[Month] int,
	[Day] int,
	TheDayOfWeek int,
	[Is Weekend] int
	)


DECLARE @StartDate  date = '20170101';
DECLARE @CutoffDate date = DATEADD(DAY, -1, DATEADD(YEAR, 6, @StartDate));
;WITH seq(n) AS
(
  SELECT 0 UNION ALL SELECT n + 1 FROM seq
  WHERE n < DATEDIFF(DAY, @StartDate, @CutoffDate)
),
d(d) AS
(
  SELECT DATEADD(DAY, n, @StartDate) FROM seq
),
src AS
(
  SELECT
    [Date] = CONVERT(date,     d),
    [Year]         = DATEPART(YEAR,   d),
    [Quarter]      = DATEPART(Quarter,    d),
	[Month]        = DATEPART(MONTH,    d),
    [Day]          = DATEPART(DAY,     d),
   TheDayOfWeek    = DATEPART(WEEKDAY,   d)
  FROM d
),

dim AS
(
  SELECT
    [Date],
	[Year],
	[Quarter],
	[Month],
	[Day],
	TheDayOfWeek,
	[Is Weekend]           = CASE WHEN TheDayOfWeek IN (CASE @@DATEFIRST WHEN 1 THEN 6 WHEN 7 THEN 1 END,7)
                            THEN 1 ELSE 0 END
   
  FROM src
)
insert into SuperStore_DW.dbo.DIM_DATE
SELECT * FROM dim
  ORDER BY [Date]

OPTION (MAXRECURSION 0);

--drop table DIM_Provinces
create table SuperStore_DW.dbo.DIM_Provinces(
	Province	varchar(60) ,
	[Province Code] varchar(20) 
	
	--constraint PK_DIM_Provinces	Primary key(Province),
)
-- drop table DIM_Cities
create table SuperStore_DW.dbo.DIM_Cities(
	City	varchar(60) ,
	Province varchar(60) 
	--constraint PK_DIM_Cities	Primary key(City),
	--constraint FK_DIM_Cities_Province Foreign key(Province) references DIM_Provinces(Province),
)

create table SuperStore_DW.dbo.DIM_Warehouses( --????????????????????????????????????????????????
	[Warehouse ID]	int ,
	City		varchar(60),
	[Max Number Of Orders Per Month] int	

	--constraint PK_Warehouse	Primary key([Warehouse ID])-- City mafteah?
	--constraint FK_DIM_Warehouses_DIM_Cities Foreign key(City) references DIM_Cities(City),
)

create table SuperStore_DW.dbo.DIM_Products(
	[DW_Product_ID]	int IDENTITY(1,1),
	[Product ID]	bigint ,
	Category varchar(60),
	[Sub-Category]	varchar(60),
	[Product-Name]	varchar(60),
	[Unit Cost]	Money

	--constraint PK_Products	Primary key([DW_Product_ID])
)

--drop table SuperStore_DW.dbo.DIM_Customers
create table SuperStore_DW.dbo.DIM_Customers(
	[DW_Customer_ID]	int IDENTITY(1,1),
	[Customer ID]	bigint ,
	[Customer Name]	varchar(60),
	[Segment]		varchar(60) ,
	[City]	varchar(60) ,
	[Valid From] date ,
	[Valid Until] date
	
	--constraint PK_Customer			Primary key([DW_Customer_ID]),
	--constraint FK_DIM_Customers_DIM_Cities Foreign key([City]) references DIM_Cities(City)
)

--UPDATE DIM_Customers
--SET [Valid From] = '2017-01-01'

--drop table SuperStore_DW.dbo.DIM_Customers_Old
create table SuperStore_DW.dbo.DIM_Customers_Old(
	[DW_Customer_ID]	int , 
	[Customer ID]	bigint ,
	[Customer Name]	varchar(60),
	[Segment]		varchar(60) ,
	[City]	varchar(60) ,
	[Valid From] date ,
	[Valid Until] date
	
	--constraint PK_Customer			Primary key([DW_Customer_ID]),
	--constraint FK_DIM_Customers_DIM_Cities Foreign key([City]) references DIM_Cities(City)
)
	
create table SuperStore_DW.dbo.Fact_Stock(
	[DW_Stock_ID]	int IDENTITY(1,1),
	[Warehouse_ID] int ,
	[DW_Product_ID]	int ,
	[In Stock]	int ,
	[Date] Date 

	--constraint PK_Fact_Stock	Primary key([DW_Stock_ID]),
	--constraint FK_Fact_Stock_Warehouse	Foreign key([Warehouse_ID]) references DIM_Warehouses([Warehouse ID]),
	--constraint FK_Fact_Stock_Product	Foreign key([DW_Product_ID]) references DIM_Products([DW_Product_ID])
	--constraint FK_Fact_Stock_Date	Foreign key([Date]) references DIM_[Date]([Date]) μϊχο!!
)

create table SuperStore_DW.dbo.Fact_Customers_Sales(
	[DW_Customer_ID] int,	
	[Date] Date,
	[Total Quantity] int ,
	[Total Discount Amount]	 money,
	[Total Amount] money

	--constraint PK_Fact_Customers_Sale Primary key([DW_Customer_ID],[Date]),
	--constraint FK_Fact_Customers_Sales_Customers Foreign key([DW_Customer_ID]) references DIM_Customers([DW_Customer_ID]),
	--constraint FK_Fact_Customers_Sales_DIM_Dates Foreign key([Date]) references DIM_Dates([Date]) --??????????
)

create table SuperStore_DW.dbo.Fact_Reviews(
	[DW_Review_ID] int IDENTITY(1,1),
	[DW_Product_ID] int,
	[DW_Customer_ID] int,
	[Rank] int,
	[Review Date] Date  

	--constraint PK_Fact_Reviews Primary key([DW_Customer_ID],[Date]),
	--constraint FK_Fact_Reviews_DIM_Customers Foreign key([DW_Customer_ID]) references DIM_Customers([DW_Customer_ID]),
--	constraint FK_Fact_Reviews_DIM_Products Foreign key([DW_Product_ID]) references DIM_Products([DW_Product_ID]) 
)

create table SuperStore_DW.dbo.Fact_Orders_Items(
    [DW_Order_Item] int  IDENTITY(1,1),
	[Order ID] int,
	[Order Date] date,
	[Shipping Date]	date,
	[Number Of Days] int,
	[Delivery Fee] real,
	[Shipping Mode] varchar(60),
	[DW_Customer_ID] int,
	[DW_Product_ID] int,
	Warehouse_ID int,
	Quantity int,
	[Discount Percentage] real,
	[Discount Amount] money,
	Amount money
	--constraint PK_Fact_Orders_Items Primary key([DW_Customer_ID],[Date]),
	--constraint FK_Fact_Orders_Items_DIM_Customers Foreign key([DW_Customer_ID]) references DIM_Customers([DW_Customer_ID]),
	--constraint FK_Fact_Orders_Items_DIM_Products Foreign key([DW_Product_ID]) references DIM_Products([DW_Product_ID]),
	--constraint FK_Fact_Orders_Items_Warehouses Foreign key(Warehouse_ID) references DIM_Warehouses([Warehouse ID]) 

)

create table SuperStore_DW.dbo.Fact_Summary(
	[Date]	Date ,
	Province varchar(60) ,
	[Number Of Orders] int ,
	[Total Amount] money,
	[Total Cases] int ,
	[Daily Total] int ,
	[Total Tested] int ,
	[Daily Tested] int 
	
	--constraint PK_Fact_Summary Primary key(Province,[Date]),
	--constraint FK_Fact_Summary_DIM_Dates Foreign key([Date]) references DIM_Dates([Date]),
	--constraint FK_Fact_Summary_DIM_Provinces Foreign key(Province) references DIM_Provinces(Province)
)

create table SuperStore_DW.dbo.Fact_Covid19(
	[Object ID]	int ,
	Province varchar(60) ,
	[Summary Date] Date ,
	[Total Cases]	int ,
	[Daily Totals] int ,
	[Total Recovered] int ,
	[Daily Recoverd] int ,
	[Total Deaths] int ,
	[Daily Deaths] int ,
	[Total Tested] int ,
	[Daily Tested] int
	--constraint PK_Fact_Covid19 Primary key([Object ID]),
	--constraint FK_Fact_Covid19_DIM_Provinces Foreign key(Province) references DIM_Provinces(Province),
	--constraint FK_Fact_Covid19_DIM_Provinces Foreign key([Summary Date]) references DIM_Dates([Dates])
)
--drop table SuperStore_DW.dbo.WarehouseSnapshot
create table SuperStore_DW.dbo.WarehouseSnapshot(
	[Warehouse_ID]	int ,
	[City]	varchar(60),
	[Date] date,
	[Orders] int,
	[Total Income] money,
	[Max Number Of Orders Per Month] int,


)
--drop table SuperStore_DW.dbo.Warehouses_Snapshot
create table SuperStore_DW.dbo.Warehouses_Snapshot(
    City varchar(60),
	[Warehouse_ID] int,
	[Date] date,
	[Amount of Orders per Month] int,
	[Total Income per Month] money
)

create procedure [dbo].[updateOldCustomers_Old]
as Begin
update DIM_Customers set [Valid Until] = GetDate() where DW_Customer_ID in (Select DW_Customer_ID from SuperStore_DW.dbo.DIM_Customers_Old)
truncate table SuperStore_DW.dbo.DIM_Customers_Old
END