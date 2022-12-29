use mavenmovies;

/*
1.	We will need a list of all staff members, including their first and last names, 
email addresses, and the store identification number where they work. 
*/ 
SELECT 
		first_name,
        last_name,
        email,
        store_id
FROM staff;


/*
2.	We will need separate counts of inventory items held at each of your two stores. 
*/ 

-- 1st approach
SELECT 
		COUNT(CASE WHEN store_id=1 THEN inventory_id ELSE NULL END) AS inventory_in_store1,
		COUNT(CASE WHEN store_id=2 THEN inventory_id ELSE NULL END) AS inventory_in_store2
FROM inventory;

-- 2nd approach 
SELECT 
		store_id,
        COUNT(inventory_id) AS inventories
FROM inventory
GROUP BY store_id;



/*
3.	We will need a count of active customers for each of your stores. Separately, please. 
*/
-- 1st approach
SELECT 
		COUNT(CASE WHEN store_id=1 AND active=1 THEN customer_id ELSE NULL END) AS active_number_of_customers_in_store1,
		COUNT(CASE WHEN store_id=2 AND active=1 THEN customer_id ELSE NULL END) AS active_number_of_customers_in_store2
FROM customer;

-- 2nd approach 
SELECT 
		store_id,
        COUNT(customer_id) AS number_of_active_customers
FROM customer
WHERE active=1
GROUP BY store_id;




/*
4.	In order to assess the liability of a data breach, we will need you to provide a count 
of all customer email addresses stored in the database. 
*/

SELECT COUNT(DISTINCT(email)) FROM customer;


/*
5.	We are interested in how diverse your film offering is as a means of understanding how likely 
you are to keep customers engaged in the future. Please provide a count of unique film titles 
you have in inventory at each store and then provide a count of the unique categories of films you provide. 
*/

-- SELECT COUNT(DISTINCT(title)) FROM film;  (Wrong query. This did not give desired output)

SELECT
		store_id,
        COUNT(DISTINCT(film_id)) AS unique_film_titles
FROM inventory
GROUP BY store_id;

SELECT 
		COUNT(DISTINCT(name)) AS unique_categories 
FROM category;




/*
6.	We would like to understand the replacement cost of your films. 
Please provide the replacement cost for the film that is least expensive to replace, 
the most expensive to replace, and the average of all films you carry. ``	
*/

SELECT 
		MIN(replacement_cost) AS least_expensive_to_replace,
        MAX(replacement_cost) AS most_expensive_to_replace,
        AVG(replacement_cost) AS average_cost_to_replace
FROM film;





/*
7.	We are interested in having you put payment monitoring systems and maximum payment 
processing restrictions in place in order to minimize the future risk of fraud by your staff. 
Please provide the average payment you process, as well as the maximum payment you have processed.
*/

SELECT 
		AVG(amount) AS average_payment,
        MAX(amount) AS maximum_payment
FROM payment;



/*
8.	We would like to better understand what your customer base looks like. 
Please provide a list of all customer identification values, with a count of rentals 
they have made all-time, with your highest volume customers at the top of the list.
*/
	SELECT
			customer.customer_id, first_name,
            COUNT(rental_id) AS number_of_rentals
	FROM rental
    INNER JOIN customer
    ON customer.customer_id=rental.customer_id
    GROUP BY customer.customer_id
    ORDER BY COUNT(rental_id) DESC


/* 
9. My partner and I want to come by each of the stores in person and meet the managers. 
Please send over the managers’ names at each store, with the full address 
of each property (street address, district, city, and country please).  
*/ 
SELECT * FROM staff;
SELECT * FROM store;

SELECT 
		store.store_id, manager_staff_id, first_name, last_name, address, district, city, country
FROM staff
INNER JOIN store
ON staff.store_id=store.store_id
INNER JOIN address
ON address.address_id=store.address_id
INNER JOIN city
ON address.city_id=city.city_id
INNER JOIN country
ON city.country_id=country.country_id;


	
/*
10.	I would like to get a better understanding of all of the inventory that would come along with the business. 
Please pull together a list of each inventory item you have stocked, including the store_id number, 
the inventory_id, the name of the film, the film’s rating, its rental rate and replacement cost. 
*/

SELECT 
		inventory_id, film.film_id, store_id, title, rating, rental_rate, replacement_cost
FROM inventory
LEFT JOIN film
ON inventory.film_id=film.film_id;


SELECT 
		inventory_id, film.film_id, store_id, title, rating, rental_rate, replacement_cost
FROM inventory
INNER JOIN film
ON inventory.film_id=film.film_id;




/* 
11.	From the same list of films you just pulled, please roll that data up and provide a summary level overview 
of your inventory. We would like to know how many inventory items you have with each rating at each store. 
*/

SELECT 
		rating, store_id, COUNT(inventory_id) AS number_of_inventories
FROM inventory
INNER JOIN film
ON inventory.film_id=film.film_id
GROUP BY rating, store_id;




/* 
12. Similarly, we want to understand how diversified the inventory is in terms of replacement cost. We want to 
see how big of a hit it would be if a certain category of film became unpopular at a certain store.
We would like to see the number of films, as well as the average replacement cost, and total replacement cost, 
sliced by store and film category. 
*/ 

SELECT 
		store_id,category.name, 
        COUNT(film.film_id) AS number_of_films,
        AVG(replacement_cost) AS average_replacement_cost,
        SUM(replacement_cost) AS total_replacement_cost
FROM film
INNER JOIN film_category
ON film.film_id=film_category.film_id
INNER JOIN category
ON film_category.category_id=category.category_id
INNER JOIN inventory
ON inventory.film_id=film.film_id
GROUP BY store_id,category.name;



/*
13.	We want to make sure you folks have a good handle on who your customers are. Please provide a list 
of all customer names, which store they go to, whether or not they are currently active, 
and their full addresses – street address, city, and country. 
*/

SELECT 
		first_name, last_name, store_id, address, district, city, country
FROM customer
INNER JOIN address
ON customer.address_id=address.address_id
INNER JOIN city
ON address.city_id=city.city_id
INNER JOIN country
ON city.country_id=country.country_id;



/*
14.	We would like to understand how much your customers are spending with you, and also to know 
who your most valuable customers are. Please pull together a list of customer names, their total 
lifetime rentals, and the sum of all payments you have collected from them. It would be great to 
see this ordered on total lifetime value, with the most valuable customers at the top of the list. 
*/


SELECT
		first_name, last_name,
        SUM(amount) AS sum_of_all_payments,
        COUNT(rental.rental_id) AS total_lifetime_rentals
FROM customer
INNER JOIN rental
ON customer.customer_id=rental.customer_id
INNER JOIN payment
ON payment.rental_id=rental.rental_id
GROUP BY first_name,last_name;




    
/*
15. My partner and I would like to get to know your board of advisors and any current investors.
Could you please provide a list of advisor and investor names in one table? 
Could you please note whether they are an investor or an advisor, and for the investors, 
it would be good to include which company they work with. 
*/

SELECT 
		'advisor' AS TYPE,
        first_name,
        last_name,
        'NA' AS company_name
FROM advisor
UNION
SELECT 
		'investor' AS TYPE,
        first_name,
        last_name,
        company_name
FROM investor;





/*
16. To find number of awards each actor has recieved
*/

-- Approach 1
select distinct AA.first_name,AA.last_name , '1' AS 'no of awards' from actor_award AA
inner join  film_actor FA
on AA.actor_id=FA.actor_id
where awards not like '%,%'
UNION 
select distinct AA.first_name,AA.last_name , '2' AS 'no of awards' from actor_award AA
inner join  film_actor FA
on AA.actor_id=FA.actor_id
where awards  like '%,%' AND awards not like '%,%,%'
UNION 
select distinct AA.first_name,AA.last_name , '3' AS 'no of awards' from actor_award AA
inner join  film_actor FA
on AA.actor_id=FA.actor_id
where awards like '%,%,%';


-- Approach 2
select distinct AA.first_name,AA.last_name , 
CASE 
	WHEN awards not like '%,%' THEN '1'
	WHEN awards  like '%,%' AND awards not like '%,%,%' THEN '2'
    WHEN awards like '%,%,%' THEN '3'
    ELSE 'error in code'
END AS 'no of awards'
from actor_award AA
inner join  film_actor FA
on AA.actor_id=FA.actor_id;

