create table person (
id int not null,
person_name varchar(50) not null,
phone varchar(25) not null,
DOB date,
email varchar(60)
)
 select * from person

 --insert data from customers into persons

 INSERT INTO Person (id, person_name, phone, dob)
SELECT id, first_name, 'UNKNOWN', NULL
FROM customers;
select * from person

--update Change the score of customers 6 to 400
UPDATE customers
SET score=400
where id=6
--change the score of customers 10 to 0 and update the country to uk
UPDATE customers
SET score=89,
country='uk'
where id =7 &5;

--view data in table 
SELECT * from customers

--DELETE 
--DELETE all customers with an id greater than 6
DELETE from customers where id>6
/*
Delete all data from table person  so we make use truncate becz it is faster than delete droping only data not table
delete cammand is very sloww  becz with delete lot of things gonna happen background */
TRUNCATE TABLE person
SELECT * from person