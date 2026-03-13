/*
 * List the title of all movies that have both the 'Behind the Scenes' and the 'Trailers' special_feature
 *
 * HINT:
 * Create a select statement that lists the titles of all tables with the 'Behind the Scenes' special_feature.
 * Create a select statement that lists the titles of all tables with the 'Trailers' special_feature.
 * Inner join the queries above.
 */
SELECT title
FROM (
    SELECT film_id
    FROM film, unnest(special_features) AS special_feature
    WHERE special_feature = 'Behind the Scenes'
) AS behind_scenes
JOIN (
    SELECT film_id
    FROM film, unnest(special_features) AS special_feature
    WHERE special_feature = 'Trailers'
) AS trailers
USING (film_id)
JOIN film USING (film_id)
ORDER BY title;
