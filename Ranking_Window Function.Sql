use SalesDB

--RANKing Window Function--

/*Integer based Ranking->Assign an integer for each row ex) Find the top 3 products 
(%) PERCENTAGE based RANKING->Assign a percentage for each row
ex)Find the top 20% Products.

Row_Number()
Syntax
Row_Number() over(Order By Sales Desc)

Rank the orders based on their Sales from highest to lowest*/
SELECT
	OrderID,
	ProductID,
	Sales,
	ROW_NUMBER() over( Order By Sales Desc) SalesRank_Row
From Sales.Orders

/*Rank() Assign a rank to each row.
it handles ties
It leaves gaps in ranking 
Syntax->Rank() over( order By Sales  DESC)*/

--Rank the orders based on their Sales from highest to lowest
SELECT
	OrderID,
	ProductID,
	Sales,
	ROW_NUMBER() over( Order By Sales Desc) SalesRank_Row,
	RANK() over( Order By Sales Desc) Rank_Row
From Sales.Orders

/* dENSE RAnk()
It handles Ties
It Doesn't leaves gaps in ranking 
Syntax->Dense Rank() over(order By Sales DESC)*/

--Rank the orders based on their Sales from highest to lowest
SELECT
	OrderID,
	ProductID,
	Sales,
	ROW_NUMBER() over( Order By Sales Desc) SalesRank_Row,
	RANK()       over(Order By Sales Desc) Rank_Row,
	DENSE_RANK() over( Order By Sales Desc) DenseRank_Row
From Sales.Orders

--use cases--
--Top-N Analysis
--Find the top highest sales for each product
SELECT 
	OrderID,
	ProductID,
	Sales,
	ROW_NUMBER() Over(PARTITION BY ProductID ORDER BY Sales DESC) RankByProduct
FROM Sales.Orders

SELECT *
From(
SELECT 
	OrderID,
	ProductID,
	Sales,
	ROW_NUMBER() Over(PARTITION BY ProductID ORDER BY Sales DESC) RankByProduct
FROM Sales.Orders
)t WHERE RankBYProduct=1

--Bottom-N
 --Find the  lowest 2 customers based on their total sales
SELECT *
FROM(SELECT
		 CustomerID,
		 SUM(Sales) TotalSales,
		 ROW_NUMBER() Over(ORDER BY SUM(sales)) RankCustomers
	 FROM Sales.Orders
	 GROUP BY
	 CustomerID
 )t WHERE RankCustomers<=2

 --Assigning unique identities to the rows of  the 'Orders Archive' table
 
 SELECT 
 ROW_NUMBER() OVER(ORDER BY OrderID,OrderDate) UniqueID,
 *
 FROM Sales.OrdersArchive

 --IDentify duplicates rows in the table 'orderArchive' and return a clean result without any duplicates-
 SELECT 
 ROW_NUMBER() OVER(Partition BY OrderID ORDER BY CreationTime DESC) rm,
 * 
 FROM Sales.OrdersArchive

 SELECT *FROM(
 SELECT 
 ROW_NUMBER() OVER(Partition BY OrderID ORDER BY CreationTime DESC) rm,
 * 
 FROM Sales.OrdersArchive
 )t WHERE rm=1

 /* NTILE()--> Divides the row into a specified number of approximately equal groups(Buckets)*/
 --Larger grops comes first--
 SELECT
 OrderID,
 Sales,
 NTILE(4) OVER(ORDER BY Sales DESC) FourBucket,
 NTILE(3) OVER(ORDER BY Sales DESC) ThreeBucket,
 NTILE(2) OVER(ORDER BY Sales DESC) TwoBucket,
 NTILE(1) OVER(ORDER BY Sales DESC) oneBucket
 FROM Sales.Orders

--Use cases
--Segmentation and equalizing load processing
--Segmentation-> Segement all orders into 3 categories: high, medium, low sales

SELECT 
*,
CASE WHEN Buckets=1 THEN 'High'
	 WHEN Buckets=2 THEN 'Medium'
	 WHEN Buckets=3 THEN 'Low'
END SalesSegmentations
From(
	SELECT 
		OrderID,
		Sales,
		NTILE(3) Over(Order BY Sales Desc) Buckets
	FROM Sales.Orders
	)t

	--Equalising load processor
	--In order to export the data divide the orders into 2 groups 
	SELECT 
	NTILE(2) Over(Order BY OrderID)Buckets, 
	*
	FROM Sales.Orders

	--percentage based ranking function
	/* CUME_DIST=nr/no of rows*/

	--Find the products that fall within the hightest 40% of the prices
	
	SELECT 
	* 
	FROM(
		SELECT 
			ProductID,
			Price,
			CUME_DIST() OVER(ORDER BY Price Desc) DistRank
		FROM Sales.Products
	)t
	WHERE DistRank<=0.4

	/*PERCENTage =NR-1/NO OF ROWS -1 */
	SELECT 
	*,
	CONCAT(DistRank*100, '%') DistRankPerc
	FROM(
		SELECT 
			ProductID,
			Price,
			PERCENT_Rank() OVER(ORDER BY Price Desc) DistRank
		FROM Sales.Products
	)t
	WHERE DistRank<=0.4
