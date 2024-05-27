USE sakila;

-- query 1
SELECT title, rating, length
FROM film
WHERE length = (
    SELECT MIN(length)
    FROM film
);

-- query 2
select title 
from film f1 
where length < ALL (select length from film f2 where f1.film_id != f2.film_id);

-- query 3
SELECT c.customer_id, c.first_name, c.last_name, a.address, a.postal_code, a.phone, MIN(p.amount) AS lowest_payment_amount
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, a.address, a.postal_code, a.phone;

-- query 4
select c.*, (select max(p.amount) 
from payment p 
where c.customer_id=p.customer_id) as highest, (select min(amount) 
from payment p 
where c.customer_id=p.customer_id) as lowest 
from customer c;

