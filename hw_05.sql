USE hw03;
-- p01

SELECT order_details.* , (SELECT customer_id FROM orders WHERE order_details.order_id = orders.id) AS customer_id 
FROM order_details

-- p02

SELECT * 
FROM order_details
WHERE order_id IN (SELECT id FROM orders WHERE shipper_id = 3 );

-- p03

SELECT order_id , TRUNCATE(AVG(quantity), 2) as average_quantity
FROM(SELECT order_id, quantity FROM order_details WHERE quantity > 10) AS temporary_orders
GROUP BY order_id

-- p04

WITH temporary_orders AS (
SELECT order_id, quantity FROM order_details WHERE quantity > 10)
SELECT order_id , TRUNCATE(AVG(quantity), 2) as average_quantity
FROM temporary_orders
GROUP BY order_id

-- p05


SELECT * , TRUNCATE(order_function(quantity, 3), 2) 
AS devided_quantity  
FROM order_details ;



-- Function as separate 

DROP FUNCTION IF EXISTS order_function 

DELIMITER //

CREATE FUNCTION order_function (number_1 FLOAT, number_2 FLOAT)
RETURNS FLOAT
DETERMINISTIC
NO SQL 
BEGIN 
	DECLARE result FLOAT;
    IF number_2 = 0 
		THEN RETURN NULL;
    ELSE     
		SET result = number_1/number_2;
		RETURN result;
    END IF;    
END // 

DELIMITER ; 