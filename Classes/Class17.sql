USE sakila;

-- ACT 1
-- Create two or three queries using address table in sakila db: include postal_code in where (try with in/not it operator), eventually join the table with city/country tables., measure execution time., Then create an index for postal_code on address table., measure execution time again and compare with the previous ones., Explain the results

SELECT * FROM address WHERE postal_code IN ('99405', '1079');
SELECT * FROM address WHERE postal_code NOT IN ('72878');


SELECT a.*, c.city, ctr.country 
FROM address a
JOIN city c ON a.city_id = c.city_id
JOIN country ctr ON c.country_id = ctr.country_id
WHERE a.postal_code = '43331';

DROP INDEX postal_code ON address;
/*
Durations without Indexes:
Query 1 Duration: 0.00094 sec / 0.000017 sec
Query 2 Duration: 0.0010 sec / 0.00018 sec
Query 3 Duration: 0.0082 sec / 0.000021 sec
*/

CREATE INDEX postal_code ON address(postal_code);
/*
Durations with Indexes:
Query 1 Duration: 0.00066 sec / 0.000016 sec
Query 2 Duration: 0.00093 sec / 0.00018 sec
Query 3 Duration: 0.0061 sec / 0.000021 sec
*/


-- ACT 2

SELECT * FROM actor WHERE first_name = 'A%';
SELECT * FROM actor WHERE last_name = 'A%';

/* When running these two queries, there is a noticeable difference in execution times compared to the previous task.

The first query, which retrieves each actor's first_name (a non-indexed column), has an average execution time of 0.0011 sec / 0.000025 sec. 
In contrast, the second query, which searches the indexed last_name column, averages 0.00076 sec / 0.000016 sec.

While the dataset is relatively small, similar to Activity 1, the difference in times is still quite minimal. However, with a larger dataset, 
the difference would become much more apparent. This is because the last_name column benefits from having an index, enabling the database to 
quickly find matching rows. Meanwhile, the first_name column lacks an index, so the database must perform a full table scan to find the relevant 
values. 

*/

-- ACT 3

SELECT * FROM film WHERE description LIKE '%aventura%';


SELECT * FROM film_text WHERE MATCH(description) AGAINST('aventura');

/*
When comparing these two queries, the key difference is that the query using MATCH / AGAINST runs faster than the one using LIKE. 

This is because the LIKE operator performs a full scan of the table, checking each row of the `description` field individually for the 
word 'aventura', which is inefficient for large text fields. In contrast, MATCH / AGAINST leverages the FULLTEXT index on the `film_text` 
table to quickly find all relevant results without scanning each row.

Therefore, for queries that involve large text fields, creating a FULLTEXT index is ideal for efficiently filtering results, 
while LIKE can still be useful for smaller text fields or simple pattern matching. Depending on the size and type of text data, 
using FULLTEXT indexing can greatly enhance performance compared to LIKE.
*/
