

# 1) All films with PG-13 films with rental rate of 2.99 or lower

select * from film as f
where f.rental_rate<= 2.99 and f.rating='PG-13';	


# 2) All films that have deleted scenes

SELECT f.title,f.special_features,f.release_year
from film as f
where f.special_features like '%Deleted Scenes%' and f.title like 'c%';


# 3) All active customers
select count(c.customer_id),c.active
 from customer as c
where active=1 ;

# 4) Names of customers who rented a movie on 26th July 2005

select r.rental_id,r.rental_date,r.customer_id,
       concat(c.first_name,' ',c.last_name) as "Full name"
 from rental as r
join customer as c on c.customer_id=r.customer_id
where date(r.rental_date)= '2005-7-26';


# 5) Distinct names of customers who rented a movie on 26th July 2005
select distinct r.customer_id,
       concat(c.first_name,' ',c.last_name) as "Full name"
 from rental as r
join customer as c on c.customer_id=r.customer_id
where date(r.rental_date)= '2005-7-26';


# 6) How many rentals we do on each day?

select date(rental_date) as "Date",count(*) as rental_count
from rental
group by date(rental_date)
order by rental_count desc
limit 1;


# 7) All Sci-fi films in our catalogue

select fc.film_id,fc.category_id,c.name,f.title,f.release_year
from film_category as fc 
join category as c on c.category_id= fc.category_id
join film as f on f.film_id = fc.film_id
where c.name = "Sci-Fi";

# 8) Customers and how many movies they rented from us so far?

select r.customer_id,c.first_name,c.email,count(*) as "count"
from rental as r
join customer as c on c.customer_id= r.customer_id
group by c.customer_id 
order by count(*) desc;

# 9) Which movies should we discontinue from our catalogue (less than 1 lifetime rentals)

with low_rentals as 
    (select inventory_id,count(*)
    from rental as r
	group by inventory_id
    having count(*) <= 1)
    select low_rentals.inventory_id,i.film_id,f.title,f.release_year
    from low_rentals 
    join inventory as i on i.inventory_id= low_rentals.inventory_id
    join film as f on f.film_id = i.film_id;
  
# 10) Which movies are not returned yet?

select rental_date,customer_id,i.film_id,f.title
from rental as r
join inventory as i on i.inventory_id = r.inventory_id
join film as f on f.film_id = i.film_id
where r.return_date is null
order by f.title;



#BONUS - 
# 11) How many distinct last names we have in the data?
select count(distinct c.last_name) as "Distinct Last Name"
 from customer as c;




