/*
Query 1:
To review pricing, what is the average number of rentals per film
for each rental rate?
*/

SELECT film.rental_rate,
       ROUND(COUNT(rental.rental_id) / COUNT(DISTINCT film.film_id))
         AS per_film_rental_count
  FROM film
  JOIN inventory
    ON film.film_id = inventory.film_id
  JOIN rental
    ON inventory.inventory_id = rental.inventory_id
 GROUP BY 1
 ORDER BY 1;
