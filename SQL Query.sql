/*
--Lookup Tables

create table Countries (
	Country varchar(40),
	
	constraint PK_Countries Primary key(Country)
)

Create table SortedBy(
	Criteria varchar(20)

	constraint PK_Criteria Primary key(Criteria)
)

INSERT INTO SortedBy (Criteria)
VALUES
	('Magic'),
	('Popularity'),
	('Newest'),
	('End Date'),
	('Most Funded'),
	('Most Backed'),
	('Near Me')

create table CCTypes
(
	CCType varchar(20)

	constraint PK_CCTypes Primary key(CCType)
)

INSERT INTO CCTypes (CCType)
VALUES
	('AMEX'),
	('Diners Club'),
	('Discover'),
	('JCB'),
	('Mastercard'),
	('UnionPay'),
	('Visa')
*/
--Tables
-- drop table Customers
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
-- drop table Warehouses
create table Warehouses(
	[Warehouse ID]	int Not Null,
	Street	varchar(20) Not Null,
	City		varchar(20) Not Null,
	Province	varchar(20) Not Null,
	[Province Code]	varchar(20) Not Null,
	[Max Number Of Orders Per Month] int Not Null

	constraint PK_Warehouse	Primary key([Warehouse ID])
)
-- drop table Orders
create table Orders(
	[Order ID]	int Not Null,
	[Order Date] Date Not Null,
	[Customer]	int Not Null,
	[Shipping Date]	Date Not Null,
	[Number Of Days]	int Not Null,
	[Freight]	Real Not Null,
	[Shipping Mode]	varchar(20) Not Null,
	[Warehouse ID]	int Not Null

	constraint PK_Order	Primary key([Order ID]),
	constraint FK_Orders_Customers	Foreign key(Customer) references Customers([Customer ID]),
	constraint FK_Orders_Warehouse	Foreign key([Warehouse ID]) references Warehouses([Warehouse ID])
)
-- drop table products
create table Products(
	[Product ID]	int Not Null,
	Category varchar(20) Not Null,
	[Sub-Category]	varchar(20) Not Null,
	[Product-Date]	varchar(20) Not Null,
	[Unit Cost]	Money Not Null

	constraint PK_Products	Primary key([Product ID])
)
-- drop table Stock
create table Stock(
	[Warehouse ID]	int Not Null,
	[Product ID] int Not Null,
	[Date]	Date Not Null,
	[In Stock]	int Not Null

	constraint PK_Stock	Primary key([Warehouse ID],[Product ID],[Date]),
	constraint FK_Stock_Warehouse	Foreign key([Warehouse ID]) references Warehouses([Warehouse ID]),
	constraint FK_Stock_Product	Foreign key([Product ID]) references Products([Product ID])
)
--drop table reviews
create table Reviews(
	[Customer ID]	int Not Null,
	[Product ID] int Not Null,
	[Review Date]	Date Not Null,
	[Rank]	int Not Null

	constraint PK_Reviews Primary key([Customer ID],[Product ID],[Review Date]),
	constraint FK_Reviews_Customers	Foreign key([Customer ID]) references Customers([Customer ID]),
	constraint FK_Reviews_Products Foreign key([Product ID]) references Products([Product ID])
)
--	constraint FK_Users_Country	Foreign key(Country) references Countries(Country),
--	constraint CK_U_Email		check([E-mail] like '%@%.%'),
--	constraint CK_U_Name		check(Name not like '%[0-9]%'),
create table Websites(
	[User E-mail]	varchar(30) Not Null,
	Website			varchar(30) Not Null,
	
	constraint PK_Websites	Primary key([User E-mail],Website),
	constraint FK_W_Users	Foreign key([User E-mail])
		references Users([E-mail]),
	constraint CK_W_Website	check(Website like '%www.%.%')
)
