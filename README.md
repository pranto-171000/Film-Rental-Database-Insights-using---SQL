# Film-Rental-Database-Insights-using---SQL

## Project Overview

**Project Title**: Film Rental Analysis
**Level**: Intermediate
**Database**: ` sakila`

This project focuses on exploring a film rental database and leveraging SQL queries to extract insights related to film rentals, customer activity, and overall business performance. The objective is to demonstrate data analysis skills by querying the Sakila database to answer key business questions about film rentals, customers, and trends.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. ***All films with PG-13 films with rental rate of 2.99 or lower:***
```sql
select * from film as f
where f.rental_rate<= 2.99 and f.rating='PG-13';	
```

2.***All films that have deleted scenes:***
```sql
SELECT f.title,f.special_features,f.release_year
from film as f
where f.special_features like '%Deleted Scenes%' and f.title like 'c%';
```

3.***All active customers:***
```sql
select count(c.customer_id),c.active from customer as c
where active=1 ;
```

4.***Names of customers who rented a movie on 26th July 2005:***
```sql
select r.rental_id,r.rental_date,r.customer_id, concat(c.first_name,' ',c.last_name) as "Full name"
 from rental as r
join customer as c on c.customer_id=r.customer_id
where date(r.rental_date)= '2005-7-26';
```

5. ***Distinct names of customers who rented a movie on 26th July 2005***:
```sql
select distinct r.customer_id,
       concat(c.first_name,' ',c.last_name) as "Full name"
 from rental as r
join customer as c on c.customer_id=r.customer_id
where date(r.rental_date)= '2005-7-26';
```

6. ***How many rentals we do on each day?***
```sql
select date(rental_date) as "Date",count(*) as rental_count
from rental
group by date(rental_date)
order by rental_count desc
limit 1;
```

7. ***All Sci-fi films in our catalogue***:
```sql
select fc.film_id,fc.category_id,c.name,f.title,f.release_year
from film_category as fc 
join category as c on c.category_id= fc.category_id
join film as f on f.film_id = fc.film_id
where c.name = "Sci-Fi";
```

8. ***Customers and how many movies they rented from us so far?***:
```sql
select r.customer_id,c.first_name,c.email,count(*) as "count"
from rental as r
join customer as c on c.customer_id= r.customer_id
group by c.customer_id 
order by count(*) desc;
```

9. ***Which movies should we discontinue from our catalogue (less than 1 lifetime rentals***:
```sql
with low_rentals as 
    (select inventory_id,count(*)
    from rental as r
	group by inventory_id
    having count(*) <= 1)
    select low_rentals.inventory_id,i.film_id,f.title,f.release_year
    from low_rentals 
    join inventory as i on i.inventory_id= low_rentals.inventory_id
    join film as f on f.film_id = i.film_id;
```

10. ***Which movies are not returned yet?***:
```sql
select rental_date,customer_id,i.film_id,f.title
from rental as r
join inventory as i on i.inventory_id = r.inventory_id
join film as f on f.film_id = i.film_id
where r.return_date is null
order by f.title;
```

## Findings

- ** PG-13 Film Rentals **: A subset of films with a rental rate of 2.99 or lower proves to be popular among customers.
- ** Special Features **: Many films with deleted scenes show a particular pattern in rental behavior, especially for certain titles starting with "C".
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- ** Customer Activity **: The active customer base is significant, with some customers having rented multiple films over time.
-**Top Rental Dates**: Peak rental dates, such as 26th July 2005, show spikes in customer engagement, which can help plan for future promotions or inventory stocking.
-** Sci-Fi Popularity**: Sci-Fi films show consistent demand, making it a key category for continued investment.
- **Underperforming Films**: A number of films with fewer than 1 rental indicate potential candidates for discontinuation or re-promotion.
-**Unreturned Movies**: There is a notable number of films still not returned, suggesting potential customer behavior insights or loss tracking.
## Reports

-**Film and Rental Performance**: A detailed summary report identifying the most and least rented films, categorized by genre and rental rate.
-** Customer Activity Report**: Insights on customer activity, including who rented the most films and how many rentals were made on specific dates.
-** Low-Rentals Analysis**: A report identifying films with the fewest rentals, highlighting those that may not be worth maintaining in the inventory.
-** Unreturned Films Report**: A list of films that have not been returned, aiding in loss prevention or policy enforcement.

## Conclusion

This project demonstrates the application of SQL for business intelligence and decision-making in the context of a film rental business. By analyzing customer behavior, rental patterns, and film popularity, the findings offer actionable insights for business strategies such as film promotion, inventory management, and customer retention. The ability to perform such analyses is critical for data-driven decisions in a dynamic retail environment.



