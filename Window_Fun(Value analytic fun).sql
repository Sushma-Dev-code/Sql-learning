use SalesDB
/* LEAD, LAG,FIRST_VALUE, LAST _VALUE*/
--Analyze the month-over-month performance by finding the percentage change in sales between the current & previous onth

SELECT
	 MONTH(OrderDate) OrderMonth,
	 SUM(Sales) CurrentMonthSales,
	 LAG(SUM(Sales)) OVER(ORDER BY MONTH(OrderDate)) previousMonthSales
 From Sales.Orders
 GROUP BY
     MONTH(OrderDate)



SELECT
*,
CurrentMonthSales-PreviousMonthSales AS MOM_Change,
ROUND(CAST((CurrentMonthSales-PreviousMonthSales) AS FLOAT)/PreviousMonthSales *100,1)AS MOM
FROM(
SELECT
	 MONTH(OrderDate) OrderMonth,
	 SUM(Sales) CurrentMonthSales,
	 LAG(SUM(Sales)) OVER(ORDER BY MONTH(OrderDate)) previousMonthSales
From Sales.Orders
GROUP BY
     MONTH(OrderDate)
)t


--IN order to analyse customewr loyality,
--rank customers based on the average days b/w their orders
SELECT
CustomerID,
AVG(DaysUntilNextOrder) AvgDays,
RANK() over (ORDER BY COALESCE(AVG(DaysUntilNextOrder),999999))
Rankavg 
FROM
(
	SELECT
	OrderID,
	CustomerID,
	OrderDate currentOrder,
	LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate) NextOrder,
	DATEDIFF(day, OrderDate,LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate)) DaysUntilNextOrder
	FROM Sales.Orders
)t
GROUP BY
CustomerID

-- FIRST_VALUE -> Find the lowest and highest sales for each product
SELECT
	OrderID,
	ProductID,
	Sales,
	FIRST_VALUE(Sales) Over(PARTITION BY ProductID ORDER BY Sales) ,
	LAST_VALUE(Sales) Over(PARTITION BY ProductID ORDER BY Sales ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) highestSales,
	FIRST_VALUE(Sales) Over(PARTITION BY ProductID ORDER BY Sales DESC) Highestsale2,
	MIN(Sales) Over(PARTITION BY ProductID) Lwestsales2,
	MAX(Sales) Over(PARTITION BY ProductID) HighesSales3

FROM Sales.Orders

--Find the difference in Sales Between the current and lowest sales

SELECT
	OrderID,
	ProductID,
	Sales,
	FIRST_VALUE(Sales) Over(PARTITION BY ProductID ORDER BY Sales) ,
	LAST_VALUE(Sales) Over(PARTITION BY ProductID ORDER BY Sales ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) highestSales,
	FIRST_VALUE(Sales) Over(PARTITION BY ProductID ORDER BY Sales DESC) Highestsale2,
	MIN(Sales) Over(PARTITION BY ProductID) Lwestsales2,
	MAX(Sales) Over(PARTITION BY ProductID) HighesSales3,
	Sales-FIRST_VALUE(Sales) Over( PARTITION BY ProductID ORDER BY Sales)AS SalesDifference
FROM Sales.Orders

