-- Retrieve the total number of orders placed.
SELECT 
    COUNT(order_id)
FROM
    orders;

-- Calculate the total revenue generated from pizza sales.
SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS total_revenue
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id;

-- Identify the highest-priced pizza name.
SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY 2 DESC
LIMIT 1;

-- Identify the most common pizza size ordered.
SELECT 
    pizzas.size, SUM(order_details.quantity)
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizzas.size
ORDER BY 2 DESC
LIMIT 1;

-- List the top 5 most ordered pizza types along with their quantities.
SELECT 
    pizza_types.name,
    SUM(order_details.quantity) AS mostly_sold_pizzas
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
        JOIN
    pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY pizza_types.name
ORDER BY 2 DESC
LIMIT 5;

-- Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT 
    pizza_types.category,
    SUM(order_details.quantity) AS mostly_sold_pizzas
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
        JOIN
    pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY pizza_types.category
ORDER BY 2 DESC;

-- Determine the distribution of orders by hour of the day.
# indicates in which hour of the day most of the customers coming to the store
SELECT 
    HOUR(time) hours, COUNT(order_id) AS number_of_orders
FROM
    orders
GROUP BY hours
ORDER BY 2 DESC;

-- Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT 
    ROUND(AVG(orders_per_day), 0)
FROM
    (SELECT 
        orders.date, SUM(order_details.quantity) AS orders_per_day
    FROM
        orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY orders.date) AS avg_orders;
    
-- Determine the top 3 most ordered pizza types based on revenue
   SELECT 
    pizza_types.pizza_type_id,
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS total_revenue
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
        JOIN
    pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id
GROUP BY pizza_types.pizza_type_id
ORDER BY 2 DESC
limit 3;

-- Calculate the percentage contribution of each pizza category to total revenue.
SELECT 
    pizza_types.category,
    SUM(order_details.quantity * pizzas.price) / (SELECT 
            ROUND(SUM(order_details.quantity * pizzas.price),
                        2) AS total_revenue
        FROM
            order_details
                JOIN
            pizzas ON order_details.pizza_id = pizzas.pizza_id) * 100 AS revenue
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
        JOIN
    pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id
GROUP BY pizza_types.category;

-- Analyze the cumulative revenue generated over time.
with revenue_day as (select orders.date as dates, sum(order_details.quantity * pizzas.price) revenue
from orders
join order_details
on orders.order_id=order_details.order_id
join pizzas
on order_details.pizza_id=pizzas.pizza_id
group by orders.date)

select  dates,round(revenue,2), round(sum(revenue) over (order by dates),2) over_time_revenue
from revenue_day;

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.
SELECT 
    pizza_types.category,
    SUM(order_details.quantity * pizzas.price) / (SELECT 
            ROUND(SUM(order_details.quantity * pizzas.price),
                        2) AS total_revenue
        FROM
            order_details
                JOIN
            pizzas ON order_details.pizza_id = pizzas.pizza_id) * 100 AS revenue
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
        JOIN
    pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id
GROUP BY pizza_types.category
order by 2 desc
limit 3;

