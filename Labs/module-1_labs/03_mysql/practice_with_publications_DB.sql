#JOIN Table PUBLISHERS with Table TITLES > Want to see sales of each publisher
# pub_id we have both: in PUBLISHERS its priamray key. in TITLES its foreign key

SELECT *
FROM publications.publishers
INNER JOIN publications.titles
ON publishers.pub_id = titles.pub_id;

# lets see if we exchange left and right table
SELECT *
FROM publications.titles 
INNER JOIN publications.publishers
ON titles.pub_id = publishers.pub_id;

# LEFT JOIN with publishers as left table: 
# More Rows show up. 5 more publishing houses that have NULL values in titles. hvent published anything
SELECT *
FROM publications.publishers
LEFT JOIN publications.titles
ON publishers.pub_id = titles.pub_id;

# LEFT JOIN with titles as left table:
SELECT *
FROM publications.titles
LEFT JOIN publications.publishers
ON titles.pub_id = publishers.pub_id;

# We want publisher name, title ID , title + rename
SELECT publishers.pub_name as publishing_house, titles.title_id , titles.title as book_title
FROM publications.titles 
INNER JOIN publications.publishers
ON titles.pub_id = publishers.pub_id; 

# We want publisher name, title ID , title
SELECT publishers.pub_name, titles.title_id, titles.title
FROM publications.titles 
INNER JOIN publications.publishers
ON titles.pub_id = publishers.pub_id
Group by publishers.pub_name, titles.title_id;

# We want to see all publishing houses and count all their titles
SELECT publishers.pub_name as publishing_house, count(titles.title_id) as CountTitles
FROM publications.publishers 
LEFT JOIN publications.titles
ON titles.pub_id = publishers.pub_id
Group by publishers.pub_name;

# We want to see all publishing houses and count all their titles + order by alias
SELECT publishers.pub_name as publishing_house, count(titles.title_id) as CountTitles
FROM publications.publishers 
LEFT JOIN publications.titles
ON titles.pub_id = publishers.pub_id
Group by publishers.pub_name
Order by CountTitles;

/*Create alias for table name in a join*/
SELECT pub.pub_name as publishing_house, count(tit.title_id) as CountTitles
FROM publications.publishers AS pub
LEFT JOIN publications.titles AS tit
ON tit.pub_id = pub.pub_id
Group by pub.pub_name
Order by CountTitles;

/*SUBQUERIES*/
/*JOIN STORES AND THEIR SALES: NAME OF STORES, COUNT OIF THEIR ORDERS,COUNT OF TITLES AND QTY from Sales*/

SELECT stores.stor_name as Store, 
    count(distinct (ord_num)) AS Orders ,
    count(sales.title_id) as Items,
	sum(publications.sales.qty) as Qty
FROM publications.stores
LEFT JOIN publications.sales
ON publications.sales.stor_id=publications.stores.stor_id
GROUP BY Store
;

/* AVERAGE HOW MANY ITEMS PER ORDER & ABERAGE QUANTITY PER ITEM?*/
/*CREATES TEMPORARY TABLE: We took query above and asign it to a new temorary table*/

CREATE TEMPORARY TABLE publications.store_sales_summary /*self chosen table name*/
SELECT stores.stor_name as Store, 
    count(distinct (ord_num)) AS Orders ,
    count(sales.title_id) as Items,
	sum(publications.sales.qty) as Qty
FROM publications.stores
LEFT JOIN publications.sales
ON publications.sales.stor_id=publications.stores.stor_id
GROUP BY Store
;

/*Look at temporary table*/
SELECT * FROM publications.store_sales_summary;

/* NOW TRY TO GET AVERAGE HOW MANY ITEMS PER ORDER & AvERAGE QUANTITY PER ITEM?*/
SELECT 
	publications.store_sales_summary.Store, 
    Items/Orders as Avg_Itmes_per_Order,
    Qty/Items as Avg_Quantity_per_Item
FROM publications.store_sales_summary
ORDER BY Store;

/*DOING THIS WITH A SUB-QUERY INSTEAD OF A TEMPORARY TABLE*/
/*We are puttin the two queries above together: Important Sub-Query needs an alias*/
/*Selecting somethng form a select statement entspricht einer Sub Query*/

SELECT 
	Store, /*we use only the aliases created later*/
    Items/Orders as Avg_Itmes_per_Order,
    Qty/Items as Avg_Quantity_per_Item

FROM 
(
    SELECT stores.stor_name as Store, 
    count(distinct (ord_num)) AS Orders ,
    count(sales.title_id) as Items,
	sum(publications.sales.qty) as Qty
FROM publications.stores
LEFT JOIN publications.sales
ON publications.sales.stor_id=publications.stores.stor_id
GROUP BY Store) AS summary /*alias necessary*/
;

/*ACTION QUERIES*/
CREATE TABLE publications.store_sales_summary /*self chosen table name*/
SELECT stores.stor_name as Store, 
    count(distinct (ord_num)) AS Orders ,
    count(sales.title_id) as Items,
	sum(publications.sales.qty) as Qty
FROM publications.stores
LEFT JOIN publications.sales
ON publications.sales.stor_id=publications.stores.stor_id
GROUP BY Store;

SELECT * FROM publications.store_sales_summary;
DELETE FROM publications.store_sales_summary; /*Delete tabe content*/
DROP TABLE publications.store_sales_summary; /*make entire table disappear*/
ALTER TABLE publications.store_sales_summary DROP COLUMN Qty; /* delete column and thereby changing table structure*/

/*to populate the table*/
INSERT INTO publications.store_sales_summary 
SELECT stores.stor_name as Store, 
    count(distinct (ord_num)) AS Orders ,
    count(sales.title_id) as Items,
	sum(publications.sales.qty) as Qty
FROM publications.stores
LEFT JOIN publications.sales
ON publications.sales.stor_id=publications.stores.stor_id
GROUP BY Store;

/*change specific table content*/
UPDATE publications.store_sales_summary
SET Qty=Qty*2;