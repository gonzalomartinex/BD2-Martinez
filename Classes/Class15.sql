Use sakila;


-- ACT 1 
-- Create a view named list_of_customers, it should contain the following columns: customer id, customer full name, address, zip code, phone, city, country, status (when active column is 1 show it as 'active', otherwise is 'inactive'), store id

DROP VIEW IF EXISTS list_of_customers;

CREATE VIEW list_of_customers AS
SELECT customer_id, concat(first_name, " ", last_name), a.address, a.postal_code, a.phone, ci.city, co.country, case when c.active = 1 then "Active" else "Inactive" end as Status, c.store_id
FROM customer c 
INNER JOIN address a on c.address_id = a.address_id
INNER JOIN city ci ON a.city_id = ci.city_id 
INNER JOIN country co ON ci.country_id = co.country_id;

SELECT * FROM list_of_customers;


-- ACT 2
-- Create a view named film_details, it should contain the following columns: film id, title, description, category, price, length, rating, actors - as a string of all the actors separated by comma. Hint use GROUP_CONCAT

DROP VIEW IF EXISTS film_details;

CREATE VIEW film_details AS
SELECT f.film_id, f.title, f.description, c.name, f.length, f.rating, group_concat(" ", a.first_name, " ", a.last_name) as actores
FROM film f 
INNER JOIN film_category fc ON fc.film_id = f.film_id 
INNER JOIN category c ON fc.category_id = c.category_id
INNER JOIN film_actor fa on f.film_id = fa.film_id
INNER JOIN actor a on fa.actor_id = a.actor_id
group by f.film_id, c.name;

SELECT * FROM film_details;

-- ACT 3
-- Create view sales_by_film_category, it should return 'category' and 'total_rental' columns.

DROP VIEW IF EXISTS sales_by_film_category;

CREATE VIEW sales_by_film_category AS
SELECT c.name as category, count(r.rental_id) as total_rental FROM category c 
INNER JOIN film_category fc ON c.category_id = fc.category_id
INNER JOIN film f ON fc.film_id = f.film_id
INNER JOIN inventory i ON f.film_id = i.film_id
INNER JOIN rental r ON i.inventory_id = r.inventory_id
group by c.name;

SELECT * FROM sales_by_film_category;


-- ACT 4
-- Create a view called actor_information where it should return, actor id, first name, last name and the amount of films he/she acted on.

DROP VIEW IF EXISTS actor_information;

CREATE VIEW actor_information AS
SELECT a.actor_id, a.first_name, a.last_name, count(fa.actor_id) as "amount_films_acted"
FROM actor a
INNER JOIN film_actor fa on a.actor_id = fa.actor_id
group by a.actor_id;

SELECT * FROM actor_information;

-- ACT 5
-- Analyze view actor_info, explain the entire query and specially how the sub query works. Be very specific, take some time and decompose each part and give an explanation for each.

-- CREATE VIEW actor_information AS
-- Aquí se está creando una nueva view llamada actor_information. Una vista es una consulta guardada para 
-- poder ser usada luego sin necesidad de runnearla cada vez y de esta forma consumiendo menos recursos.
-- Puedes consultar esta vista más tarde como si fuera una tabla, pero su contenido se genera dinámicamente cada vez que accedes a ella.
-- Permite definir consultas complejas una vez y luego reutilizarlas fácilmente sin tener que escribirlas nuevamente, 
-- además de ayudar a simplificar el acceso a datos.

-- SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.actor_id) AS "amount_films_acted"
-- Esta parte del SELECT es la que define los datos que se incluirán en la vista. Se seleccionan las siguientes columnas del actor:
-- a.actor_id, a.first_name, a.last_name, COUNT(fa.actor_id) AS "amount_films_acted": Este es el número total de películas en las 
-- que ha participado el actor. La función COUNT() cuenta cuántos registros (específicamente cuántos actores relacionados) aparecen
-- en la tabla de relaciones entre actores y películas.

-- FROM actor a
-- Esta parte d indica que la consulta toma datos de la tabla actor, con el alias a. El alias "a" es solo 
-- una forma más corta de referirse a la tabla dentro de la consulta, haciéndola más fácil de leer y manejar.

-- ACT 6
-- Materialized views, write a description, why they are used, alternatives, DBMS were they exist, etc.

-- Las vistas materializadas almacenan físicamente los resultados de una consulta, mejorando el rendimiento 
-- de consultas complejas al evitar recalcular datos cada vez. Se usan principalmente en análisis de datos y 
-- reportes para consultas que involucran grandes volúmenes de datos o cálculos costosos. 
-- A diferencia de las vistas regulares, las vistas materializadas requieren actualizaciones periódicas para 
-- mantenerse sincronizadas con los datos subyacentes.

-- Alternativas:
-- Vistas regulares: No almacenan resultados, solo ejecutan la consulta al acceder.
-- Índices: Mejoran el acceso a los datos pero no guardan los resultados de consultas específicas.
-- Tablas temporales: Simulan vistas materializadas pero requieren gestión manual.

-- DBMS con soporte:
-- Oracle: Soporte completo con actualización automática.
-- PostgreSQL: Soporte con actualización manual.
-- SQL Server: Usa vistas indexadas, similares a las materializadas.
-- Snowflake y BigQuery: Ofrecen soporte nativo en entornos de análisis masivo.

-- Desventajas: Pueden consumir más almacenamiento y requieren sincronización para evitar datos obsoletos.