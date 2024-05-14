USE sakila;

-- query 1
select co.country, count(*) as amount_cities 
from city ci inner join country co on co.country_id = ci.country_id
group by co.country_id order by co.country, co.country_id;

-- query 2
select co.country, count(*) as amount_cities 
from city ci inner join country co on co.country_id = ci.country_id
group by co.country_id having 10<amount_cities order by amount_cities desc;

-- query 3
select first_name,last_name,a.*, 
(select count(*) from rental r where r.customer_id=c.customer_id) as total_films_rented, 
(select sum(amount) from payment p where p.customer_id=c.customer_id) as total_money_spent 
from customer c inner join address a on c.address_id=a.address_id order by total_money_spent desc; 

-- query 4
select c.name,avg(length) as average_duration 
from category c inner join film_category fc on fc.category_id= c.category_id inner join film f on f.film_id=fc.film_id
group by c.name order by average_duration desc;

-- query 5
select rating, concat(sum(p.amount), ' USD') as sales
from film f inner join inventory i on i.film_id = f.film_id inner join rental r on r.inventory_id= i.inventory_id
inner join payment p on r.rental_id= p.rental_id
group by rating order by sales desc;