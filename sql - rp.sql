-- Another clever use of SUBQUERIES

-- EXAMPLE: What is the average customer lifetime spending?
-- Does this work?

SELECT AVG(SUM(amount))
FROM payment
GROUP BY customer_id; --NOPE! "ERROR:  aggregate function calls cannot be nested"

--TRY THIS
SELECT AVG(total)
FROM (SELECT SUM(amount) as total 
	  FROM payment 
	  GROUP BY customer_id) as customer_totals; --NICE! 
-- IMPORTANT! NOTICE THE ALIAS AT THE END. THIS IS NECESSARY WHEN THE SUBQUERY
-- IS IN THE FROM CLAUSE


--OR do the above with a CTE:

WITH customer_totals as (

    SELECT SUM(amount) as total 
    FROM payment 
    GROUP BY customer_id
    )

SELECT AVG(total)
FROM customer_totals;

-- YOUR TURN: what is the average of the amount of stock each store has in their inventory? (Use inventory table)

With total_inventory_by_store AS (
    SELECT 
        store_id, 
        COUNT(film_id) AS store_inventory_count
    FROM inventory
    GROUP BY store_id
)
SELECT AVG(store_inventory_count)
FROM total_inventory_by_store;


          avg
-----------------------
 2290.5000000000000000
(1 row)



-- YOUR TURN: What is the average customer lifetime spending, for each staff member?
-- HINT: you can work off the example


WITH total_spent_per_customer AS (
    SELECT
        customer_id,
        SUM(amount) as total_spent
    FROM
        payment
    GROUP BY
        customer_id
    ORDER BY
        customer_id
)

SELECT
    AVG(total_spent)
FROM
    total_spent_per_customer;


         avg
----------------------
 102.3573288814691152
(1 row)


--YOUR TURN: 
--What is the average number of films we have per genre (category)?


WITH film_count_per_category AS (
    SELECT
        category_id,
        COUNT(film_id) as film_count
    FROM
        film_category
    GROUP BY
        category_id
    ORDER BY
        category_id
)

SELECT
    AVG(film_count)
FROM
    film_count_per_category;


         avg
---------------------
 62.5000000000000000
(1 row)

