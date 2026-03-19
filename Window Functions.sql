use SalesDB
select
SUM(Sales) TotalSales
From Sales.Orders

--Find the total sales of each product
Select 
ProductID,
SUM(Sales) ToatalSales
From Sales.Orders
Group By ProductID

--Find the total sales of each product Additionally provide details such as orderid,orderDate.
Select 
    OrderID,
    OrderDate,
    ProductID,
    SUM(Sales) ToatalSales
From Sales.Orders
Group By 
     OrderID,
     OrderDate,
     ProductID

     -- WIndow function for above query ** Results Granulaity It Retruns a result for each row
SELECT 
OrderID,
OrderDate,
ProductID,
SUM(Sales) over(Partition  By ProductID) TotalSalesByProducts
From Sales.Orders


