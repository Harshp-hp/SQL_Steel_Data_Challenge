-- Challenge 5 - Pub Pricing Analysis
-- You are a Pricing Analyst working for a pub chain called 'Pubs "R" Us
-- You have been tasked with analyzing the drinks prices and sales to gain a greater insight into how the pubs in your chain are performing.
CREATE DATABASE PUBS;
USE PUBS;
USE SCHEMA PUBLIC;
-- TABLE STRUCTURE OF PUBS
CREATE TABLE pubs (
    pub_id INT PRIMARY KEY,
    pub_name VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50)
);
-- TABLE STRUCTURE FOR BEVERAGES
CREATE TABLE beverages (
    beverage_id INT PRIMARY KEY,
    beverage_name VARCHAR(50),
    category VARCHAR(50),
    alcohol_content FLOAT,
    price_per_unit DECIMAL(8, 2)
);
-- TABLE STRUCTURE FOR SALES
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    pub_id INT,
    beverage_id INT,
    quantity INT,
    transaction_date DATE,
    FOREIGN KEY (pub_id) REFERENCES pubs(pub_id),
    FOREIGN KEY (beverage_id) REFERENCES beverages(beverage_id)
);
-- TABLE STRUCTURE FOR RATINGS
CREATE TABLE ratings (
    rating_id INT PRIMARY KEY,
    pub_id INT,
    customer_name VARCHAR(50),
    rating FLOAT,
    review TEXT,
    FOREIGN KEY (pub_id) REFERENCES pubs(pub_id)
);
-- DUMPING DATA INTO TABLES
-- Insert sample data into the 'pubs' table
INSERT INTO
    pubs (pub_id, pub_name, city, state, country)
VALUES
    (
        1,
        'The Red Lion',
        'London',
        'England',
        'United Kingdom'
    ),
    (2, 'The Dubliner', 'Dublin', 'Dublin', 'Ireland'),
    (
        3,
        'The Cheers Bar',
        'Boston',
        'Massachusetts',
        'United States'
    ),
    (
        4,
        'La Cerveceria',
        'Barcelona',
        'Catalonia',
        'Spain'
    );
    --------------------
    -- Insert sample data into the 'beverages' table
INSERT INTO
    beverages (
        beverage_id,
        beverage_name,
        category,
        alcohol_content,
        price_per_unit
    )
VALUES
    (1, 'Guinness', 'Beer', 4.2, 5.99),
    (2, 'Jameson', 'Whiskey', 40.0, 29.99),
    (3, 'Mojito', 'Cocktail', 12.0, 8.99),
    (4, 'Chardonnay', 'Wine', 13.5, 12.99),
    (5, 'IPA', 'Beer', 6.8, 4.99),
    (6, 'Tequila', 'Spirit', 38.0, 24.99);
    --------------------
INSERT INTO
    sales (
        sale_id,
        pub_id,
        beverage_id,
        quantity,
        transaction_date
    )
VALUES
    (1, 1, 1, 10, '2023-05-01'),
    (2, 1, 2, 5, '2023-05-01'),
    (3, 2, 1, 8, '2023-05-01'),
    (4, 3, 3, 12, '2023-05-02'),
    (5, 4, 4, 3, '2023-05-02'),
    (6, 4, 6, 6, '2023-05-03'),
    (7, 2, 3, 6, '2023-05-03'),
    (8, 3, 1, 15, '2023-05-03'),
    (9, 3, 4, 7, '2023-05-03'),
    (10, 4, 1, 10, '2023-05-04'),
    (11, 1, 3, 5, '2023-05-06'),
    (12, 2, 2, 3, '2023-05-09'),
    (13, 2, 5, 9, '2023-05-09'),
    (14, 3, 6, 4, '2023-05-09'),
    (15, 4, 3, 7, '2023-05-09'),
    (16, 4, 4, 2, '2023-05-09'),
    (17, 1, 4, 6, '2023-05-11'),
    (18, 1, 6, 8, '2023-05-11'),
    (19, 2, 1, 12, '2023-05-12'),
    (20, 3, 5, 5, '2023-05-13');
    --------------------
    -- Insert sample data into the 'ratings' table
INSERT INTO
    ratings (rating_id, pub_id, customer_name, rating, review)
VALUES
    (
        1,
        1,
        'John Smith',
        4.5,
        'Great pub with a wide selection of beers.'
    ),
    (
        2,
        1,
        'Emma Johnson',
        4.8,
        'Excellent service and cozy atmosphere.'
    ),
    (
        3,
        2,
        'Michael Brown',
        4.2,
        'Authentic atmosphere and great beers.'
    ),
    (
        4,
        3,
        'Sophia Davis',
        4.6,
        'The cocktails were amazing! Will definitely come back.'
    ),
    (
        5,
        4,
        'Oliver Wilson',
        4.9,
        'The wine selection here is outstanding.'
    ),
    (
        6,
        4,
        'Isabella Moore',
        4.3,
        'Had a great time trying different spirits.'
    ),
    (
        7,
        1,
        'Sophia Davis',
        4.7,
        'Loved the pub food! Great ambiance.'
    ),
    (
        8,
        2,
        'Ethan Johnson',
        4.5,
        'A good place to hang out with friends.'
    ),
    (
        9,
        2,
        'Olivia Taylor',
        4.1,
        'The whiskey tasting experience was fantastic.'
    ),
    (
        10,
        3,
        'William Miller',
        4.4,
        'Friendly staff and live music on weekends.'
    );
    --------------------
SELECT
    *
FROM
    BEVERAGES;
SELECT
    *
FROM
    PUBS;
SELECT
    *
FROM
    RATINGS;
SELECT
    *
FROM
    SALES;
-- AD-HOC-ANALYSIS
    -- 1. How many pubs are located in each country??
SELECT
    COUNTRY,
    COUNT(PUB_ID) AS TOTAL_COUNT
FROM
    PUBS
GROUP BY
    COUNTRY;
-- 2. What is the total sales amount for each pub, including the beverage price and quantity sold?
SELECT
    P.PUB_NAME,
    B.PRICE_PER_UNIT,
    S.QUANTITY,
    SUM(S.QUANTITY * B.PRICE_PER_UNIT) AS TOTAL_SALES
FROM
    BEVERAGES B
    JOIN SALES S USING(BEVERAGE_ID)
    JOIN PUBS P USING(PUB_ID)
GROUP BY
    1,
    2,
    3
ORDER BY
    4 DESC;
-- 3. Which pub has the highest average rating?
SELECT
    P.PUB_NAME,
    AVG(R.RATING) AS HIGHEST_RATING
FROM
    PUBS P
    JOIN RATINGS R USING(PUB_ID)
GROUP BY
    1
ORDER BY
    2 DESC;
-- 4. What are the top 5 beverages by sales quantity across all pubs?
SELECT
    B.BEVERAGE_NAME,
    SUM(S.QUANTITY * B.PRICE_PER_UNIT) AS TOTAL_SALES
FROM
    BEVERAGES B
    JOIN SALES S USING(BEVERAGE_ID)
    JOIN PUBS P USING(PUB_ID)
GROUP BY
    1
ORDER BY
    2 DESC
LIMIT
    5;
    -- 5. How many sales transactions occurred on each date?
SELECT
    TRANSACTION_DATE,
    COUNT(SALE_ID) AS SALES_TRAXN
FROM
    SALES
GROUP BY
    1
ORDER BY
    2 DESC;
-- 6. Find the name of someone that had cocktails and which pub they had it in.
SELECT
    R.CUSTOMER_NAME,
    P.PUB_NAME,
    B.CATEGORY
FROM
    RATINGS R
    JOIN PUBS P USING(PUB_ID)
    JOIN SALES S USING(PUB_ID)
    JOIN BEVERAGES B USING(BEVERAGE_ID)
WHERE
    B.CATEGORY = 'Cocktail';
--7. What is the average price per unit for each category of beverages, excluding the category 'Spirit'?
SELECT
    CATEGORY,
    AVG(PRICE_PER_UNIT) AS AVG_PRICE
FROM
    BEVERAGES
WHERE
    CATEGORY != 'Spirit'
GROUP BY
    CATEGORY
ORDER BY
    2 DESC;
-- 8. Which pubs have a rating higher than the average rating of all pubs?
SELECT
    P.PUB_NAME,
    ROUND(AVG(R.RATING), 1) AS RATING
FROM
    RATINGS R
    JOIN PUBS P USING(PUB_ID)
WHERE
    R.RATING > (
        SELECT
            ROUND(AVG(RATING), 1) AS AVG_RATING
        FROM
            RATINGS
    )
GROUP BY
    1
ORDER BY
    2 DESC;
-- 9. What is the running total of sales amount for each pub, ordered by the transaction date?
SELECT
    *
FROM
    SALES;
WITH TOTAL_SALES AS (
        SELECT
            S.PUB_ID,
            S.TRANSACTION_DATE,
            ROUND(SUM(S.QUANTITY * B.PRICE_PER_UNIT), 2) AS TOTAL_SALES_AMT
        FROM
            SALES S
            JOIN BEVERAGES B USING(BEVERAGE_ID)
        GROUP BY
            1,
            2
        ORDER BY
            3
    )
SELECT
    *,
    SUM(TOTAL_SALES_AMT) OVER(
        PARTITION BY PUB_ID
        ORDER BY
            TRANSACTION_DATE
    )
FROM
    TOTAL_SALES;
-- 10. For each country, what is the average price per unit of beverages in each category, and what is the overall average price per unit of beverages across all categories?
SELECT
    *
FROM
    BEVERAGES;
WITH AVG_PRICE_BEVERAGES AS (
        SELECT
            P.COUNTRY,
            B.CATEGORY,
            ROUND(AVG(B.PRICE_PER_UNIT), 2) AS AVG_PRICE_UNIT_BEVERAGES
        FROM
            PUBS P
            JOIN SALES S USING(PUB_ID)
            JOIN BEVERAGES B USING(BEVERAGE_ID)
        GROUP BY
            1,
            2
        ORDER BY
            3 DESC
    )
SELECT
    *,
    AVG(AVG_PRICE_UNIT_BEVERAGES) OVER() AS OVERALL_AVG_PRICE
FROM
    AVG_PRICE_BEVERAGES;
-- 11. For each pub, what is the percentage contribution of each category of beverages to the total sales amount, and what is the pub's overall sales amount?
SELECT
    *
FROM
    BEVERAGES;
WITH CATE_SALES_AMT AS (
        SELECT
            P.PUB_NAME,
            S.QUANTITY,
            B.CATEGORY,
            ROUND(SUM(S.QUANTITY * B.PRICE_PER_UNIT), 2) AS BEVEREGES_SALES_AMOUNT
        FROM
            PUBS P
            JOIN SALES S USING(PUB_ID)
            JOIN BEVERAGES B USING(BEVERAGE_ID)
        GROUP BY
            1,
            2,
            3
        ORDER BY
            4 DESC
    ),
    OVERALL_SALES_AMT AS (
        SELECT
            P.PUB_NAME,
            ROUND(SUM(S.QUANTITY * B.PRICE_PER_UNIT), 2) AS OVER_ALL_PRICE
        FROM
            PUBS P
            JOIN SALES S USING(PUB_ID)
            JOIN BEVERAGES B USING(BEVERAGE_ID)
        GROUP BY
            1
    )
SELECT
    PUB_NAME,
    CATEGORY,
    ROUND(
        SUM(BEVEREGES_SALES_AMOUNT / OVER_ALL_PRICE * 100),
        2
    ) AS PERCENTAGE_CONTRIBUTION
FROM
    CATE_SALES_AMT
    JOIN OVERALL_SALES_AMT USING(PUB_NAME)
GROUP BY
    1,
    2
ORDER BY
    3 DESC;