/*
 * Create a report that shows the total revenue per month and year.
 *
 * HINT:
 * This query is very similar to the previous problem,
 * but requires an additional JOIN.
 */
SELECT date_part('year', rental_date) AS "Year",
       date_part('month', rental_date) AS "Month",
       sum(amount) AS "Total Revenue"
FROM rental
JOIN payment USING (rental_id)
GROUP BY ROLLUP("Year", "Month")
ORDER BY "Year", "Month";
