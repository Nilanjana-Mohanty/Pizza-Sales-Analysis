-- 1. Creating a database of pizzadata
-- 2. Creating 4 tables
-- 3. Importing the table data from csv file

-- 4. Selecting all data or viewing the data
-- SELECT * FROM pizzas
-- SELECT * FROM pizza_types
-- SELECT * FROM orders
-- SELECT * FROM order_details

-- QUESTIONS
-- 1. Retrieve the total number of orders placed
-- SELECT count(order_id) AS total_orders FROM orders

-- 2. Calculate total revenue generated from pizza sales
-- So in order_details we have the pizzas sold & in pizzas we have prices
-- of all the pizzas available, order_id is common in both table
-- So we use joins here
-- SELECT 
-- SUM(order_details.quantity * pizzas.price) as total_revenue
-- FROM order_details JOIN pizzas
-- ON order_details.pizza_id = pizzas.pizza_id

-- 3. Identify the highest priced pizzz
-- SELECT p.name, c.price
-- FROM pizza_types AS p
-- JOIN pizzas as c
-- ON p.pizza_type_id = c.pizza_type_id
-- ORDER BY c.price DESC
-- LIMIT 1

-- SELECT pizza_types.name , pizzas.price
-- FROM pizza_types JOIN pizzas
-- ON pizza_types.pizza_type_id = pizzas.pizza_type_id
-- ORDER BY pizzas.price DESC 
-- LIMIT 1

-- 4. Identify the most common pizza size ordered.
-- SELECT quantity, count(order_details_id)
-- from order_details GROUP BY quantity

-- SELECT p.size, count(o.order_details_id) as order_count
-- FROM pizzas as p
-- JOIN order_details as o
-- ON p.pizza_id = o.pizza_id
-- GROUP BY p.size
-- ORDER BY order_count DESC
-- LIMIT 1

-- To join p & o
-- SELECT *
-- FROM pizzas as p
-- JOIN order_details as o
-- ON p.pizza_id = o.pizza_id

-- if there is count we have to use group by clause
-- if we use LIMIT 1 then that will give us the highest order size
-- here we look for repeat orders, most common means reoeat order
-- so most common order we use count

-- 5.List the top 5 most ordered pizza types 
-- along with their quantities.
-- SELECT pizza_types.name,
-- SUM(order_details.quantity) as quantity_ordered
-- FROM pizza_types JOIN pizzas
-- ON pizza_types.pizza_type_id = pizzas.pizza_type_id
-- JOIN order_details
-- ON order_details.pizza_id = pizzas.pizza_id
-- GROUP BY pizza_types.name
-- ORDER BY quantity_ordered DESC
-- -- LIMIT 5

-- 6. Join the necessary tables to find the 
-- total quantity of each pizza category ordered
-- SELECT p.category , sum(o.quantity) as order_quantity
-- FROM pizza_types as p
-- JOIN pizzas as pi
-- ON p.pizza_type_id = pi.pizza_type_id
-- JOIN order_details as o
-- ON o.pizza_id = pi.pizza_id
-- GROUP BY p.category
-- ORDER BY order_quantity DESC
-- According to the output classic pizzais ordered the most

-- 7. Join relevant tables to 
-- find the category-wise distribution of pizzas.
-- to find how many pizzas are their in each category
-- SELECT category, COUNT(name) FROM pizza_types
-- GROUP BY category

-- 8. Group the orders by date and calculate the 
-- average number of pizzas ordered per day.
-- SELECT ROUND(avg(quantity),2) FROM
-- (SELECT o.date, SUM(od.quantity) as quantity
-- FROM orders AS o
-- JOIN order_details AS od
-- ON o.order_id = od.order_id
-- GROUP BY o.date) AS order_quantity

-- 9. Determine the top 3 most ordered
-- pizza types based on revenue.
-- SELECT pt.name , 
-- SUM(o.quantity * p.price) AS revenue
-- FROM pizza_types AS pt
-- JOIN pizzas AS p 
-- ON pt.pizza_type_id = p.pizza_type_id
-- JOIN order_details AS o
-- ON o.pizza_id = p.pizza_id
-- GROUP BY pt.name
-- ORDER BY revenue DESC
-- LIMIT 3

--10.To Calculate the percentage contribution of 
-- each pizza type to total revenue.
-- SELECT pt.category , 
-- (SUM(o.quantity * p.price)) / (SELECT 
-- SUM(o.quantity * p.price) as total_revenue
-- FROM order_details AS o
-- JOIN pizzas as p
-- ON o.pizza_id = p.pizza_id) * 100 as revenue
-- FROM pizza_types AS pt
-- JOIN pizzas AS p
-- ON pt.pizza_type_id = p.pizza_type_id
-- JOIN order_details AS o
-- ON o.pizza_id = p.pizza_id
-- GROUP BY pt.category
-- ORDER BY revenue DESC

-- 11. Analyze the cumulative revenue generated over time.
-- SELECT date,
-- SUM(revenue) OVER(order by date) AS cummulative_revenue
-- FROM 
-- (SELECT o.date,
-- SUM(od.quantity * p.price) AS revenue
-- FROM order_details AS od
-- JOIN pizzas AS p
-- ON od.pizza_id = p.pizza_id
-- JOIN orders AS o
-- ON o.order_id = od.order_id
-- GROUP BY o.date) AS sales
