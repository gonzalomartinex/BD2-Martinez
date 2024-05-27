USE sakila;

-- Query 4
SELECT f.title
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
WHERE i.inventory_id IS NULL;

-- Query 5
SELECT i.inventory_id, f.title
FROM inventory i
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE r.rental_id IS NULL;

-- Query 6
SELECT 
    c.first_name,
    c.last_name,
    s.store_id,
    f.title,
    r.rental_date,
    r.return_date
FROM 
    customer c
JOIN 
    rental r ON c.customer_id = r.customer_id
JOIN 
    inventory i ON r.inventory_id = i.inventory_id
JOIN 
    store s ON i.store_id = s.store_id
JOIN 
    film f ON i.film_id = f.film_id
ORDER BY 
    s.store_id, c.last_name;

-- Querry 7

SELECT 
    CONCAT(ci.city, ', ', co.country) AS store_location,
    CONCAT(m.first_name, ' ', m.last_name) AS manager_name,
    SUM(p.amount) AS total_sales
FROM 
    store s
JOIN 
    staff m ON s.manager_staff_id = m.staff_id
JOIN 
    address a ON s.address_id = a.address_id
JOIN 
    city ci ON a.city_id = ci.city_id
JOIN 
    country co ON ci.country_id = co.country_id
JOIN 
    inventory i ON s.store_id = i.store_id
JOIN 
    rental r ON i.inventory_id = r.inventory_id
JOIN 
    payment p ON r.rental_id = p.rental_id
GROUP BY 
    store_location, manager_name
ORDER BY 
    total_sales DESC;

-- Querry 8
SELECT 
    CONCAT(a.first_name, ' ', a.last_name) AS actor_name,
    COUNT(fa.film_id) AS film_appearances
FROM 
    actor a
JOIN 
    film_actor fa ON a.actor_id = fa.actor_id
GROUP BY 
    actor_name
ORDER BY 
    film_appearances DESC
LIMIT 1;
