 /*
 drop table SuperStore_STG.dbo.STG_Provinces
 drop table SuperStore_STG.dbo.STG_Cities
 drop table SuperStore_STG.dbo.STG_Warehouses
 drop table SuperStore_STG.dbo.STG_Products
 drop table SuperStore_STG.dbo.STG_Customers
 drop table SuperStore_STG.dbo.STG_Stock
 drop table SuperStore_STG.dbo.STG_Customers_Sales
 drop table SuperStore_STG.dbo.STG_Reviews
 drop table SuperStore_STG.dbo.STG_Orders_Items
 drop table SuperStore_STG.dbo.STG_Summary
 drop table SuperStore_STG.dbo.STG_Covid19
*/
/*
truncate table SuperStore_STG.dbo.STG_Provinces
truncate table SuperStore_STG.dbo.STG_Cities
truncate table SuperStore_STG.dbo.STG_Warehouses
truncate table SuperStore_STG.dbo.STG_Products
truncate table SuperStore_STG.dbo.STG_Customers
truncate table SuperStore_STG.dbo.STG_Stock
truncate table SuperStore_STG.dbo.STG_Customers_Sales
 truncate table SuperStore_STG.dbo.STG_Reviews
 truncate table SuperStore_STG.dbo.STG_Orders_Items
truncate table SuperStore_STG.dbo.STG_Summary
truncate table SuperStore_STG.dbo.STG_Covid19
*/

--drop table Provinces
create table SuperStore_STG.dbo.STG_Provinces(
	Province	varchar(60) ,
	[Province Code] varchar(20) ,


	--constraint PK_Provinces	Primary key(Province),
)
-- drop table Cities
create table SuperStore_STG.dbo.STG_Cities(
	City	varchar(60) ,
	Province varchar(60) 
	--constraint PK_Cities	Primary key(City),
	--constraint FK_Cities_Province Foreign key(Province) references Provinces(Province),
)

create table SuperStore_STG.dbo.STG_Warehouses( --????????????????????????????????????????????????
	[Warehouse ID]	int ,
	City		varchar(60),
	[Max Number Of Orders Per Month] int	

	--constraint PK_Warehouse	Primary key([Warehouse ID])-- City mafteah?
	--constraint FK_Warehouses_Cities Foreign key(City) references Cities(City),
)

create table SuperStore_STG.dbo.STG_Products(
	[Product ID]	bigint ,
	Category varchar(60),
	[Sub-Category]	varchar(60),
	[Product-Name]	varchar(60),
	[Unit Cost]	Money

	--constraint PK_Products	Primary key([DW_Product_ID])
)
--create table Dates()--??????????????????????????
create table SuperStore_STG.dbo.STG_Customers(
	[Customer ID]	bigint ,
	[Customer Name]	varchar(60),
	[Segment]		varchar(60) ,
	[City]	varchar(60) ,
	
	--constraint PK_Customer			Primary key([DW_Customer_ID]),
	--constraint FK_Customers_Cities Foreign key([City]) references Cities(City)
)
	

create table SuperStore_STG.dbo.STG_Stock(
	[Warehouse_ID] int ,
	[DW_Product_ID]	int ,
	[In Stock]	int ,
	[Date] Date ,
	[Row Number] int

	--constraint PK_Stock	Primary key([DW_Stock_ID]),
	--constraint FK_Stock_Warehouse	Foreign key([Warehouse_ID]) references Warehouses([Warehouse ID]),
	--constraint FK_Stock_Product	Foreign key([DW_Product_ID]) references Products([DW_Product_ID])
	--constraint FK_Stock_Date	Foreign key([Date]) references [Date]([Date]) μϊχο!!
)

create table SuperStore_STG.dbo.STG_Customers_Sales(
	[DW_Customer_ID] int,
	[Date] Date,
	[Total Quantity] int ,
	[Total Discount Amount]	 money,
	[Total Amount] money

	--constraint PK_Customers_Sale Primary key([DW_Customer_ID],[Date]),
	--constraint FK_Customers_Sales_Customers Foreign key([DW_Customer_ID]) references Customers([DW_Customer_ID]),
	--constraint FK_Customers_Sales_Dates Foreign key([Date]) references Dates([Date]) --??????????
)

create table SuperStore_STG.dbo.STG_Reviews(
	[DW_Product_ID] int,
	[DW_Customer_ID] int,
	[Rank] int,
	[Review Date] Date  

	--constraint PK_Reviews Primary key([DW_Customer_ID],[Date]),
	--constraint FK_Reviews_Customers Foreign key([DW_Customer_ID]) references Customers([DW_Customer_ID]),
--	constraint FK_Reviews_Products Foreign key([DW_Product_ID]) references Products([DW_Product_ID]) 
)

create table SuperStore_STG.dbo.STG_Orders_Items(
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
	--constraint PK_Orders_Items Primary key([DW_Customer_ID],[Date]),
	--constraint FK_Orders_Items_Customers Foreign key([DW_Customer_ID]) references Customers([DW_Customer_ID]),
	--constraint FK_Orders_Items_Products Foreign key([DW_Product_ID]) references Products([DW_Product_ID]),
	--constraint FK_Orders_Items_Warehouses Foreign key(Warehouse_ID) references Warehouses([Warehouse ID]) 

)

create table SuperStore_STG.dbo.STG_Summary(
	[Date]	Date ,
	Province varchar(60) ,
	[Number Of Orders] int ,
	[Total Amount] money,
	[Total Cases] int ,
	[Daily Total] int ,
	[Total Tested] int ,
	[Daily Tested] int 
	
	--constraint PK_Summary Primary key(Province,[Date]),
	--constraint FK_Summary_Dates Foreign key([Date]) references Dates([Date]),
	--constraint FK_Summary_Provinces Foreign key(Province) references Provinces(Province)
)

create table SuperStore_STG.dbo.STG_Covid19(
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
	--constraint PK_Covid19 Primary key([Object ID]),
	--constraint FK_Covid19_Provinces Foreign key(Province) references Provinces(Province),
	--constraint FK_Covid19_Provinces Foreign key([Summary Date]) references Dates([Dates])
)
