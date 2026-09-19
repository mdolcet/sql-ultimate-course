--Entrar a una tabla (dataset.dbo.nombre de la tabla)
SELECT * FROM MyDatabase.dbo.customers
--O directamente el nombre de la tabla, pq en coneccion ya estas en MyDatabase
SELECT * FROM customers
SELECT * FROM orders

--SELECT few columns 
SELECT 
	first_name, 
	country, 
	score
FROM customers

--WHERE (Retrieve customers with a score>0
SELECT *
FROM customers 
WHERE score!=0

--Retrieve customers from germany 
SELECT * 
FROM customers 
WHERE country = 'Germany' 

--Filter rows and columns
SELECT 
first_name, 
country
FROM customers
WHERE country = 'Germany'

--ORDER BY: ASC, DESC (Default ascending)
SELECT * 
FROM customers
ORDER BY score 

SELECT * 
FROM customers
ORDER BY score DESC

--NESTED ORDER (1ro por pais, 2do por score)
SELECT *
FROM customers 
ORDER BY country ASC, score DESC 

--GROUP BY: combines rows with the same value; aggregates a column by another column
--total score by country:
SELECT country, sum(score) as total_score
FROM customers 
GROUP BY country

--Total score and total number of customers from each country 
SELECT country,
sum(score) as total_score,
count(id) as total_customers 
FROM customers
GROUP BY country 

--HAVING/WHERE: filter data after aggregation (meaning after groupby)
--WHERE: filter before the aggregation 
SELECT country, 
sum(score) as total_score 
FROM customers
WHERE score>400
GROUP BY country

--HAVING: filter after the aggregation 
SELECT country, 
sum(score) as total_score 
FROM customers
GROUP BY country
HAVING sum(score) >850


--Find the average score for each country considering only customers with a score not equal to 0.
--and return only those countries with an average greater than 430 
SELECT country, 
avg(score) as mean_score 
FROM customers 
WHERE score != 0 
GROUP BY country 
HAVING avg(score) > 430 

--DISTINCT: remove duplicates (return a list unique countries)
SELECT DISTINCT country
FROM customers

--TOP: restrict the number of rows return (unconditional)
SELECT TOP 3 *
FROM customers 

--TOP: retrieve TOP 4 customers with highest scores 
SELECT TOP 4 * 
FROM customers
ORDER BY score DESC

--retrieve the lowest 2 customers based on the score 
SELECT TOP 2 *
FROM customers 
ORDER BY score ASC

--get the 2 most recent orders 
SELECT TOP 2 *
FROM orders 
ORDER BY order_date DESC

----------BASICS-----------------------------------
---------------------------------------------------

/* CODING ORDER: 

SELECT DSTINCT TOP 2    ===son 3 comandos para filtrar: select columns, distinct duplicates, eleccion de obs Top
col1, 
sum(col2)
FROM Table 
WHERE col=10     == filtro ANTES de la agregacion 
GROUP BY col1     
HAVING sum(col2)>20 == filtro dsp de la agregacion
ORDER BY col1 ASC     */ 



--MULTIPLES QUERIES: separated by ;
SELECT * 
FROM customers; 

SELECT * 
FROM orders;

--ARMAR UN QUERY para practicar
SELECT 123 AS static_value 
SELECT 'Hello world' AS static_string

--AGREGAR una variable a tu dataset
SELECT 
id, 
first_name, 
'New Customer' AS customer_type
FROM customers 


----------DDL: DATA DEFINITION LANGUAGE -----------
---------------------------------------------------

--DEFINE: create a database
--create a new table called persons with columns: id, person_name, etc

CREATE TABLE persons (
id INT NOT NULL,
person_name VARCHAR(50) NOT NULL, 
birth_date DATE, --allows nulls--
phone VARCHAR(15) NOT NULL, 
CONSTRAINT pk_persons PRIMARY KEY(id)
) 

SELECT * FROM persons

--ALTER: add a new column 
--ADD a new column called email to the persons table 
ALTER TABLE persons 
ADD email VARCHAR(50) NOT NULL 

SELECT * FROM persons

--REMOVE the column phone from persons data 
ALTER TABLE persons 
DROP COLUMN phone 

SELECT * FROM persons

--DROP delete the table persons 
DROP TABLE persons 



----------DML: DATA MANIPULATION LANGUAGE -----------
---------------------------------------------------

--INSERT INTO table_name(col1, col2, col3)
--VALUES (value1, value2, value3)
INSERT INTO customers (id, first_name,country, score)
VALUES (7, 'Anna', 'USA', NULL), 
       (8, 'Malena', 'Argentina', NULL, 100)

SELECT * FROM customers

--directamente los valores si completas en todas las cols
INSERT INTO customers 
VALUES (9, 'Juan', 'Uruguay', 530)
SELECT * FROM customers 

--Solo en algunas columnas: (pone NULL en el resto de las cols)
INSERT INTO customers (id, first_name)
VALUES (10, 'Juana')
SELECT * FROM customers

--Insert data using another table 
--copy data from customers table into persons table
INSERT INTO persons (id, person_name, birth_date, phone, email)
SELECT 
id, 
first_name, 
NULL,
'Unknown', 
'Unknown'
FROM customers 

SELECT * FROM persons

--UPDATE 
--change the content from already existed table 
--change the score of customer with ID=6 to score=0 

UPDATE customers 
SET score = 0 
WHERE id = 6 

SELECT * FROM customers


--change the score of customer id=10 to 0 & update the country to UK 
UPDATE customers 
SET score =0 , 
	country='UK'
WHERE id=10

SELECT * FROM customers

--update all curtomers with NULL score by setting score = 0
UPDATE customers 
SET score = 0 
WHERE score IS NULL

SELECT * FROM customers

--DELETE
DELETE FROM customers 
WHERE id > 5

SELECT * FROM customers

--delete all data from table persons 
TRUNCATE TABLE persons
SELECT * FROM persons


----------FILTERING DATA -----------
--------------------------------------------

--COMPARISON OPERATORS, LOGICAL, RANGE, MEMBERSHIP OPERATORS, SEARCH OPERATORS

--COMPARISONS OPERATORS
--Retrieve all customers from germany 
SELECT * FROM customers 
WHERE country = 'Germany'
--not from germany:
SELECT * FROM customers 
WHERE country != 'Germany'
--Retrieve all customers with score > 500
SELECT * FROM customers 
WHERE score > 500
--retrieve all customers with score >= 500
SELECT * FROM customers 
WHERE score >= 500
--retrieve all customers less than 500
SELECT * FROM customers 
WHERE score < 500
--retrieve all customers less than or equal than 500
SELECT * FROM customers 
WHERE score <= 500

--LOGICAL OPERATORS
--AND: all conditions must be true 
--retrieve all customer who are from USA and score>500
SELECT * FROM customers 
WHERE country='USA' AND score > 500
--OR: at least one condition must be true 
--retrieve all customers who are either from the USA or have a score >500
SELECT * FROM customers 
WHERE country='USA' OR score > 500
--NOT: (reverse) excludes the values 
--retrieve all customers with a score NOT less than 500 
SELECT * FROM customers 
WHERE NOT score <500 

--RANGE OPERATOR
--BETWEEN: check if value is within a range
--retrieve all customers whose score fall in the rage btw 100 and 500
SELECT * FROM customers 
WHERE score BETWEEN 100 AND 500 

SELECT * FROM customers 
WHERE score>=100 AND score<=500 


--MEMBERSHIP OPERATOR 
--IN: check if a value exists in a list 
--NOT IN: (reverse) check if a value exists in a list
--retrieve all customers from either germany or usa 
SELECT * FROM customers 
WHERE country = 'Germany' OR country = 'USA'

SELECT * FROM customers 
WHERE country IN ('Germany', 'USA')

--SEARCH OPERATOR
--LIKE: search for a pattern in a text. % means 'could be whatever' 
--find all customers whose first name starts with M 
SELECT * FROM customers 
WHERE first_name LIKE 'M%'
--find all customers whose first name ends with n 
SELECT * FROM customers 
WHERE first_name LIKE '%n'
--find all customers whose first name contains r 
SELECT * FROM customers 
WHERE first_name LIKE '%r%'
--find all customers whose first name has r in the 3rd position 
SELECT * FROM customers 
WHERE first_name LIKE '__r%'



----------SQL JOINS--------------------------
--------------------------------------------

--NO JOIN: returns data from tables without combining 
SELECT * FROM customers
SELECT * FROM orders

--INNER JOIN: return only matching rows from A and B 
--get all customers along with their orders, but only for customers who have placed and order
--nota: le indicas que variables traes de cada tabla con el nombre de la tabla antes del .
SELECT 
	customers.id, 
	customers.first_name, 
	orders.order_id, 
	orders.sales
FROM customers
INNER JOIN orders 
ON customers.id = orders.customer_id 

--una forma mas facil es asignar alias a las tablas q suelen tener nombres largos:
SELECT 
	c.id, 
	c.first_name, 
	o.order_id, 
	o.sales
FROM customers AS c
INNER JOIN orders AS o
ON c.id = o.customer_id 

--LEFT JOIN: return all rows from left and only matching from right
--get all customers along with their order, including those without orders 
SELECT 
	c.id,
	c.first_name, 
	o.sales
FROM customers AS c  --FROM=MASTER DATA , left join deja todo el master dataset 
LEFT JOIN orders as o
ON c.id = o.customer_id 

--RIGHT JOIN: returns all rows from right and only matching from left 
--get all customers along with the orders, including orders without matching customers 
SELECT 
c.id, 
c.first_name, 
o.order_id,
o.sales
FROM customers AS c 
RIGHT JOIN orders as o 
ON c.id = o.customer_id 

--get all customers along with their orders, including orders without matching customers 
SELECT
c.id, 
c.first_name, 
o.order_id,
o.sales
FROM orders AS o 
LEFT JOIN customers as c 
ON c.id = o.customer_id 

--FULL JOIN: returns all rows from both tables 
--get all customers and all orders, even if there's no match 
SELECT
c.id, 
c.first_name, 
o.order_id,
o.sales
FROM orders AS o  -- DA igual el orden pq necesitas todo!
FULL JOIN customers as c 
ON c.id = o.customer_id 

--LEFT ANTI JOIN: returns row from left that has NO MATCH in right
--get all customers who haven't place any order 
SELECT *
FROM customers AS c  --master data
LEFT JOIN orders as o  --using data
ON c.id = o.customer_id 
WHERE o.customer_id is NULL  --filter only to keep unmatched master data 


--RIGHT ANTI JOIN: returns row from right that has NO MATCH in left 
--get all orders without matching customers 
SELECT *
FROM customers AS c  --master data
RIGHT JOIN orders as o  --using data
ON c.id = o.customer_id 
WHERE c.id is NULL 

--get all orders without matching customers using LEFT JOIN 
SELECT *
FROM orders as o  --master data
LEFT JOIN customers as c 
ON c.id = o.customer_id 
WHERE c.id IS NULL 