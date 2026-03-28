--CTAS
use MyDatabase;
use SalesDB;
select 
	DATENAME(month,OrderDate) OrderMonth,
	COUNT(OrderID) TotalOrders
INTO Sales.MonthlyOrders
FROM Sales.Orders
GROUP BY DATENAMe(month,OrderDate)


SELECT * FROM Sales.MonthlyOrders;


IF OBJECT_ID('sales.MonthlyOrders','u') IS NOT NULL
   DROP TABLE Sales.MonthlyOrders
GO
select 
	DATENAME(month,OrderDate) OrderMonth,
	COUNT(OrderID) TotalOrders
INTO Sales.MonthlyOrders
FROM Sales.Orders
GROUP BY DATENAMe(month,OrderDate)
