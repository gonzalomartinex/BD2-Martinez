USE sakila;

-- 1) Obtener Clientes que Viven en Argentina

SELECT CONCAT(c.first_name, ' ', c.last_name) AS nombre_completo, a.address AS direccion, ci.city AS ciudad
FROM customer c
INNER JOIN address a ON c.address_id = a.address_id
INNER JOIN city ci ON a.city_id = ci.city_id
INNER JOIN country co ON ci.country_id = co.country_id
WHERE co.country = 'Argentina';

-- 2) Mostrar Título de Película, Idioma y Calificación (Usando CASE)

SELECT f.title AS titulo_pelicula, l.name AS idioma,
    CASE f.rating
        WHEN 'G' THEN 'Para Todos los Públicos'
        WHEN 'PG' THEN 'Guía Parental Sugerida'
        WHEN 'PG-13' THEN 'Advertencia: Padres Fuertes'
        WHEN 'R' THEN 'Restringido'
        WHEN 'NC-17' THEN 'Solo para Adultos'
        ELSE 'Sin Clasificación'
    END AS clasificacion
FROM film f
INNER JOIN language l ON f.language_id = l.language_id;

-- 3) Mostrar Películas de un Actor

SELECT f.title AS titulo, f.release_year AS año_estreno
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id
WHERE CONCAT_WS(' ', TRIM(LOWER(a.first_name)), TRIM(LOWER(a.last_name))) LIKE CONCAT('%', REPLACE(REPLACE(TRIM('TEO REYNA'), ' ', ''), '.', ''), '%');

-- 4) Encontrar Alquileres en Mayo y Junio

SELECT f.title AS titulo_pelicula, CONCAT(c.first_name, ' ', c.last_name) AS cliente,
    CASE 
        WHEN r.return_date IS NOT NULL THEN 'Sí'
        ELSE 'No'
    END AS devuelto
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN customer c ON r.customer_id = c.customer_id
WHERE MONTH(r.rental_date) IN (5, 6);

-- 5) Funciones CAST y CONVERT en MySQL
-- En MySQL, las funciones CAST y CONVERT se utilizan para convertir el tipo de datos de una expresión.
-- CONVERT tiene una opción adicional para la conversión entre diferentes conjuntos de caracteres.
-- Ejemplo:

SELECT 
    CAST(452 AS CHAR) AS ejemplo_cast,
    CONVERT(452, CHAR(10)) AS ejemplo_convert;

-- 6) Funciones NVL, ISNULL, IFNULL, COALESCE
-- NVL: Disponible en Oracle, reemplaza NULL con el valor especificado.
-- ISNULL: Disponible en SQL Server y MySQL, se comporta como NVL.
-- IFNULL: Exclusiva de MySQL, devuelve un valor por defecto si la expresión es NULL.
-- COALESCE: Compatible con la mayoría de las bases de datos, devuelve el primer valor no NULL en una lista.
-- Ejemplos en MySQL:

SELECT 
    IFNULL(NULL, 'valor_por_defecto') AS ejemplo_ifnull,
    COALESCE(NULL, 'valor1', 'valor_por_defecto') AS ejemplo_coalesce;
