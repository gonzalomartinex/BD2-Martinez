USE sakila;

-- 1

INSERT INTO customer (store_id, first_name, last_name, email, address_id, active, create_date)
VALUES (
    1,
    'Teo', 
    'Reyna',
    'Teo.Reyna@example.com',
    (
        SELECT MAX(address.address_id)
        FROM address
        JOIN city ON address.city_id = city.city_id
        JOIN country ON city.country_id = country.country_id
        WHERE country.country = 'United States'
    ), -- address_id
    1, -- active
    NOW() -- create_date
);
select * from customer;

-- 2

INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id)
VALUES (
    NOW(),
    (SELECT MAX(inventory_id) FROM inventory WHERE film_id = (SELECT film_id FROM film WHERE title = 'Academy Dinosaur')), 
    (SELECT customer_id FROM customer ORDER BY create_date DESC LIMIT 1),
    (SELECT staff_id FROM staff WHERE store_id = 2 LIMIT 1)
);
select * From rental;


-- 3

-- si no desactivamos el modo seguro temporalmente 
-- en tu sesión actual con el siguiente comando no 
-- se puede runear el update luego lo puedes activar 
-- nuevamente con el otro comando debajo

SET SQL_SAFE_UPDATES = 0;

UPDATE film
SET release_year = CASE 
    WHEN rating = 'G' THEN 2001
    WHEN rating = 'PG' THEN 2002
    WHEN rating = 'PG-13' THEN 2003
    WHEN rating = 'R' THEN 2004
    WHEN rating = 'NC-17' THEN 2005
    ELSE release_year
END
WHERE film_id IS NOT NULL;

SET SQL_SAFE_UPDATES = 1;


-- 4

SELECT rental_id, inventory_id, rental_date
FROM rental
WHERE return_date IS NULL
ORDER BY rental_date DESC
LIMIT 1;

UPDATE rental
SET return_date = NOW()
WHERE rental_id = 1;

-- 5

SELECT film_id
FROM film
WHERE title = 'Academy Dinosaur';

DELETE FROM payment
WHERE rental_id IN (
    SELECT rental_id 
    FROM rental 
    WHERE inventory_id IN (
        SELECT inventory_id 
        FROM inventory 
        WHERE film_id = 1
    )
);

DELETE FROM rental
WHERE inventory_id IN (
    SELECT inventory_id 
    FROM inventory 
    WHERE film_id = 1
);

DELETE FROM inventory
WHERE film_id = 1;

DELETE FROM film_actor
WHERE film_id = 1;

DELETE FROM film_category
WHERE film_id = 1;

DELETE FROM film
WHERE film_id = 1;

-- 6


SELECT inventory_id
FROM inventory
WHERE film_id IN (SELECT film_id FROM film)
AND inventory_id NOT IN (SELECT inventory_id FROM rental WHERE return_date IS NULL)
LIMIT 1;

INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id)
VALUES (
    NOW(),
    10,
    (SELECT customer_id FROM customer ORDER BY create_date DESC LIMIT 1),
    (SELECT staff_id FROM staff ORDER BY last_update DESC LIMIT 1)
);

INSERT INTO payment (customer_id, staff_id, rental_id, amount, payment_date)
VALUES (
    (SELECT customer_id FROM customer ORDER BY create_date DESC LIMIT 1),
    (SELECT staff_id FROM staff ORDER BY last_update DESC LIMIT 1),
    (SELECT rental_id FROM rental ORDER BY rental_date DESC LIMIT 1),
    (SELECT rental_rate FROM film WHERE film_id = (SELECT film_id FROM inventory WHERE inventory_id = 10)),
    NOW()
);

