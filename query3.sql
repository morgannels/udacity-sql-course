/*
Query 3:
Which films have been returned late most often?
*/

WITH film_rental_duration AS (SELECT film.film_id,
                                     DATE_PART('day',
                                               rental.return_date -
                                               rental.rental_date)
                                       AS rental_duration
                                FROM rental
                                JOIN inventory
                                  ON rental.inventory_id =
                                       inventory.inventory_id
                                JOIN film
                                  ON inventory.film_id = film.film_id)

SELECT film.title,
       COUNT(*) AS overdue_count
  FROM film_rental_duration
  JOIN film
    ON film_rental_duration.film_id = film.film_id
 WHERE film_rental_duration.rental_duration > film.rental_duration
 GROUP BY 1
 ORDER BY 2 DESC, 1
 LIMIT 10;
