/*Lab | SQL*/
/*1. From the order_items table, find the price of the highest priced order item and lowest price order item.*/
select max(price),  min(price) From olist.order_items;

/*2. From the order_items table, what is range of the shipping_limit_date of the orders?*/
select min(shipping_limit_date), max(shipping_limit_date) from olist.order_items;

/*3. From the customers table, find the 3 states with the greatest number of customers.*/
SELECT COUNT(customer_id),customer_state FROM olist.customers Group by customer_state order by count(customer_id) DESC Limit 3;

/*4. From the customers table, within the state with the greatest number of customers, find the 3 cities with the greatest number of customers.*/
SELECT COUNT(customer_id), customer_city FROM olist.customers WHERE customer_state='SP' Group by customer_city  order by count(customer_id) DESC Limit 3;

/*5. From the closed_deals table, how many distinct business segments are there (not including null)?*/
SELECT COUNT(DISTINCT business_segment) FROM olist.closed_deals WHERE business_segment IS NOT NULL;

/*6. From the closed_deals table, sum the declared_monthly_revenue for duplicate row values in business_segment and find the 3 business segments with the highest declared monthly revenue (of those that declared revenue).*/
SELECT DISTINCT business_segment, SUM(declared_monthly_revenue)  From olist.closed_deals Group by business_segment order by sum(declared_monthly_revenue) DESC Limit 3;

/*7. From the order_reviews table, find the total number of distinct review score values.*/
select Count(distinct review_score) from  olist.order_reviews;

/*8. In the order_reviews table, create a new column with a description that corresponds to each number category for each review score from 1 - 5.*/
/* I dont really understand the task so I decided to create a new column and fill it with selected data from another column*/
select review_score as Five_Star_Reviews from olist.order_reviews WHERE review_score='5' Limit 10;

/*9. From the order_reviews table, find the review score occurring most frequently and how many times it occurs.*/
Select count(review_score), review_score from olist.order_reviews group by review_score order by count(review_score) desc limit 5;
