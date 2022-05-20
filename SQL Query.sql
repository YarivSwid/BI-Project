/*
 drop table Super_Store.dbo.Covid19_Canada_Dataset
 drop table Super_Store.dbo.details
 drop table Super_Store.dbo.reviews
 drop table Super_Store.dbo.Stock
 drop table Super_Store.dbo.Orders
 drop table Super_Store.dbo.products
 drop table Super_Store.dbo.Customers
 drop table Super_Store.dbo.Warehouses
*/
--TRUNCATE TABLE Super_Store.dbo.Covid19_Canada_Dataset
--TRUNCATE TABLE Super_Store.dbo.details
--TRUNCATE TABLE Super_Store.dbo.reviews
--TRUNCATE TABLE Super_Store.dbo.Stock
--TRUNCATE TABLE Super_Store.dbo.Orders
--TRUNCATE TABLE Super_Store.dbo.products
--TRUNCATE TABLE Super_Store.dbo.Customers
--TRUNCATE TABLE Super_Store.dbo.Warehouses
create table Super_Store.dbo.Customers(
	[Customer ID]	int Not Null,
	[Customer Name]	varchar(60) ,
	[Segment]		varchar(60) ,
	[Street]	varchar(60) ,
	[City]	varchar(60) ,
	[Province]		varchar(60) ,
	[Province Code]		varchar(60) 
	constraint PK_Customer			Primary key([Customer ID])

)

create table Super_Store.dbo.Warehouses(
	[Warehouse ID]	int Not Null,
	Street	varchar(60) ,
	City		varchar(60) ,
	Province	varchar(60) ,
	[Province Code]	varchar(60) ,
	[Max Number Of Orders Per Month] int 

	constraint PK_Warehouse	Primary key([Warehouse ID])
)

create table Super_Store.dbo.Products(
	[Product ID]	int Not Null,
	Category varchar(60) ,
	[Sub-Category]	varchar(60) ,
	[Product-Name]	varchar(60) ,
	[Unit Cost]	Money 

	constraint PK_Products	Primary key([Product ID])
)

create table Super_Store.dbo.Stock(
	[Warehouse ID]	int Not Null,
	[Product ID] int Not Null,
	[Date]	Date Not Null,
	[In Stock]	int, 
	[Row Number] int identity(1,1)

	constraint PK_Stock	Primary key([Warehouse ID],[Product ID],[Date]),
--	constraint FK_Stock_Warehouse	Foreign key([Warehouse ID]) references Warehouses([Warehouse ID]),
--	constraint FK_Stock_Product	Foreign key([Product ID]) references Products([Product ID])
)
create table Super_Store.dbo.Reviews(
	[Customer ID]	int Not Null ,
	[Product ID] int Not Null,
	[Review Date]	Date Not Null,
	[Rank]	int ,
	[Row Number] int identity(1,1)

	constraint PK_Reviews Primary key([Customer ID],[Product ID],[Review Date]),
	--constraint FK_Reviews_Customers	Foreign key([Customer ID]) references Customers([Customer ID]),
	--constraint FK_Reviews_Products Foreign key([Product ID]) references Products([Product ID])
)

create table Super_Store.dbo.Covid19_Canada_Dataset(
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

	constraint PK_Covid19_Canada Primary key([Object ID])
)
create table Super_Store.dbo.Orders(
	[Order ID]	int Not Null,
	[Order Date] Date ,
	[Customer]	int ,
	[Shipping Date]	Date ,
	[Freight]	Real ,
	[Shipping Mode]	varchar(60) ,
	[Warehouse ID]	int 

	constraint PK_Order	Primary key([Order ID]),
	--constraint FK_Orders_Customers	Foreign key(Customer) references Customers([Customer ID]),
	--constraint FK_Orders_Warehouse	Foreign key([Warehouse ID]) references Warehouses([Warehouse ID])
)
create table Super_Store.dbo.Details(
	[Order ID]	int Not Null,
	[Product ID] int Not Null,
	Quantity int ,
	Discount Real ,
	[Row Number] int identity(1,1)

	constraint PK_Details Primary key([Order ID],[Product ID]),
	--constraint FK_Details_Orders Foreign key([Order ID]) references Orders([Order ID]),
	--constraint FK_Details_Products Foreign key([Product ID]) references Products([Product ID])
)
