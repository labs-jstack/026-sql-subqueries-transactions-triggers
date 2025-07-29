\c live026

SELECT 
    customers.*, 
    SUM(orders.amount) AS total_spent 
FROM customers
LEFT JOIN orders ON orders.customer_id = customers.id
GROUP BY customers.id
HAVING SUM(orders.amount) > (SELECT AVG(amount) FROM orders)
ORDER BY customers.id
;
