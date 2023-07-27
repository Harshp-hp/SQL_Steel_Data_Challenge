-- Introduction
-- Steve runs a top-end car showroom but his data analyst has just quit and left him  without his crucial insights.
CREATE DATABASE CAR_STORE;
USE CAR_STORE;
USE SCHEMA PUBLIC;
-- TABLE STRUCTURE OF CARS
CREATE TABLE CARS (
    car_id INT PRIMARY KEY,
    make VARCHAR(50),
    type VARCHAR(50),
    style VARCHAR(50),
    cost INT
);
-- Dumping Data into table cars
INSERT INTO
    CARS(car_id, make, type, style, cost)
VALUES(1, 'Honda', 'Civic', 'Sedan', 30000),
    (2, 'Toyota', 'Corolla', 'Hatchback', 25000),
    (3, 'Ford', 'Explorer', 'SUV', 40000),
    (4, 'Chevrolet', 'Camaro', 'Coupe', 36000),
    (5, 'BMW', 'X5', 'SUV', 55000),
    (6, 'Audi', 'A4', 'Sedan', 48000),
    (7, 'Mercedes', 'C-Class', 'Coupe', 60000),
    (8, 'Nissan', 'Altima', 'Sedan', 26000);
-- Table Structure of Salespersons
    CREATE TABLE SALESPERSONS (
        salesman_id INT PRIMARY KEY,
        name VARCHAR(50),
        age INT,
        city VARCHAR(50)
    );
-- Dumping data into salesperson
INSERT INTO
    SALESPERSONS (salesman_id, name, age, city)
VALUES
    (1, 'John Smith', 28, 'New York'),
    (2, 'Emily Wong', 35, 'San Fran'),
    (3, 'Tom Lee', 42, 'Seattle'),
    (4, 'Lucy Chen', 31, 'LA');
-- TABLE STRUCTURE SALES TABLE
    CREATE TABLE SALES (
        sale_id INT PRIMARY KEY,
        car_id INT,
        salesman_id INT,
        purchase_date DATE,
        FOREIGN KEY(car_id) REFERENCES cars(car_id),
        FOREIGN KEY(salesman_id) REFERENCES salespersons(salesman_id)
    );
-- Dumping data into sales table
INSERT INTO
    SALES (sale_id, car_id, salesman_id, purchase_date)
VALUES
    (1, 1, 1, '2021-01-01'),
    (2, 3, 3, '2021-02-03'),
    (3, 2, 2, '2021-02-10'),
    (4, 5, 4, '2021-03-01'),
    (5, 8, 1, '2021-04-02'),
    (6, 2, 1, '2021-05-05'),
    (7, 4, 2, '2021-06-07'),
    (8, 5, 3, '2021-07-09'),
    (9, 2, 4, '2022-01-01'),
    (10, 1, 3, '2022-02-03'),
    (11, 8, 2, '2022-02-10'),
    (12, 7, 2, '2022-03-01'),
    (13, 5, 3, '2022-04-02'),
    (14, 3, 1, '2022-05-05'),
    (15, 5, 4, '2022-06-07'),
    (16, 1, 2, '2022-07-09'),
    (17, 2, 3, '2023-01-01'),
    (18, 6, 3, '2023-02-03'),
    (19, 7, 1, '2023-02-10'),
    (20, 4, 4, '2023-03-01');
SELECT
    *
FROM
    cars;
SELECT
    *
FROM
    salespersons;
SELECT
    *
FROM
    sales;
-- Questions
    -- 1. What are the details of all cars purchased in the year 2022
SELECT
    S.PURCHASE_DATE,
    C.MAKE,
    C.TYPE,
    C.STYLE,
    C.COST
FROM
    SALES S
    INNER JOIN CARS C USING(CAR_ID)
WHERE
    YEAR(S.PURCHASE_DATE) = 2022;
-- 2. What is the total number of cars sold by each SALESPERSON?
SELECT
    SP.NAME,
    COUNT(CAR_ID) AS TOTAL_CARS
FROM
    CARS C
    JOIN SALES S USING(CAR_ID)
    JOIN SALESPERSONS SP USING(SALESMAN_ID)
GROUP BY
    SP.NAME
ORDER BY
    2 DESC;
-- 3. What is the total revenue generated by each salesperson?
SELECT
    SP.NAME,
    SUM(C.COST) AS TOTAL_REVENUE
FROM
    CARS C
    JOIN SALES S USING(CAR_ID)
    JOIN SALESPERSONS SP USING(SALESMAN_ID)
GROUP BY
    SP.NAME
ORDER BY
    2 DESC;
-- 4. What are the details of the cars sold by each salesperson?
SELECT
    SP.NAME,
    C.MAKE,
    C.TYPE,
    C.STYLE
FROM
    CARS C
    JOIN SALES S USING(CAR_ID)
    JOIN SALESPERSONS SP USING(SALESMAN_ID);
--5.  What is the total revenue generated by each car type?
SELECT
    TYPE,
    SUM(COST) AS TOTAL_REVENUE
FROM
    CARS
GROUP BY
    TYPE
ORDER BY
    2 DESC;
-- 6. What are the details of the cars sold in the year 2021 by salesperson 'Emily Wong'?
SELECT
    SP.NAME,
    C.MAKE,
    C.TYPE,
    C.STYLE,
    C.COST,
    S.PURCHASE_DATE
FROM
    CARS C
    JOIN SALES S USING(CAR_ID)
    JOIN SALESPERSONS SP USING(SALESMAN_ID)
WHERE
    SP.NAME = 'Emily Wong'
    AND YEAR(PURCHASE_DATE) = 2021;
--7.  What is the total revenue generated by the sales of hatchback cars?
SELECT
    STYLE,
    SUM(COST) AS TOTAL_REVENUE
FROM
    CARS
WHERE
    STYLE = 'Hatchback'
GROUP BY
    STYLE;
-- 8. What is the total revenue generated by the sales of SUV cars in the year 2022?
SELECT
    C.STYLE,
    SUM(C.COST) AS TOTAL_REVENEU
FROM
    CARS C
    JOIN SALES S USING(CAR_ID)
WHERE
    C.STYLE = 'SUV'
    AND YEAR(S.PURCHASE_DATE) = 2022
GROUP BY
    C.STYLE;
-- 9. What is the name and city of the salesperson who sold the most number of cars in the year 2023?
SELECT
    SP.NAME,
    SP.CITY,
    COUNT(S.SALE_ID) AS TOTAL_SALES
FROM
    CARS C
    JOIN SALES S USING(CAR_ID)
    JOIN SALESPERSONS SP USING(SALESMAN_ID)
WHERE
    YEAR(S.PURCHASE_DATE) = 2023
GROUP BY
    SP.NAME,
    SP.CITY
ORDER BY
    3 DESC;
-- 10. What is the name and age of the salesperson who generated the highest revenue in the year 2022?
SELECT
    SP.NAME,
    SP.AGE,
    SUM(COST) AS TOTAL_REVENEU
FROM
    CARS C
    JOIN SALES S USING(CAR_ID)
    JOIN SALESPERSONS SP USING(SALESMAN_ID)
WHERE
    YEAR(S.PURCHASE_DATE) = 2022
GROUP BY
    SP.NAME,
    SP.AGE
ORDER BY
    3 DESC
LIMIT
    1;