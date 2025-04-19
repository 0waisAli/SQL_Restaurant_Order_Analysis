USE restaurant_db;

-- Exploring the Menu items table

-- Viewing the menu_items table
SELECT * 
FROM menu_items;

-- Find the number of items on the menu
SELECT COUNT(*) 
FROM menu_items;

-- What are the least and most expensive items on the menu?
SELECT * 
FROM menu_items
ORDER BY price
LIMIT 1;

SELECT * 
FROM menu_items
ORDER BY price DESC
LIMIT 1;

-- How many Italian dishes are on the menu?
SELECT COUNT(*) AS No_of_Italian_dishes 
FROM menu_items
WHERE category = 'Italian';

-- What are the least and most expensive Italian dishes on the menu?
SELECT * 
FROM menu_items
WHERE category = 'Italian'
ORDER BY price
LIMIT 1;

SELECT * FROM menu_items
WHERE category = 'Italian'
ORDER BY price DESC
LIMIT 1;

-- How many dishes are in each category
SELECT category, COUNT(*) AS No_of_dishes
FROM menu_items
GROUP BY category;

-- What is the average dish price within each category?
SELECT category, AVG(price) as Average_price
FROM menu_items
GROUP BY category;


-- Analyzing the Orders table

-- Viewing the order_details table
SELECT *
FROM order_details;

-- What is the date range of the table?
SELECT MIN(order_date) AS Start_date, MAX(order_date) AS End_date
FROM order_details;

-- How many orders were made within this date range?
SELECT COUNT(DISTINCT order_id)
FROM order_details;

-- How many items were ordered within this date range?
SELECT COUNT(*)
FROM order_details;

-- Which orders had the most number of items?
SELECT order_id, COUNT(item_id) AS no_of_items
FROM order_details
GROUP BY order_id
ORDER BY no_of_items DESC;

-- How many orders had more than X items?
SELECT COUNT(*) FROM

(SELECT order_id, COUNT(item_id) AS num_items
FROM order_details
GROUP BY order_id
HAVING num_items > 10) as No_of_orders;

-- Analyzing Cutomer Behavior

-- Combining menu_items and order_details tables into a single table
SELECT * FROM menu_items;
SELECT * FROM order_details;

SELECT *
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id;
    
-- What were the least and most ordered items? What categories were they in?
SELECT item_name, COUNT(order_details_id) AS no_of_purchases
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
GROUP BY item_name
LIMIT 1;

SELECT item_name, COUNT(order_details_id) AS no_of_purchases
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
GROUP BY item_name
ORDER BY no_of_purchases
LIMIT 1;

-- What were the top 5 orders that spent the most money?
SELECT order_id, SUM(price) AS total_spend
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
GROUP BY order_id
ORDER BY total_spend DESC
LIMIT 5;
    
-- View the details of the top 5 highest spend orders
SELECT order_id, SUM(price) AS total_spend
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
GROUP BY order_id
ORDER BY total_spend DESC
LIMIT 5;

-- View the details of the highest spend order. Which specific items were purchased?
SELECT category, COUNT(item_id) AS num_items
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
WHERE order_id IN (440, 2075, 1957, 330, 2675)
GROUP BY category;