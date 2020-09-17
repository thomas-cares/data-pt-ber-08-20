/*1. From the client table, what are the ids of the first 5 clients from disrict_id 1?*/
SELECT client_ID FROM bank.client WHERE district_id = 1 limit 5;

/*2. From the client table, what is the id of the last client from district_id 72?*/
SELECT client_ID FROM bank.client WHERE district_id = 72 order by client_ID desc limit 1;

/*3. From the loan table, what are the 3 lowest amounts?*/
SELECT amount FROM bank.loan order by amount limit 3;

/*4.From the loan table, what are the possible values for status, ordered alphabetically in ascending order?*/
select distinct status FROM bank.loan order by status;

/*5. From the loans table, what is the loan_id of the highest payment received?*/
SELECT loan_id, payments FROM bank.loan order by payments desc limit 1;

/*6. From the loans table, what is the loan amount of the lowest 5 account_ids. Show the account_id and the corresponding amount*/
SELECT account_id, amount FROM bank.loan order by account_id limit 5;

/*7. From the loans table, which are the account_ids with the lowest loan amount have a loan duration of 60?*/
SELECT account_id, amount, duration FROM bank.loan WHERE duration = 60 order by amount Limit 5;

/*8. From the order table, what are the unique values of k_symbol?*/
SELECT DISTINCT k_symbol FROM bank.order order by k_symbol;

/*9. From the order table, which are the order_ids from the client with the account_id 34?*/
SELECT order_id FROM bank.order WHERE account_id=34 order by order_id;

/*10. From the order table, which account_ids were responsible for orders between order_id 29540 and order_id 29560 (inclusive)?*/
SELECT distinct account_id FROM bank.order WHERE order_id BETWEEN 29539 AND 29561 ;

/*11 From the order table, what are the individual amounts that were sent to (account_to) id 30067122?*/
SELECT amount FROM bank.order WHERE account_to = 30067122 order by amount;

/*12. From the trans table, show the trans_id, date, type and amount of the 10 first transactions from account_id = 793 in chronological order, from newest to oldest.*/
SELECT trans_id, date, type, amount FROM bank.trans WHERE account_id = 793 order by date desc limit 10;
