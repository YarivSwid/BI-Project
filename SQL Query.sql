 drop table Covid19_Canada_Dataset
 drop table details
 drop table reviews
 drop table Stock
 drop table Orders
 drop table products
 drop table Customers
 drop table Warehouses

create table Customers(
	[Customer ID]	int Not Null,
	[Customer Name]	varchar(20) Not Null,
	[Segment]		varchar(20) Not Null,
	[Street]	varchar(20) Not Null,
	[City]	varchar(20) Not Null,
	[Province]		varchar(20) Not Null,
	[Province Code]		varchar(20) Not Null

	constraint PK_Customer			Primary key([Customer ID])

)

create table Warehouses(
	[Warehouse ID]	int Not Null,
	Street	varchar(20) Not Null,
	City		varchar(20) Not Null,
	Province	varchar(20) Not Null,
	[Province Code]	varchar(20) Not Null,
	[Max Number Of Orders Per Month] int Not Null

	constraint PK_Warehouse	Primary key([Warehouse ID])
)

create table Products(
	[Product ID]	int Not Null,
	Category varchar(20) Not Null,
	[Sub-Category]	varchar(20) Not Null,
	[Product-Name]	varchar(20) Not Null,
	[Unit Cost]	Money Not Null

	constraint PK_Products	Primary key([Product ID])
)

create table Stock(
	[Warehouse ID]	int Not Null,
	[Product ID] int Not Null,
	[Date]	Date Not Null,
	[In Stock]	int Not Null

	constraint PK_Stock	Primary key([Warehouse ID],[Product ID],[Date]),
	constraint FK_Stock_Warehouse	Foreign key([Warehouse ID]) references Warehouses([Warehouse ID]),
	constraint FK_Stock_Product	Foreign key([Product ID]) references Products([Product ID])
)

create table Reviews(
	[Customer ID]	int Not Null,
	[Product ID] int Not Null,
	[Review Date]	Date Not Null,
	[Rank]	int Not Null

	constraint PK_Reviews Primary key([Customer ID],[Product ID],[Review Date]),
	constraint FK_Reviews_Customers	Foreign key([Customer ID]) references Customers([Customer ID]),
	constraint FK_Reviews_Products Foreign key([Product ID]) references Products([Product ID])
)

create table Covid19_Canada_Dataset(
	[Object ID]	int Not Null,
	[Province] varchar(20) Not Null,
	[Province Code] varchar(20) Not Null,
	[Summary Date] Date Not Null,
	[Total Cases] int Not Null,
	[Daily Total] int Not Null,
	[Total Recovered] int Not Null,
	[Daily Recovered] int Not Null,
	[Total Deaths] int Not Null,
	[Daily Deaths] int Not Null,
	[Total Tested] int Not Null,
	[Daily Tested] int Not Null

	constraint PK_Covid19_Canada_Dataset Primary key([Object ID])
)
create table Orders(
	[Order ID]	int Not Null,
	[Order Date] Date Not Null,
	[Customer]	int Not Null,
	[Shipping Date]	Date Not Null,
	[Freight]	Real Not Null,
	[Shipping Mode]	varchar(20) Not Null,
	[Warehouse ID]	int Not Null

	constraint PK_Order	Primary key([Order ID]),
	constraint FK_Orders_Customers	Foreign key(Customer) references Customers([Customer ID]),
	constraint FK_Orders_Warehouse	Foreign key([Warehouse ID]) references Warehouses([Warehouse ID])
)

create table Details(
	[Order ID]	int Not Null,
	[Product ID] int Not Null,
	Quantity int Not Null,
	Discount Real Not Null

	constraint PK_Details Primary key([Order ID],[Product ID]),
	constraint FK_Details_Orders Foreign key([Order ID]) references Orders([Order ID]),
	constraint FK_Details_Products Foreign key([Product ID]) references Products([Product ID])
)
