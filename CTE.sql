--CTE
--Generate a squence of numbers from 1 to 20

with Series As(
SElECT 
1 AS MyNumber 
UNION ALL 
--Recursive query 

SELECT 
MyNumber +1
From Series 
Where MyNumber <20
)
SELECT * 
From Series 

--Task Show the employee hierarchy by Displaying each emplolyee level within the organization 
With CTE_EMP_Hierarchy As(
--Anchor Query 
Select 
	EmployeeID,
	FirstName,
	ManagerID,
1 As Level
From Sales.Employees 
Where Manager.ID is null
UNION ALL
--Recursive Query 
Select 
 e.EmployeeID,
 e.FirstName,
 e.ManagerID,
 Level +1
 From Sales.Employees AS e
 INNER JOIN CTE_EMP_Hierarchy CEH
 ON e.ManagerID=CEH.EmployeeID
 )
 Select *
 From CTE_EMP_Hierarchy
