# Project---Pizza_sales
### A Project work to showcase my in_hand experience and knowlwdge about SQL. I have used MySQL DBMS to perform my task and run all the quesries. Here this project depicts all about the sales of a Pizza selling company. EDA tasks performed to get all the data of sales which can help the company detect patterns in it and improve their sales and customer engagements.
# Objectives
### Database - Create a databse withh all the given data
### Exploiratory Data Analysis(EDA) - Ran EDA queries to understand the data
### Business Analysis - Use SQL to answer specific business oriented questions and derive insights from the data
# Dataset Creation
### 1.order_details.csv
Contains data about the sold pizza quantities according to their IDs.
``` sql
CREATE TABLE `order_details` (
  `order_details_id` int DEFAULT NULL,
  `order_id` int DEFAULT NULL,
  `pizza_id` text,
  `quantity` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
```
### 2.orders.csv
Contain data of all the order`s date and time.
``` sql
CREATE TABLE `orders` (
  `order_id` int DEFAULT NULL,
  `date` text,
  `time` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
```
### pizza_types.csv
Contains all the types of pizzas available for selling wrt to their category.
``` sql
CREATE TABLE `pizza_types` (
  `pizza_type_id` text,
  `name` text,
  `category` text,
  `ingredients` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
```
### pizzas.csv
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
### Retrieve the total number of orders placed.
``` sql
SELECT 
    COUNT(order_id)
FROM
    orders;
```
