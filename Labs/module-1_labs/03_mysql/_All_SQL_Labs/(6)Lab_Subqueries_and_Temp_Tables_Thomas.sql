/*In this challenge, please create a table which for each author contains their author ID, last name, first name, number of total titles and the sum of royalties they have received,
In a second step, we from this table would then like to calculate the average royalty per title each author has received. The final table should contain for each author their author ID, last name, first name and average royalty calculated as sum of royalties divided by title count.
Solve this challenge in two ways: first, by using a subquery. Then, by creating a temporary table.*/

SELECT 
	authors.au_id as author_id, 
	authors.au_lname as author_lastname, 
	authors.au_fname as author_firstname, 
	count(titleauthor.title_id) as numberoftitles,
	sum(titles.royalty) as sumroyalty

FROM
publications.authors
LEFT JOIN titleauthor
ON authors.au_id=titleauthor.au_id
LEFT JOIN titles
ON titles.title_id=titleauthor.title_id
GROUP BY authors.au_id
ORDER BY author_id;

/* Getting Avg_Royalty with subquerie*/
SELECT 
author_id,
author_lastname,
author_firstname,
numberoftitles,
sumroyalty,
sumroyalty/numberoftitles as avg_royalty
FROM
(SELECT
	authors.au_id as author_id, 
	authors.au_lname as author_lastname, 
	authors.au_fname as author_firstname, 
	count(titleauthor.title_id) as numberoftitles,
	sum(titles.royalty) as sumroyalty
	FROM
	publications.authors
	LEFT JOIN titleauthor
	ON authors.au_id=titleauthor.au_id
	LEFT JOIN titles
	ON titles.title_id=titleauthor.title_id
	GROUP BY authors.au_id
	ORDER BY author_id) AS summary
;

/* Getting Avg_Royalty with temporary table*/
CREATE TEMPORARY TABLE publications.temporary_table

SELECT 
	authors.au_id as author_id, 
	authors.au_lname as author_lastname, 
	authors.au_fname as author_firstname, 
	count(titleauthor.title_id) as numberoftitles,
	sum(titles.royalty) as sumroyalty

FROM
	publications.authors
	LEFT JOIN titleauthor
	ON authors.au_id=titleauthor.au_id
	LEFT JOIN titles
	ON titles.title_id=titleauthor.title_id
	GROUP BY authors.au_id
	ORDER BY author_id;
/*now calculate in with temporary table*/
SELECT 
	temporary_table.author_id,
    sumroyalty/numberoftitles as avg_royalty
FROM
	publications.temporary_table
GROUP BY
	author_id, avg_royalty;