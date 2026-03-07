use SalesDB
--SUM --
Select 
  OrderID,
  OrderDate,
  Sales,
  SUM(Sales) over() TotalSales
From Sales.Orders

--Find the totalSales across all orders
--And the total Sales for each product 
--Additionally provide details such OrderId, order Date

Select 
  OrderID,
  OrderDate,
  Sales,
  ProductID,
  SUM(Sales) over() TotalSales,
  SUM(Sales) over( Partition by productID)
   SalesByProduct
FROM Sales.Orders

--Find the percentage contribution of each products sales to the total sales 
Select
orderID,
ProductID,
Sales,
SUm(Sales) Over() totalsales,
Round(CAST(Sales AS Float)/Sum(sales) over()*100,2) percentageofTotal
FROM Sales.Orders

--AVERAGE--
--Find the average sales across all orders and avg sales for each product additionally,provide details such as orderID,OrderDate

SELECT orderID,
OrderDAte,
ProductID,
AVG(Sales) OVER() avgSales,
AVG(Sales)over (partition BY ProductID)
avgsalesByProducts
FROM Sales.Orders

--FIND the average scores of customers
--Additionally provide details such customerID and lastname

SELECT 
CustomerID,LAStName,
score,
Coalesce(score,0)customerScore,
AVG(Score) OVER() AvgScore,
AVG(Coalesce(score,0) ) over() AvgScoreWithoutNull
FRom Sales.Customers

--Find all orders where sales are higher than the average sales across all orders 

Select
*
From(
Select 
  orderID,
  ProductID,
  Sales,
  AVG(Sales) over() AvgSales
  FROM Sales.Orders
  )t Where Sales>AvgSales
