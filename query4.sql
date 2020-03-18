/*
Query 4:
How many times are films rented by decile?
*/

SELECT film_rental_decile.decile,
       SUM(film_rental_decile.rental_count) AS total_rentals
  FROM
      (SELECT NTILE(10) OVER (ORDER BY film_rental_count.rental_count)
                AS decile,
              film_rental_count.rental_count AS rental_count
        FROM
            (SELECT film.film_id,
                    COUNT(rental.rental_id) AS rental_count
               FROM film
               JOIN inventory
                 ON film.film_id = inventory.film_id
               JOIN rental
                 ON inventory.inventory_id = rental.inventory_id
              GROUP BY 1)
             AS film_rental_count)
       AS film_rental_decile
 GROUP BY 1
 ORDER BY 1;
