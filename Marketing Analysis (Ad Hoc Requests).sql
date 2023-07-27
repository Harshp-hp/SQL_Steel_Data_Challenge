-- You are a Marketing Analyst
-- The 'Sustainable Clothing Co.' has been running several marketing campaigns and has asked you to provide your insight into whether they have been successful or not. Analyze the following data and answer the questions to form your answer.
CREATE DATABASE MARKETING;
USE MARKETING;
USE SCHEMA PUBLIC;
-- Create the table
CREATE TABLE sustainable_clothing (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    size VARCHAR(10),
    price FLOAT
);
-- Insert data into the table
INSERT INTO
    sustainable_clothing (product_id, product_name, category, size, price)
VALUES
    (1, 'Organic Cotton T-Shirt', 'Tops', 'S', 29.99),
    (2, 'Recycled Denim Jeans', 'Bottoms', 'M', 79.99),
    (3, 'Hemp Crop Top', 'Tops', 'L', 24.99),
    (4, 'Bamboo Lounge Pants', 'Bottoms', 'XS', 49.99),
    (
        5,
        'Eco-Friendly Hoodie',
        'Outerwear',
        'XL',
        59.99
    ),
    (6, 'Linen Button-Down Shirt', 'Tops', 'M', 39.99),
    (7, 'Organic Cotton Dress', 'Dresses', 'S', 69.99),
    (
        8,
        'Sustainable Swim Shorts',
        'Swimwear',
        'L',
        34.99
    ),
    (
        9,
        'Recycled Polyester Jacket',
        'Outerwear',
        'XL',
        89.99
    ),
    (
        10,
        'Bamboo Yoga Leggings',
        'Activewear',
        'XS',
        54.99
    ),
    (11, 'Hemp Overalls', 'Bottoms', 'M', 74.99),
    (12, 'Organic Cotton Sweater', 'Tops', 'L', 49.99),
    (13, 'Cork Sandals', 'Footwear', 'S', 39.99),
    (
        14,
        'Recycled Nylon Backpack',
        'Accessories',
        'One Size',
        59.99
    ),
    (
        15,
        'Organic Cotton Skirt',
        'Bottoms',
        'XS',
        34.99
    ),
    (
        16,
        'Hemp Baseball Cap',
        'Accessories',
        'One Size',
        24.99
    ),
    (
        17,
        'Upcycled Denim Jacket',
        'Outerwear',
        'M',
        79.99
    ),
    (18, 'Linen Jumpsuit', 'Dresses', 'L', 69.99),
    (
        19,
        'Organic Cotton Socks',
        'Accessories',
        'M',
        9.99
    ),
    (20, 'Bamboo Bathrobe', 'Loungewear', 'XL', 69.99);
    -- Create the table
    CREATE TABLE marketing_campaigns (
        campaign_id INT PRIMARY KEY,
        campaign_name VARCHAR(100),
        product_id INT,
        start_date DATE,
        end_date DATE,
        FOREIGN KEY (product_id) REFERENCES sustainable_clothing (product_id)
    );
    -- Insert data into the table
INSERT INTO
    marketing_campaigns (
        campaign_id,
        campaign_name,
        product_id,
        start_date,
        end_date
    )
VALUES
    (1, 'Summer Sale', 2, '2023-06-01', '2023-06-30'),
    (
        2,
        'New Collection Launch',
        10,
        '2023-07-15',
        '2023-08-15'
    ),
    (3, 'Super Save', 7, '2023-08-20', '2023-09-15');
    -- Create the table
    CREATE TABLE transactions (
        transaction_id INT PRIMARY KEY,
        product_id INT,
        quantity INT,
        purchase_date DATE,
        FOREIGN KEY (product_id) REFERENCES sustainable_clothing (product_id)
    );
    -- Insert data into the table
INSERT INTO
    transactions (
        transaction_id,
        product_id,
        quantity,
        purchase_date
    )
VALUES
    (1, 2, 2, '2023-06-02'),
    (2, 14, 1, '2023-06-02'),
    (3, 5, 2, '2023-06-05'),
    (4, 2, 1, '2023-06-07'),
    (5, 19, 2, '2023-06-10'),
    (6, 2, 1, '2023-06-13'),
    (7, 16, 1, '2023-06-13'),
    (8, 10, 2, '2023-06-15'),
    (9, 2, 1, '2023-06-18'),
    (10, 4, 1, '2023-06-22'),
    (11, 18, 2, '2023-06-26'),
    (12, 2, 1, '2023-06-30'),
    (13, 13, 1, '2023-06-30'),
    (14, 4, 1, '2023-07-04'),
    (15, 6, 2, '2023-07-08'),
    (16, 15, 1, '2023-07-08'),
    (17, 9, 2, '2023-07-12'),
    (18, 20, 1, '2023-07-12'),
    (19, 11, 1, '2023-07-16'),
    (20, 10, 1, '2023-07-20'),
    (21, 12, 2, '2023-07-24'),
    (22, 5, 1, '2023-07-29'),
    (23, 10, 1, '2023-07-29'),
    (24, 10, 1, '2023-08-03'),
    (25, 19, 2, '2023-08-08'),
    (26, 3, 1, '2023-08-14'),
    (27, 10, 1, '2023-08-14'),
    (28, 16, 2, '2023-08-20'),
    (29, 18, 1, '2023-08-27'),
    (30, 12, 2, '2023-09-01'),
    (31, 13, 1, '2023-09-05'),
    (32, 7, 1, '2023-09-05'),
    (33, 6, 1, '2023-09-10'),
    (34, 15, 2, '2023-09-14'),
    (35, 9, 1, '2023-09-14'),
    (36, 11, 2, '2023-09-19'),
    (37, 17, 1, '2023-09-23'),
    (38, 2, 1, '2023-09-28'),
    (39, 14, 1, '2023-09-28'),
    (40, 5, 2, '2023-09-30'),
    (41, 16, 1, '2023-10-01'),
    (42, 12, 2, '2023-10-01'),
    (43, 1, 1, '2023-10-01'),
    (44, 7, 1, '2023-10-02'),
    (45, 18, 2, '2023-10-03'),
    (46, 12, 1, '2023-10-03'),
    (47, 13, 1, '2023-10-04'),
    (48, 4, 1, '2023-10-05'),
    (49, 12, 2, '2023-10-05'),
    (50, 7, 1, '2023-10-06'),
    (51, 4, 2, '2023-10-08'),
    (52, 8, 2, '2023-10-08'),
    (53, 16, 1, '2023-10-09'),
    (54, 19, 1, '2023-10-09'),
    (55, 1, 1, '2023-10-10'),
    (56, 18, 2, '2023-10-10'),
    (57, 2, 1, '2023-10-10'),
    (58, 15, 2, '2023-10-11'),
    (59, 17, 2, '2023-10-13'),
    (60, 13, 1, '2023-10-13'),
    (61, 10, 2, '2023-10-13'),
    (62, 9, 1, '2023-10-13'),
    (63, 19, 2, '2023-10-13'),
    (64, 20, 1, '2023-10-14');
SELECT
    *
FROM
    MARKETING_CAMPAIGNS;
SELECT
    *
FROM
    SUSTAINABLE_CLOTHING;
SELECT
    *
FROM
    TRANSACTIONS;
-- AD HOC ANALYSIS
    -- 1. How many transactions were completed during each marketing campaign?
SELECT
    C.CAMPAIGN_NAME,
    COUNT(T.TRANSACTION_ID) AS TOTAL_TRANSACTIONS
FROM
    MARKETING_CAMPAIGNS C
    JOIN TRANSACTIONS T USING(PRODUCT_ID)
GROUP BY
    1
ORDER BY
    2 DESC;
-- 2. Which product had the highest sales quantity?
SELECT
    P.PRODUCT_NAME,
    ROUND(SUM(T.QUANTITY * P.PRICE), 2) AS SALES
FROM
    SUSTAINABLE_CLOTHING P
    JOIN TRANSACTIONS T USING(PRODUCT_ID)
GROUP BY
    1
ORDER BY
    2 DESC;
-- 3. What is the total revenue generated from each marketing campaign?
SELECT
    C.CAMPAIGN_NAME,
    ROUND(SUM(T.QUANTITY * P.PRICE), 2) AS REVENUE
FROM
    MARKETING_CAMPAIGNS C
    JOIN SUSTAINABLE_CLOTHING P USING(PRODUCT_ID)
    JOIN TRANSACTIONS T USING(PRODUCT_ID)
GROUP BY
    1
ORDER BY
    2 DESC;
-- 4. What is the top-selling product category based on the total revenue generated?
SELECT
    P.CATEGORY,
    ROUND(SUM(T.QUANTITY * P.PRICE)) AS REVENUE
FROM
    SUSTAINABLE_CLOTHING P
    JOIN TRANSACTIONS T USING(PRODUCT_ID)
GROUP BY
    1
ORDER BY
    2 DESC;
-- 5. Which products had a higher quantity sold compared to the average quantity sold?
SELECT
    P.PRODUCT_NAME,
    COUNT(T.QUANTITY) AS TOTAL_QTY,
    ROUND(AVG(T.QUANTITY), 2) AS AVG_QTY
FROM
    SUSTAINABLE_CLOTHING P
    JOIN TRANSACTIONS T USING(PRODUCT_ID)
GROUP BY
    1
ORDER BY
    3 DESC;
-- 6. What is the average revenue generated per day during the marketing campaigns?
    WITH REVENUE AS (
        SELECT
            T.PURCHASE_DATE,
            ROUND(SUM(T.QUANTITY * P.PRICE), 2) AS TOTAL_REVENUE
        FROM
            TRANSACTIONS T
            JOIN SUSTAINABLE_CLOTHING P USING(PRODUCT_ID)
        GROUP BY
            1
        ORDER BY
            2 DESC
    )
SELECT
    *,
    AVG(TOTAL_REVENUE) OVER() AS AVG_REVENUE
FROM
    REVENUE;
    
-- 7. What is the percentage contribution of each product to the total revenue?
    WITH PRODUCT_REVENUE AS(
        SELECT
            P.PRODUCT_NAME,
            COUNT(P.PRODUCT_ID) AS TOTAL_PRODUCTS,
            ROUND(SUM(T.QUANTITY * P.PRICE), 2) AS TOTAL_REVENUE
        FROM
            TRANSACTIONS T
            JOIN SUSTAINABLE_CLOTHING P USING(PRODUCT_ID)
        GROUP BY
            1
    )
SELECT
    PRODUCT_NAME,
    ROUND(SUM((TOTAL_PRODUCTS / TOTAL_REVENUE) * 100), 2) AS PCT_CONTRIBUTION
FROM
    PRODUCT_REVENUE
GROUP BY
    1
ORDER BY
    2 DESC;
-- 8. Compare the average quantity sold during marketing campaigns to outside the marketing campaigns
    WITH TOTAL_QTY AS (
        SELECT
            ROUND(AVG(T.QUANTITY), 2) AS TOTAL_AVG_QTY
        FROM
            TRANSACTIONS T
            JOIN SUSTAINABLE_CLOTHING P USING(PRODUCT_ID)
    ),
    AVG_QTY_CAMPAIGN AS (
        SELECT
            ROUND(AVG(T.QUANTITY), 2) AS AVG_QTY_DURING_CAMPAIGN
        FROM
            TRANSACTIONS T
            JOIN SUSTAINABLE_CLOTHING P USING(PRODUCT_ID)
            JOIN MARKETING_CAMPAIGNS C ON T.PURCHASE_DATE BETWEEN C.START_DATE
            AND C.END_DATE
    )
SELECT
    TOTAL_AVG_QTY,
    AVG_QTY_DURING_CAMPAIGN,
    SUM(TOTAL_AVG_QTY - AVG_QTY_DURING_CAMPAIGN) AS DIFFERENCE
FROM
    TOTAL_QTY,
    AVG_QTY_CAMPAIGN
GROUP BY
    1,
    2;
-- 9. Compare the revenue generated by products inside the marketing campaigns to outside the campaigns
    WITH PRODUCT_REVENEU_CAMPAIGN AS(
        SELECT
            ROUND(SUM(T.QUANTITY * P.PRICE), 2) AS REVENUE
        FROM
            SUSTAINABLE_CLOTHING P
            JOIN TRANSACTIONS T USING(PRODUCT_ID)
    ),
    PRODUCT_REVENEW_WO_CAMPAIGN AS (
        SELECT
            ROUND(SUM(T.QUANTITY * PRICE), 2) AS REVENUE_WO_CAMP
        FROM
            TRANSACTIONS T
            JOIN SUSTAINABLE_CLOTHING P USING(PRODUCT_ID)
            JOIN MARKETING_CAMPAIGNS C ON T.PURCHASE_DATE BETWEEN C.START_DATE
            AND C.END_DATE
    )
SELECT
    REVENUE,
    REVENUE_WO_CAMP,
    ROUND(SUM((REVENUE / REVENUE_WO_CAMP) * 100), 2) AS DIFFERENCE
FROM
    PRODUCT_REVENEU_CAMPAIGN,
    PRODUCT_REVENEW_WO_CAMPAIGN
GROUP BY
    1,
    2;
-- 10. Rank the products by their average daily quantity sold
    WITH PRODUCT_QTY AS (
        SELECT
            P.PRODUCT_NAME,
            AVG(T.QUANTITY) AS AVG_QTY
        FROM
            SUSTAINABLE_CLOTHING P
            JOIN TRANSACTIONS T USING(PRODUCT_ID)
        GROUP BY
            P.PRODUCT_NAME
    )
SELECT
    *,
    DENSE_RANK() OVER(
        ORDER BY
            AVG_QTY DESC
    ) AS RANKING
FROM
    PRODUCT_QTY;
