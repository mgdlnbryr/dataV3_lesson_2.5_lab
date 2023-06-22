USE sakila;

-- 1. Select all the actors with the first name ‘Scarlett’.

SELECT * from sakila.actor 
WHERE (first_name = "SCARLETT");

-- 2. How many physical copies of movies are available for rent in the store's inventory? How many unique movie titles are available?

SELECT count(inventory_id) from sakila.inventory;
SELECT count(distinct(film_id)) FROM sakila.inventory;

-- 3. What are the shortest and longest movie duration? Name the values max_duration and min_duration.

SELECT MAX(length) as max_duration, MIN(length) as min_duration FROM sakila.film;

-- 4. What's the average movie duration expressed in format (hours, minutes)?
 
SELECT
    CONCAT(
        CONVERT(FLOOR(AVG(length) / 60), UNSIGNED), 
        'h ',
        CONVERT(AVG(length) % 60, UNSIGNED), 
        'm'
    ) AS average_duration
FROM
    sakila.film;
    
-- 5. How many distinct (different) actors' last names are there?

SELECT count(distinct(last_name)) FROM sakila.actor; 

-- 6. How many days was the company operating? Assume the last rental date was their closing date. (check DATEDIFF() function)

SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days FROM sakila.rental;

-- 7. Show rental info with additional columns month and weekday. Get 20 results.

SELECT rental_id, rental_date, date_format(CONVERT(left(rental_date,10),date), '%M') AS 'issued_month', DAYNAME(rental_date) as 'weekday' FROM sakila.rental LIMIT 20;

-- 8. Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.

SELECT
    rental_id,
    rental_date,
    DATE_FORMAT(CONVERT(LEFT(rental_date, 10), DATE), '%M') AS 'issued_month',
    DAYNAME(rental_date) AS 'weekday',
    CASE WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend' ELSE 'workday' END AS 'day_type'
FROM
    sakila.rental;

-- 9. Get release years.

SELECT release_year from sakila.film;

-- 10. Get all films with ARMAGEDDON in the title.

SELECT * FROM sakila.film
WHERE title LIKE "%ARMAGEDDON%";

-- 11. Get all films which title ends with APOLLO.

SELECT * FROM sakila.film
WHERE title LIKE "%APOLLO";

-- 12. Get 10 the longest films.

SELECT * from sakila.film
ORDER BY length DESC
LIMIT 10;

-- 13. How many films include Behind the Scenes content?

SELECT * FROM sakila.film
WHERE special_features LIKE "%Behind the Scenes%";