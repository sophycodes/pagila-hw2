/*
 * Compute the total revenue for each film.
 */
SELECT title, coalesce(sum(amount), 0.00) AS revenue
FROM film
LEFT JOIN inventory USING (film_id)
LEFT JOIN rental USING (inventory_id)
LEFT JOIN payment USING (rental_id)
GROUP BY title, film_id
ORDER BY revenue DESC, film_id;
