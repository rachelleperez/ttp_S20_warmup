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
WITH customer_totals as ( --start of CTE
SELECT SUM(amount) as total 
FROM payment 
GROUP BY customer_id) --end of CTE
SELECT AVG(total)
FROM customer_totals;

-- YOUR TURN: what is the average of the amount of stock each store has in their inventory? (Use inventory table)

-- YOUR TURN: What is the average customer lifetime spending, for each staff member?
-- HINT: you can work off the example

--YOUR TURN: 
--What is the average number of films we have per genre (category)?