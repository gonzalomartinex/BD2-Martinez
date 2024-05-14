USE sakila;

-- query 1
SELECT last_name, first_name
FROM actor
WHERE last_name IN (
  SELECT last_name
  FROM actor
  GROUP BY last_name
  HAVING COUNT(*) > 1
)
ORDER BY last_name, first_name;

-- query 2
SELECT actor_id, first_name, last_name
FROM actor
WHERE actor_id NOT IN (
    SELECT actor_id
    FROM film_actor
);

-- query 3
SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM rental
    GROUP BY customer_id
    HAVING COUNT(rental_id) = 1
);

-- query 4
SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM rental
    GROUP BY customer_id
    HAVING COUNT(rental_id) > 1
);

-- query 5
SELECT actor.actor_id, actor.first_name, actor.last_name
FROM actor
WHERE actor.actor_id IN (
    SELECT film_actor.actor_id
    FROM film_actor
    JOIN film ON film_actor.film_id = film.film_id
    WHERE film.title IN ('BETRAYED REAR', 'CATCH AMISTAD')
);

-- query 6
SELECT actor.actor_id, actor.first_name, actor.last_name
FROM actor
WHERE actor.actor_id IN (
    SELECT film_actor.actor_id
    FROM film_actor
    JOIN film ON film_actor.film_id = film.film_id
    WHERE film.title = 'BETRAYED REAR'
)
AND actor.actor_id NOT IN (
    SELECT film_actor.actor_id
    FROM film_actor
    JOIN film ON film_actor.film_id = film.film_id
    WHERE film.title = 'CATCH AMISTAD'
);

-- query 7
SELECT actor.actor_id, actor.first_name, actor.last_name
FROM actor
WHERE actor.actor_id IN (
    SELECT film_actor.actor_id
    FROM film_actor
    JOIN film ON film_actor.film_id = film.film_id
    WHERE film.title = 'BETRAYED REAR'
)
AND actor.actor_id IN (
    SELECT film_actor.actor_id
    FROM film_actor
    JOIN film ON film_actor.film_id = film.film_id
    WHERE film.title = 'CATCH AMISTAD'
);

-- query 8
SELECT actor.actor_id, actor.first_name, actor.last_name
FROM actor
WHERE actor.actor_id NOT IN (
    SELECT film_actor.actor_id
    FROM film_actor
    JOIN film ON film_actor.film_id = film.film_id
    WHERE film.title = 'BETRAYED REAR'
)
AND actor.actor_id NOT IN (
    SELECT film_actor.actor_id
    FROM film_actor
    JOIN film ON film_actor.film_id = film.film_id
    WHERE film.title = 'CATCH AMISTAD'
);


