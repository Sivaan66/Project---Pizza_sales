# Project---Pizza_sales
### A Project work to showcase my in_hand experience and knowlwdge about SQL. I have used MySQL DBMS to perform my task and run all the quesries. Here this project depicts all about the sales of a Pizza selling company. EDA tasks performed to get all the data of sales which can help the company detect patterns in it and improve their sales and customer engagements.
# Objectives
### Database - Create a databse withh all the given data
### Exploiratory Data Analysis(EDA) - Run EDA queries to understand the data
### Business Analysis - Use SQL to answer specific business oriented questions and derive insights from the data
# Dataset Creation
### 1. order_details.csv
🔗 [Check the Full Dataset](./order_details.csv)
Contains data about the sold pizza quantities according to their IDs.
``` sql
CREATE TABLE `order_details` (
  `order_details_id` int DEFAULT NULL,
  `order_id` int DEFAULT NULL,
  `pizza_id` text,
  `quantity` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
```
### 2. orders.csv
🔗 [Check the Full Dataset](./orders.csv)
Contain data of all the order`s date and time.
``` sql
CREATE TABLE `orders` (
  `order_id` int DEFAULT NULL,
  `date` text,
  `time` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
```
### 3. pizza_types.csv
🔗 [Check the Full Dataset](./pizza_types.csv)
Contains all the types of pizzas available for selling wrt to their category.
``` sql
CREATE TABLE `pizza_types` (
  `pizza_type_id` text,
  `name` text,
  `category` text,
  `ingredients` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
```
### 4. pizzas.csv
🔗 [Check the Full Dataset](./pizzas.csv)
contains size and price of pizzas.
``` sql
CREATE TABLE `pizzas` (
  `pizza_id` text,
  `pizza_type_id` text,
  `size` text,
  `price` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
```

# Questions And Queries
### 1.Retrieve the total number of orders placed.
🔗 [Check the Full Dataset](./1.csv)
It will give the data of overall orders that placed in the whole dataset.
``` sql
SELECT 
    COUNT(order_id)
FROM
    orders;
```
### 2.Calculate the total revenue generated from pizza sales.
🔗 [Check the Full Dataset](./2.csv)
All tptal revenue generated fromm all the orders placed.
``` sql
SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS total_revenue
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id;
``` 
### 3.Identify the highest-priced pizza name.
It will give the name of highest priced pizza from the dataset.
🔗 [Check the Full Dataset](./3.csv)
``` sql
SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY 2 DESC
LIMIT 1;
``` 
### 4.Identify the most common pizza size ordered.
🔗 [Check the Full Dataset](./4.csv)
Knowing most common sized pizza orderd can give some insights to generate more pizza sales.
``` sql
SELECT 
    pizzas.size, SUM(order_details.quantity)
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizzas.size
ORDER BY 2 DESC
LIMIT 1;
``` 
### 5.List the top 5 most ordered pizza types along with their quantities.
🔗 [Check the Full Dataset](./5.csv)
Thiss tells the top five most loved pizza types that customers ordered. Knowing the size and type of loved pizzas will help boost the sales.
``` sql
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
```
### 6.Find the total quantity of each pizza category ordered.
🔗 [Check the Full Dataset](./6.csv)
It says the category of pizza orders the most i.e. If people love Classic, Chickesns, or anything else.
``` sql
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
```
### 7.Determine the distribution of orders by hour of the day.
🔗 [Check the Full Dataset](./7.csv)
Give the insights that in which time of the day most of the people come to order and eat pizzas.
``` sql
# indicates in which hour of the day most of the customers coming to the store
SELECT 
    HOUR(time) hours, COUNT(order_id) AS number_of_orders
FROM
    orders
GROUP BY hours
ORDER BY 2 DESC;
```
### 8.Group the orders by date and calculate the average number of pizzas ordered per day.
🔗 [Check the Full Dataset](./8.csv)
Knowing average number of pizzas orderd per day can help comparing our business  growth to other stores because it's not monopoly. 
``` sql
SELECT 
    ROUND(AVG(orders_per_day), 0)
FROM
    (SELECT 
        orders.date, SUM(order_details.quantity) AS orders_per_day
    FROM
        orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY orders.date) AS avg_orders;
```
### 9.Determine the top 3 most ordered pizza types based on revenue.
🔗 [Check the Full Dataset](./9.csv)
The top three pizza types generated more revenue.
``` sql
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
```
### 10.Calculate the percentage contribution of each pizza category to total revenue.
🔗 [Check the Full Dataset](./10.csv)
The ORDER OF Pizza categories according to their contribution towards total revenue.
``` sql
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
```
### 11.Analyze the cumulative revenue generated over time.
🔗 [Check the Full Dataset](./11.csv)
Cumulative revenue gives the data about linear growth of the company over time. This tells if company is growing over time or we need to do some changes according to the data evaluated.

``` sql
with revenue_day as (select orders.date as dates, sum(order_details.quantity * pizzas.price) revenue
from orders
join order_details
on orders.order_id=order_details.order_id
join pizzas
on order_details.pizza_id=pizzas.pizza_id
group by orders.date)

select  dates,round(revenue,2), round(sum(revenue) over (order by dates),2) over_time_revenue
from revenue_day;
```
### 12.Determine the top 3 most ordered pizza types based on revenue for each pizza category.
🔗 [Check the Full Dataset](./12.csv)
``` sql
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
```
