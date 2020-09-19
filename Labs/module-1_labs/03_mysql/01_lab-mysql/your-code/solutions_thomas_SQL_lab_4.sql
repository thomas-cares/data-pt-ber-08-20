/*1. From the client table, of all districts with a district_id lower than 10, how many clients are from each district_id? Show the results sorted by district_id in ascending order.*/
SELECT district_id, count(client_id) FROM bank.client WHERE district_id < 10 GROUP BY district_id order by district_id;

/*2. From the card table, how many cards exist for each type? Rank the result starting with the most frequent type.*/
SELECT count(type), type FROM bank.card group by type order by count(type) desc;

/*3. Using the loan table, print the top 10 account_ids based on the sum of all of their loan amounts.*/
SELECT account_id, sum(amount) FROM bank.loan group by account_id order by sum(amount) desc limit 10;

/*4. From the loan table, retrieve the number of loans issued for each day, before (excl) 930907, ordered by date in descending order*/
SELECT count(loan_id), date FROM bank.loan WHERE date < 930907 group by date order by date desc;

/*5. From the loan table, for each day in December 1997, count the number of loans issued for each unique loan duration, ordered by date and duration, both in ascending order. You can ignore days without any loans in your output.*/
SELECT date, duration, count(loan_id) FROM bank.loan WHERE date BETWEEN 971201 AND 980101 group by date, duration order by date ;
/*VERSTEH ICH NICHT: Lösung sieht nur Daten bis 25.12. vor. da gibts danach aber noch welche. Ausserdem sieht Aufgabe vor nach Datum und Duration zu ordnen - das geht aber nicht. Ausserdem wird gebeten um count loans for each unique loan duration. In der Lösung tauchen aber alle durations weiterhin aufgesplttet vor*/

/* 6. From the trans table, for account_id 396, sum the amount of transactions for each type (VYDAJ = Outgoing, PRIJEM = Incoming). Your output should have the account_id, the type and the sum of amount, named as total_amount. Sort alphabetically by type.*/
SELECT account_id, type, sum(amount) FROM bank.trans WHERE account_id = 396 group by type;


/*7. From the previous output, translate the values for type to English, rename the column to transaction_type, round total_amount down to an integer.*/
SELECT 
	account_id, 
	(case type 
		when 'PRIJEM' then 'INCOMING' 
        when 'VYDAJ' then 'OUTGOING'
        end) as transaction_type, 
	round(sum(amount)) as round_total_amount 
FROM bank.trans WHERE account_id = 396 group by transaction_type, account_id ;


/*8. From the previous result, modify you query so that it returns only one row, with a column for incoming amount, outgoing amount and the difference*/
SELECT 
	account_id, 
	(case type 
		when 'PRIJEM' then 'INCOMING' 
        when 'VYDAJ' then 'OUTGOING'
        end) as transaction_type, 
	round(sum(amount)) as round_total_amount 
FROM bank.trans WHERE account_id = 396 group by transaction_type, account_id ;

/*9. Continuing with the previous example, rank the top 10 account_ids based on their difference*/


