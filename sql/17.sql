/*
 * Compute the total revenue for each film.
 * The output should include another new column "total revenue" that shows the sum of all the revenue of all previous films.
 *
 * HINT:
 * My solution starts with the solution to problem 16 as a subquery.
 * Then I combine the SUM function with the OVER keyword to create a window function that computes the total.
 * You might find the following stackoverflow answer useful for figuring out the syntax:
 * <https://stackoverflow.com/a/5700744>.
 */
SELECT rank, title, revenue,
       sum(revenue) OVER (ORDER BY rank) AS "total revenue"
FROM (
    SELECT rank() OVER (ORDER BY revenue DESC) AS rank, title, film_id, revenue
    FROM (
        SELECT title, film_id, coalesce(sum(amount), 0.00) AS revenue
        FROM film
        LEFT JOIN inventory USING (film_id)
        LEFT JOIN rental USING (inventory_id)
        LEFT JOIN payment USING (rental_id)
        GROUP BY title, film_id
    ) AS inner_query
) AS subquery
ORDER BY rank, film_id;
