create database DWH_Project

use DWH_Project

create table DimCustomer (CustomerID int primary key, CustomerName varchar(50), FirstName varchar(50), LastName varchar(50),
Age int, Gender varchar(50), City varchar(50), NoHp varchar(50))

create table DimProduct (ProductID int primary key, ProductName varchar(255), ProductCategory varchar(255), ProductUnitPrice int) 

create table DimStatusOrder (StatusID int primary key, StatusOrder varchar(50), StatusOrderDesc varchar(50))

create table FactSalesOrder (OrderID int primary key, CustomerID int, ProductID int, Quantity int, Amount int, StatusID int,
OrderDate date, 
foreign key (CustomerID) references DimCustomer(CustomerID),
foreign key (ProductID) references DimProduct(ProductID),
foreign key (StatusID) references DimStatusOrder(StatusID))

create procedure summary_order_status
   @StatusID int
as 
begin
	select 
	 a.OrderID,
	 b.CustomerName,
	 c.ProductName,
	 a.Quantity,
	 d.StatusOrder
	from FactSalesOrder a
	inner join DimCustomer b on a.CustomerID = b.CustomerID
	inner join DimProduct c on a.ProductID = c.ProductID
	inner join DimStatusOrder d on a.StatusID = d.StatusID
	where a.StatusID = @StatusID;
end;

exec summary_order_status 
@StatusID = 4