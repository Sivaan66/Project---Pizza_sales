# Project---Pizza_sales
### A Project work to showcase my in_hand experience and knowlwdge about SQL. I have used MySQL DBMS to perform my task and run all the quesries. Here this project depicts all about the sales of a Pizza selling company. EDA tasks performed to get all the data of sales which can help the company detect patterns in it and improve their sales and customer engagements.
# Objectives
## Database - Create a databse withh all the given data
## Exploiratory Data Analysis(EDA) - Ran EDA queries to understand the data
## Business Analysis - Use SQL to answer specific business oriented questions and derive insights from the data
# Dataset Creation
## order_details.csv
Contains data about the pizza quantities according to their IDs.
``` sql
CREATE TABLE `order_details` (
  `order_details_id` int DEFAULT NULL,
  `order_id` int DEFAULT NULL,
  `pizza_id` text,
  `quantity` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
```

## All The Queries
### Retrieve the total number of orders placed.
``` sql
SELECT 
    COUNT(order_id)
FROM
    orders;
```
