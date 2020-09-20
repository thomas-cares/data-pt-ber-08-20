/*CHALLENGE 0 A
a) Create a table which for each author contains their author id, first name, last name, and the total number of titles they have written according to the titleauthor table. Give each variable an alias, such that the table output is easy to read and interpret. Are there any authors in the author table, that do not have any publications in the titleauthor table?*/
SELECT 
	publications.authors.au_id as author_ID,
    publications.authors.au_fname as author_firstname, 
    publications.authors.au_lname as author_lastname,
    count(publications.titleauthor.title_id) as nr_of_titles
FROM
	publications.authors
    LEFT JOIN publications.titleauthor
	ON publications.authors.au_id = publications.titleauthor.au_id
GROUP BY author_ID
ORDER BY nr_of_titles desc;

/*CHALLENGE 0,B 
Create a table which for each job description contains the first hire date (i.e. the first employee with this job id was hired). Again, name the columns properly to have a nice return table. Sort the results from the job description with the first hire to the one with the last hire.*/

SELECT 
	publications.jobs.job_desc as job_description,
    min(publications.employee.hire_date) as hire_date
FROM
	publications.employee
    LEFT JOIN publications.jobs
    ON jobs.job_id = employee.job_id
GROUP BY job_description
ORDER BY hire_date;

/*Challenge 1 - Who Have Published What At Where? In this challenge you will write a MySQL SELECT query that joins various tables to figure out what titles each author has published at which publishers. Your output should have at least the following columns:*/
SELECT
	publications.titles.title as book_title,
    publications.authors.au_id as author_ID,
    publications.authors.au_fname as author_firstname, 
    publications.authors.au_lname as author_lastname,
	publications.publishers.pub_name as publishing_house
FROM
	publications.authors
    LEFT JOIN publications.titleauthor
    ON publications.authors.au_id = publications.titleauthor.au_id
    
    LEFT JOIN publications.titles
    ON publications.titleauthor.title_id = publications.titles.title_id
    
    LEFT JOIN publications.publishers
    ON publications.titles.pub_id = publications.publishers.pub_id
    
order by book_title;
#2nd attempt
SELECT
	publications.titles.title as book_title,
   	publications.authors.au_id as author_ID,
    	publications.authors.au_fname as author_firstname, 
    	publications.authors.au_lname as author_lastname,
	publications.publishers.pub_name as publishing_house

FROM
	publications.titles
	LEFT JOIN publications.titleauthor
    	ON publications.titleauthor.title_id = publications.titles.title_id	
	LEFT JOIN publications.authors
    	ON publications.authors.au_id = publications.titleauthor.au_id
     
	LEFT JOIN publications.publishers
    	ON publications.titles.pub_id = publications.publishers.pub_id
;
/*Challenge 2 - Who Have Published How Many At Where? Elevating from your solution in Challenge 1, query how many titles each author has published at each publisher. Your output should look something like below:*/
SELECT
	publications.authors.au_id as author_ID,
	publications.authors.au_lname as author_lastname,
	publications.authors.au_fname as author_firstname, 
	publications.publishers.pub_name as publishing_house,
    count(publications.titleauthor.title_id) as number_of_books

FROM
	publications.titles
	LEFT JOIN publications.titleauthor
    	ON publications.titleauthor.title_id = publications.titles.title_id	
	LEFT JOIN publications.authors
    	ON publications.authors.au_id = publications.titleauthor.au_id
	LEFT JOIN publications.publishers
    	ON publications.titles.pub_id = publications.publishers.pub_id
        
	GROUP BY  publishing_house, author_ID
    ORDER BY author_ID desc;
    
/*Challenge 3 - Best Selling Authors Who are the top 3 authors who have sold the highest number of titles? Write a query to find out.*/
select * FROM publications.sales;

SELECT 
    publications.authors.au_id as author_ID,
	publications.authors.au_fname as author_firstname, 
	publications.authors.au_lname as author_lastname,
    sum(publications.sales.qty) as Total
FROM
	authors
    Left Join titleauthor
    on titleauthor.au_id = authors.au_id
    
    Left Join sales
    on titleauthor.title_id = sales.title_id
GROUP BY 
	author_id
ORDER by Total desc limit 3;

/*Challenge 4 - Best Selling Authors Ranking: Now modify your solution in Challenge 3 so that the output will display all 23 authors instead of the top 3. Note that the authors who have sold 0 titles should also appear in your output (ideally display 0 instead of NULL as the TOTAL). Also order your results based on TOTAL from high to low.*/

select * FROM publications.sales;

SELECT 
    publications.authors.au_id as author_ID,
	publications.authors.au_fname as author_firstname, 
	publications.authors.au_lname as author_lastname,
    COALESCE(sum(publications.sales.qty),0) AS Total
FROM
	authors
    Left Join titleauthor
    on titleauthor.au_id = authors.au_id
    
    Left Join sales
    on titleauthor.title_id = sales.title_id
GROUP BY 
	author_id
ORDER by Total desc limit 23;

/*Bonus Challenge - Most Profiting Authors*/

SELECT
	author_id,
    Lastname,
    Firstname,
    ROUND((sum_royalty+sum_advance) * royal_share) AS Profit
FROM
(SELECT
	authors.au_id as author_id,
    authors.au_lname as Lastname,
    authors.au_fname as Firstname,
    sum(titles.royalty) as sum_royalty,
    sum(titles.advance) as sum_advance,
    titleauthor.royaltyper as royal_share
FROM
	authors
    LEFT JOIN titleauthor
    ON authors.au_id = titleauthor.au_id
    
    LEFT JOIN titles
    ON titles.title_id=titleauthor.title_id
GROUP BY author_id, royal_share

    ) as sumary
ORDER BY PROFIT desc limit 3;
	