/*
Query 2:
How many family-friendly rentals occur before 8:00pm, and how many occur
after? What about non-family friendly rentals?
*/

SELECT rental_day_part.day_part,
       COUNT(rental_day_part.family_friendly) AS family_friendly,
       COUNT(rental_day_part.non_family_friendly) AS non_family_friendly
  FROM
      (SELECT CASE
              WHEN category.name IN ('Animation', 'Children', 'Classics',
                                     'Comedy', 'Family', 'Music')
                                 THEN 'Family-Friendly'
               END AS family_friendly,

              CASE
              WHEN category.name NOT IN ('Animation', 'Children',
                                         'Classics', 'Comedy','Family',
                                         'Music')
                                 THEN 'Non-Family-Friendly'
               END AS non_family_friendly,

              CASE
              WHEN DATE_PART('hour', rental.rental_date) < 20 THEN 'Early'
              ELSE 'Late'
               END AS day_part,

              rental.rental_id AS rentals
         FROM category
         JOIN film_category
           ON category.category_id = film_category.category_id
         JOIN inventory
           ON film_category.film_id = inventory.film_id
         JOIN rental
           ON inventory.inventory_id = rental.inventory_id) AS rental_day_part
 GROUP BY 1
 ORDER BY 1;
