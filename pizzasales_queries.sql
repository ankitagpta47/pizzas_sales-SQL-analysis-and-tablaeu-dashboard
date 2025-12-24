
CREATE DATABASE pizzaDB;
USE pizzaDB;

SHOW tables;

Select * from pizza_sales;

# the total revenue

SELECT 
    ROUND(SUM(total_price), 0) AS Total_Revenue
FROM
    pizza_sales;

#average order value

SELECT 
    SUM(total_price) / COUNT(DISTINCT order_id) AS avg_order_value
FROM
    pizza_sales;
    
    
# total pizza sold

SELECT 
    SUM(quantity) AS total_pizza_sold
FROM
    pizza_sales;


#total orders

SELECT 
    COUNT(DISTINCT order_id) AS total_orders
FROM
    pizza_sales;


#average pizzas per order


SELECT 
    SUM(quantity) / COUNT(DISTINCT order_id) AS avg_pizzas_per_order
FROM
    pizza_sales;
    
    
-- daily trend by total orders 
    
    
SELECT order_day, total_orders
FROM (
  SELECT
    DAYNAME(order_date) AS order_day,
    COUNT(DISTINCT order_id) AS total_orders
  FROM pizza_sales
  GROUP BY order_day
) t
ORDER BY FIELD(order_day,
  'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'
);

-- Hourly trend by total pizza sold


SELECT 
    HOUR(order_time) AS order_hour,
    SUM(quantity) AS total_pizzas_sold
FROM
    pizza_sales
GROUP BY HOUR(order_time)
ORDER BY HOUR(order_time);



-- weekly trend for total order
SELECT
  YEAR(order_date) AS order_year,
  WEEK(order_date) AS order_week,
  COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY
  YEAR(order_date),
  WEEK(order_date)
ORDER BY
  order_year,
  order_week;



-- percentage of sales by pizza category

select pizza_category,  sum(total_price)*100 /(select sum(total_price) from pizza_sales) as sales_percentage
from pizza_sales
group by pizza_category;


-- percentage of sales by pizza size


SELECT 
    pizza_size,
    ROUND(SUM(total_price) * 100 / (SELECT 
                    SUM(total_price)
                FROM
                    pizza_sales),
            2) AS sales_percentage
FROM
    pizza_sales
GROUP BY pizza_size
ORDER BY sales_percentage DESC;

-- top 5 best sellers by revenue

SELECT 
    pizza_name, SUM(total_price) AS total_revenue
FROM
    pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue DESC
LIMIT 5;

-- bottom 5 best seller by revenue

SELECT 
    pizza_name, SUM(total_price) AS total_revenue
FROM
    pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue
LIMIT 5;

-- top 5 best seller by total quantity

SELECT 
    pizza_name, SUM(quantity) AS total_quantity
FROM
    pizza_sales
GROUP BY pizza_name
ORDER BY total_quantity desc
LIMIT 5;

-- Bottom 5 best seller by total quantity

SELECT 
    pizza_name, SUM(quantity) AS total_quantity
FROM
    pizza_sales
GROUP BY pizza_name
ORDER BY total_quantity
LIMIT 5;


-- top 5 best seller by total_order

SELECT 
    pizza_name, count(distinct order_id) AS total_order
FROM
    pizza_sales
GROUP BY pizza_name
ORDER BY total_order desc
LIMIT 5;

-- bottom 5 best seller by total_order

SELECT 
    pizza_name, count(distinct order_id) AS total_order
FROM
    pizza_sales
GROUP BY pizza_name
ORDER BY total_order
LIMIT 5;

ALTER TABLE pizza_sales
ADD COLUMN order_date_new DATE;


SET SQL_SAFE_UPDATES = 0;


UPDATE pizza_sales
SET order_date_new = STR_TO_DATE(order_date, '%m/%d/%Y');

SET SQL_SAFE_UPDATES = 1;

ALTER TABLE pizza_sales
DROP COLUMN order_date;

ALTER TABLE pizza_sales
CHANGE order_date_new order_date DATE;


DESCRIBE pizza_sales;


select order_date
from pizza_sales



