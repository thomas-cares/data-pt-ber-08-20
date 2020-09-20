/*1. From the marketing_qualified_leads table, find the earliest and latest first_contact_date.*/
select min(first_contact_date), max(first_contact_date) FROM olist.marketing_qualified_leads;
/*2. From the marketing_qualified_leads table, find the top 3 most frequent origin types for all first_contact_date entries in 2018.*/
select count(origin), origin from olist.marketing_qualified_leads
WHERE first_contact_date BETWEEN '2017-12-31 23:59:58' AND '2019-01-01 00:00:01'
group by origin
order by count(origin)
DESC
limit 3;

/*3. From the marketing_qualified_leads table, find the first_contact_date with the highest number of mql_id entries and state the number of entries on that date.*/
SELECT count(mql_id), first_contact_date FROM olist.marketing_qualified_leads group by first_contact_date order by count(mql_id) DESC Limit 3;

/*4. From the products table, find the name and count of the top 2 product category names.*/
SELECT count(product_id), product_category_name FROM olist.products GROUP BY product_category_name ORDER BY count(product_id) DESC LIMIT 2;

/*5. From the products table, find the product_category_name with the highest recorded product weight in grams.*/
SELECT max(product_weight_g), product_category_name FROM olist.products GROUP BY product_category_name order by max(product_weight_g) desc limit 3;

/*6. From the products table, find the product_category_name with the greatest sum of dimensions including length, height and width in centimeters.*/
SELECT product_id, product_category_name, (product_length_cm + product_height_cm + product_width_cm) as Total FROM olist.products GROUP BY product_category_name, product_id, Total order by Total desc limit 3;

/* 7. From the order_payments table, find the payment_type with the greatest number of order_id entries and the count of that payment type.*/
SELECT count(order_id),  payment_type FROM olist.order_payments group by  payment_type order by count(order_id) desc limit 3;

/*8. From the order_payments table, find the highest payment value for an individual order_id.*/
SELECT max(payment_value) FROM olist.order_payments;

/*9. From the sellers table, find the 3 seller states with the greatest number of distinct seller cities.*/
SELECT seller_state, count(distinct seller_city) FROM olist.sellers group by seller_state order by count(distinct seller_city) desc limit 3;