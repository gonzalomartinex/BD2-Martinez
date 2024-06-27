use sakila;

-- 1. Obtener los pares de apellidos de actores que comparten nombres, considerando
-- solo los actores cuyo nombre comienza con una vocal. Mostrar el nombre, los 2
-- apellidos y las películas que comparten.

select a.actor_id, a.first_name, a.last_name, a2.first_name, a2.last_name, 
	concat((SELECT f.title
    FROM film_actor fa 
    inner join film_actor fa2 USING (film_id) 
    WHERE a.actor_id=fa.actor_id  and a2.actor_id=fa2.actor_id)) as peliculas
from actor a 
inner join actor a2 ON a.first_name=a2.first_name and a.actor_id<a2.actor_id
inner join film_actor fa ON a.actor_id=fa.actor_id 
inner join film f using (film_id) 
where a.first_name LIKE "A%" or a.first_name LIKE "E%" or a.first_name LIKE "I%" or a.first_name LIKE "O%" or a.first_name LIKE "U%"
group by a.actor_id, a.first_name, a.last_name, a2.last_name, peliculas
ORDER BY a.actor_id;

Error Code: 1055. Expression #6 of SELECT list is not in GROUP BY clause and contains nonaggregated column 
'sakila.a2.actor_id' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by


select a.actor_id, a.first_name, a.last_name, a2.first_name, a2.last_name
from actor a 
inner join film_actor fa using (actor_id)
inner join film f using (film_id) 
inner join actor a2 using (first_name) 
where first_name LIKE "A%" or first_name LIKE "E%" or first_name LIKE "I%" or first_name LIKE "O%" or first_name LIKE "U%"
group by a.actor_id, a.first_name, a.last_name, a2.last_name
ORDER BY a.first_name;


Select actor_id, first_name, last_name FROM actor WHERE first_name LIKE "A%" or first_name LIKE "E%" or first_name LIKE "I%" or first_name LIKE "O%" or first_name LIKE "U%";

select A1.*, fa.film_id From (Select a1.actor_id, a1.first_name, a1.last_name FROM actor a1, actor a2 WHERE a1.first_name=a2.first_name) as A1 
inner join film_actor fa USING (actor_id)
group by actor_id, film_id;

Select a1.actor_id, a1.first_name, a1.last_name FROM actor a1, actor a2 where a1.first_name = a2.first_name ;

select * from actor;
