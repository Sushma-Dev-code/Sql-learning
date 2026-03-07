use MyDatabase;
select * from orders;
select * from customers;
select  first_name from customers;
-- Retrieve customers using WHERE CLAUSE
select * 
from customers
--Retrieve customers with a score not equal to 0
SELECT * 
FROM customers
WHERE score!= 0

-- Retrieve customers from germany
SELECT * 
FROM customers
where country='germany'
--Retrieve customer first name and country germany
SELECT 
first_name,
country
FROM customers
WHERE country='germany'

--ORDERBY=============== Retrieve all customers and sort the results by the highest score first
--ASCENDING LOW TO HIGH- IS DEFAULT DESCENDING MEANS HIGH TO LOW
SELECT *
FROM customers
order by score Desc

--SORT THE RESULT BY LOWEST SCORE FIRST 
SELECT * FROM CUSTOMERS ORDER BY SCORE

SELECT * FROM CUSTOMERS ORDER BY country

--Nested sorting
--Retrieve all customers and sort result by the country and then by the highest score

SELECT *FROM customers order by country ASC, score ASC;
SELECT * FROM CUSTOMERS order by country ASC, score DESC;

--GROUPBY 

--FIND the total score of each country

SELECT 
country,
sum(score) as totalscore

from customers
GROUP BY country

--find the total score and total number of customers for each country 
SELECT 
country,
SUM(score)
AS totalscore,
count(id) as total_customers
from customers
group by country;

--HAVING IT IS used after groupby
/* find the average score fo*/





