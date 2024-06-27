Use sakila;

-- Genera un reporte que muestre los títulos de las películas 
-- que tienen una duración mayor que la duración de cualquier 
-- película en la categoría 'Children'.  

SELECT f.title, f.length, c.name 
FROM film f inner join film_category fc USING (film_id) 
inner join category c USING (category_id) 
WHERE f.length > ALL 
	(SELECT f2.length 
    FROM film f2 inner join film_category fc2 USING (film_id) 
    inner join category USING (category_id) 
    WHERE category.name = 'Children');
    
    
    
-- Mostrar aquellos clientes cuya cantidad de alquileres 
-- sea mayor al promedio de alquileres por cliente. 
-- Además, mostrar la cantidad de alquileres y una lista 
-- de los títulos de las películas alquiladas. 

SELECT c.customer_id, count(r.customer_id), avg(Promedio) 
FROM customer c inner join rental r USING (customer_id)
group by customer_id having (select avg(Promedio) 
FROM (SELECT count(r.customer_id) as Promedio
	FROM customer c inner join rental r USING (customer_id)
    group by customer_id) as A);

select avg(Promedio) 
FROM (SELECT count(r.customer_id) as Promedio
	FROM customer c inner join rental r USING (customer_id)
    group by customer_id) as A;



 -- Obtener los pares de pagos realizados por el mismo cliente, 
 -- considerar los clientes cuyo nombre comienza con alguna vocal. 
 -- Mostrar el nombre del cliente y los 2 montos.

SELECT c.first_name, p.amount, p2.amount
FROM customer c inner join payment p USING (customer_id) inner join payment p2 USING (customer_id)
where p2.payment_id > p.payment_id AND c.first_name LIKE "A%" or c.first_name LIKE "E%" or c.first_name LIKE "I%" or c.first_name LIKE "O%" or c.first_name LIKE "U%";


-- Listar todos pagos cuyo monto no sea ni maximo ni minimo, que 
-- sean de los rentalsd cuyas IDs son: 11, 56, 45, 34 y 89. Y el 
-- staff_id sea distinto de 2.

select r.* FROM rental r WHERE r.rental_id != 11 and r.rental_id != 56 and r.rental_id != 45 and r.rental_id != 34 and r.rental_id != 89 and r.staff_id != 2;


-- nota final 5
