-- Challenge 3 - Customer Insights
-- You are a Customer Insights Analyst for 'The General Store'
-- Can you analyze the following tables to find out crucial information about your customers to provide to your marketing team?
CREATE DATABASE CUST_INSIGHT;
USE CUST_INSIGHT;
USE SCHEMA PUBLIC;
-- TABLE STRUCTURE OF COUNTRY
CREATE TABLE country (
    country_id INT PRIMARY KEY,
    country_name VARCHAR(50),
    head_office VARCHAR(50)
);
-- DUMPING DATA INTO COUNTRY TABLE
INSERT INTO
    country (country_id, country_name, head_office)
VALUES
    (1, 'UK', 'London'),
    (2, 'USA', 'New York'),
    (3, 'China', 'Beijing');
-- TABLE STRUTURE OF CUSTOMERS
    CREATE TABLE customers (
        customer_id INT PRIMARY KEY,
        first_shop DATE,
        age INT,
        rewards VARCHAR(50),
        can_email VARCHAR(50)
    );
-- DUMPING DATA IN CUSTOMERS TABLE
INSERT INTO
    customers (customer_id, first_shop, age, rewards, can_email)
VALUES
    (1, '2022-03-20', 23, 'yes', 'no'),
    (2, '2022-03-25', 26, 'no', 'no'),
    (3, '2022-04-06', 32, 'no', 'no'),
    (4, '2022-04-13', 25, 'yes', 'yes'),
    (5, '2022-04-22', 49, 'yes', 'yes'),
    (6, '2022-06-18', 28, 'yes', 'no'),
    (7, '2022-06-30', 36, 'no', 'no'),
    (8, '2022-07-04', 37, 'yes', 'yes');
-- TABLE STRUCTURE OF ORDERS
    CREATE TABLE orders (
        order_id INT PRIMARY KEY,
        customer_id INT,
        date_shop DATE,
        sales_channel VARCHAR(50),
        country_id INT,
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
        FOREIGN KEY (country_id) REFERENCES country(country_id)
    );
-- DUMPING DATA INTO ORDERS
INSERT INTO
    orders (
        order_id,
        customer_id,
        date_shop,
        sales_channel,
        country_id
    )
VALUES
    (1, 1, '2023-01-16', 'retail', 1),
    (2, 4, '2023-01-20', 'retail', 1),
    (3, 2, '2023-01-25', 'retail', 2),
    (4, 3, '2023-01-25', 'online', 1),
    (5, 1, '2023-01-28', 'retail', 3),
    (6, 5, '2023-02-02', 'online', 1),
    (7, 6, '2023-02-05', 'retail', 1),
    (8, 3, '2023-02-11', 'online', 3);
-- TABLE STRUCTURE OF PRODUCTS
    CREATE TABLE products (
        product_id INT PRIMARY KEY,
        category VARCHAR(50),
        price NUMERIC(5, 2)
    );
-- DUMPING DATA INTO PRODUCTS
INSERT INTO
    products (product_id, category, price)
VALUES
    (1, 'food', 5.99),
    (2, 'sports', 12.49),
    (3, 'vitamins', 6.99),
    (4, 'food', 0.89),
    (5, 'vitamins', 15.99);
-- TABLE STRUCTURE OF BASKETS
    CREATE TABLE baskets (
        order_id INT,
        product_id INT,
        FOREIGN KEY (order_id) REFERENCES orders(order_id),
        FOREIGN KEY (product_id) REFERENCES products(product_id)
    );
-- DUMPING DATA INTO BASKETS
INSERT INTO
    baskets (order_id, product_id)
VALUES
    (1, 1),
    (1, 2),
    (1, 5),
    (2, 4),
    (3, 3),
    (4, 2),
    (4, 1),
    (5, 3),
    (5, 5),
    (6, 4),
    (6, 3),
    (6, 1),
    (7, 2),
    (7, 1),
    (8, 3),
    (8, 3);
SELECT
    *
FROM
    BASKETS;
SELECT
    *
FROM
    COUNTRY;
SELECT
    *
FROM
    CUSTOMERS;
SELECT
    *
FROM
    ORDERS;
SELECT
    *
FROM
    PRODUCTS;
-- AD HOC ANALYSIS
    -- 1. What are the names of all the countries in the country table?
SELECT
    COUNTRY_NAME
FROM
    COUNTRY;
-- 2. What is the total number of customers in the customers table?
SELECT
    COUNT(CUSTOMER_ID) AS TOTAL_CUSTS
FROM
    CUSTOMERS;
-- 3. What is the average age of customers who can receive marketing emails (can_email is set to 'yes')?
SELECT
    AVG(AGE) AS AVERAGE_AGE
FROM
    CUSTOMERS
WHERE
    CAN_EMAIL = 'yes';
-- 4. How many orders were made by customers aged 30 or older?
SELECT
    COUNT(O.ORDER_ID) AS TOTAL_ORDERS
FROM
    ORDERS O
    JOIN CUSTOMERS C USING(CUSTOMER_ID)
WHERE
    AGE >= 30;
-- 5. What is the total revenue generated by each product category?
SELECT
    CATEGORY,
    SUM(PRICE) AS TOTAL_REVENEU
FROM
    PRODUCTS
GROUP BY
    1
ORDER BY
    2 DESC;
-- 6. What is the average price of products in the 'food' category?
SELECT
    CATEGORY,
    AVG(PRICE) AS AVG_PRICE
FROM
    PRODUCTS
WHERE
    CATEGORY = 'food'
GROUP BY
    1;
-- 7. How many orders were made in each sales channel (sales_channel column) in the orders table?
SELECT
    SALES_CHANNEL,
    COUNT(ORDER_ID) AS TOTAL_ORDERS
FROM
    ORDERS
GROUP BY
    SALES_CHANNEL;
-- 8. What is the date of the latest order made by a customer who can receive marketing emails?
SELECT
    MAX(O.DATE_SHOP) AS LATEST_ORDER
FROM
    ORDERS O
    JOIN CUSTOMERS C USING(CUSTOMER_ID)
WHERE
    CAN_EMAIL = 'yes';
-- 9. What is the name of the country with the highest number of orders?
SELECT
    C.COUNTRY_NAME,
    COUNT(O.ORDER_ID) AS TOTAL_ORDERS
FROM
    COUNTRY C
    JOIN ORDERS O USING(COUNTRY_ID)
GROUP BY
    1
ORDER BY
    2 DESC;
-- 10. What is the average age of customers who made orders in the 'vitamins' product category?
SELECT
    P.CATEGORY,
    AVG(C.AGE) AS AVG_AGE,
    COUNT(O.ORDER_ID) AS TOTAL_ORDERS
FROM
    CUSTOMERS C
    JOIN ORDERS O USING(CUSTOMER_ID)
    JOIN BASKETS B USING(ORDER_ID)
    JOIN PRODUCTS P USING(PRODUCT_ID)
WHERE
    CATEGORY = 'vitamins'
GROUP BY
    1;