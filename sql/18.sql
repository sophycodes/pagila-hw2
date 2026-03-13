/*
 * Compute the total revenue for each film.
 * The output should include another new column "revenue percent" that shows the percent of total revenue that comes from the current film and all previous films.
 * That is, the "revenue percent" column is 100*"total revenue"/sum(revenue)
 *
 * HINT:
 * The `to_char` function can be used to achieve the correct formatting of your percentage.
 * See: <https://www.postgresql.org/docs/current/functions-formatting.html#FUNCTIONS-FORMATTING-EXAMPLES-TABLE>
 */
SELECT rank, title, revenue, "total revenue",
       CASE
           WHEN 100.0 * "total revenue" / sum(revenue) OVER () >= 100
           THEN '100.00'
           ELSE to_char(100.0 * "total revenue" / sum(revenue) OVER (), 'FM00.00')
       END AS "percent revenue"
FROM (
    SELECT rank, title, film_id, revenue,
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
        ) AS t1
    ) AS t2
) AS t3
ORDER BY rank, film_id;
