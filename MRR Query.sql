/*
 drop table SuperStore_MRR.dbo.MRR_Covid19_Canada_Dataset
 drop table SuperStore_MRR.dbo.MRR_details
 drop table SuperStore_MRR.dbo.MRR_reviews
 drop table SuperStore_MRR.dbo.MRR_Stock
 drop table SuperStore_MRR.dbo.MRR_Orders
 drop table SuperStore_MRR.dbo.MRR_products
 drop table SuperStore_MRR.dbo.MRR_Customers
 drop table SuperStore_MRR.dbo.MRR_Warehouses
 */

--TRUNCATE TABLE SuperStore_MRR.dbo.MRR_Covid19_Canada_Dataset
--TRUNCATE TABLE SuperStore_MRR.dbo.MRR_details
--TRUNCATE TABLE SuperStore_MRR.dbo.MRR_reviews
--TRUNCATE TABLE SuperStore_MRR.dbo.MRR_Stock
--TRUNCATE TABLE SuperStore_MRR.dbo.MRR_Orders
--TRUNCATE TABLE SuperStore_MRR.dbo.MRR_products
--TRUNCATE TABLE SuperStore_MRR.dbo.MRR_Customers
--TRUNCATE TABLE SuperStore_MRR.dbo.MRR_Warehouses

create table SuperStore_MRR.dbo.MRR_Customers(
	[Customer ID]	bigint Not Null,
	[Customer Name]	varchar(60) ,
	[Segment] varchar(60) ,
	[Street] varchar(60) ,
	[City] varchar(60) ,
	[Province] varchar(60) ,
	[Province Code]	varchar(60) 
	constraint PK_Customer_MRR Primary key([Customer ID])
)

create table SuperStore_MRR.dbo.MRR_Warehouses(
	[Warehouse ID]	int Not Null,
	Street varchar(60) ,
	City varchar(60) ,
	Province varchar(60) ,
	[Province Code]	varchar(60) ,
	[Max Number Of Orders Per Month] int 

	constraint PK_Warehouse_MRR	Primary key([Warehouse ID])
)

create table SuperStore_MRR.dbo.MRR_Products(
	[Product ID]	bigint Not Null,
	Category varchar(60) ,
	[Sub-Category]	varchar(60) ,
	[Product-Name]	varchar(60) ,
	[Unit Cost]	Money 

	constraint PK_Products_MRR	Primary key([Product ID])
)

create table SuperStore_MRR.dbo.MRR_Stock(
	[Warehouse ID]	int Not Null,
	[Product ID] bigint Not Null,
	[Date]	Date Not Null,
	[In Stock]	int ,
	[Row Number] int


	constraint PK_Stock_MRR	Primary key([Warehouse ID],[Product ID],[Date]),
--	constraint FK_Stock_Warehouse	Foreign key([Warehouse ID]) references Warehouses([Warehouse ID]),
--	constraint FK_Stock_Product	Foreign key([Product ID]) references Products([Product ID])
)

create table SuperStore_MRR.dbo.MRR_Reviews(
	[Customer ID]	bigint Not Null ,
	[Product ID] bigint Not Null,
	[Review Date]	Date Not Null,
	[Rank]	int ,
	[Row Number] int


	constraint PK_Reviews_MRR Primary key([Customer ID],[Product ID],[Review Date]),
	--constraint FK_Reviews_Customers	Foreign key([Customer ID]) references Customers([Customer ID]),
	--constraint FK_Reviews_Products Foreign key([Product ID]) references Products([Product ID])
)
--drop table MRR_Covid19_Canada_Dataset
create table MRR_Covid19_Canada_Dataset(
	[Object ID]	int Not Null,
	[Province] varchar(60) ,
	[Province Code] varchar(60) ,
	[Summary Date] Date ,
	[Total Cases] int ,
	[Daily Total] int ,
	[Total Recovered] int ,
	[Daily Recovered] int ,
	[Total Deaths] int ,
	[Daily Deaths] int ,
	[Total Tested] int ,
	[Daily Tested] int 

	constraint PK_Covid19_MRR Primary key([Object ID])
)
--drop table Superstore_MRR..MRR_Orders
create table SuperStore_MRR.dbo.MRR_Orders(
	[Order ID]	int Not Null,
	[Order Date] Date ,
	[Customer]	bigint ,
	[Shipping Date]	Date ,
	[Freight]	Real ,
	[Shipping Mode]	varchar(60) ,
	[Warehouse ID]	int 

	constraint PK_Order_MRR	Primary key([Order ID]),
	--constraint FK_Orders_Customers	Foreign key(Customer) references Customers([Customer ID]),
	--constraint FK_Orders_Warehouse	Foreign key([Warehouse ID]) references Warehouses([Warehouse ID])
)

create table SuperStore_MRR.dbo.MRR_Details(
	[Order ID]	bigint Not Null,
	[Product ID] bigint Not Null,
	Quantity int ,
	Discount Real ,
	[Row Number] int


	constraint PK_Details_MRR Primary key([Order ID],[Product ID]),
	--constraint FK_Details_Orders Foreign key([Order ID]) references Orders([Order ID]),
	--constraint FK_Details_Products Foreign key([Product ID]) references Products([Product ID])
)
