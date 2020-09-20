/* 1 Please create a new table in the publications database called total_royalties which for each author contains their author ID, last name, first name, number of total titles and the sum of royalties they have received.*/

DELETE FROM publications.total_royalties;/*Delete*/

SELECT * FROM publications.total_royalties; /*Look at*/

INSERT INTO publications.total_royalties /*Insert*/
SELECT
	authors.au_id as author_id,
    authors.au_lname as lastname ,
    authors.au_fname as firstname,
    count(titleauthor.title_id) as number_of_titles,
    COALESCE(sum(titles.royalty),0) AS total_royalties
FROM
	authors
    LEFT JOIN titleauthor
    ON titleauthor.au_id = authors.au_id
    LEFT JOIN titles
    ON titles.title_id =titleauthor.title_id
GROUP BY author_id
ORDER BY author_id
;

