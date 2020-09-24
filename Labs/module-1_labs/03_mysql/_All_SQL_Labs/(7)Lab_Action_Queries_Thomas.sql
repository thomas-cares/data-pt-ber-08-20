/* 1 Please create a new table in the publications database called total_royalties which for each author contains their author ID, last name, first name, number of total titles and the sum of royalties they have received.*/

DELETE FROM publications.total_royalties;/*Delete*/

SELECT * FROM publications.total_royalties; /*Look at*/

INSERT INTO publications.total_royalties /*Insert*/
SELECT 
	author_id, 
	lastname, 
    firstname,
    number_of_titles, 
    royalties_share + advance_share AS total_royalties
FROM 
	( 
    SELECT
	authors.au_id as author_id,
    authors.au_lname as lastname ,
    authors.au_fname as firstname,
    count(titleauthor.title_id) as number_of_titles,
    sum_book_royalties * percent_factor AS royalties_share,
    titles.advance * (titleauthor.royaltyper/100) AS advance_share
		FROM
		(
        SELECT
        sum(titles.royalty) as sum_book_royalties,
        titleauthor.royaltyper/100 as percent_factor
        FROM 
        titleauthor
        LEFT JOIN titles
        ON titles.title_id =titleauthor.title_id
        ) as calculation_2
        
    LEFT JOIN titleauthor
    ON titleauthor.au_id = authors.au_id
    LEFT JOIN titles
    ON titles.title_id =titleauthor.title_id
    ) as calculation_1
    GROUP BY author_id
    ;


/*2 Delete every author which has received total royalties of less than 100.*/
SELECT * FROM titles, authors, titleauthor;
DELETE FROM publications.total_royalties WHERE total_royalties < 100;
SELECT * FROM publications.total_royalties; /*Look at*/

