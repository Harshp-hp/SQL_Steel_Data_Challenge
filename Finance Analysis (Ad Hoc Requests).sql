-- Challenge 4 - Finance Analysis
-- You are a Finance Analyst working for 'The Big Bank'
-- You have been tasked with finding out about your customers and their banking behaviour. Examine the --accounts they hold and the type of transactions they make to develop greater insight into your customers.
CREATE DATABASE FINANCE;
USE FINANCE;
USE SCHEMA PUBLIC;
-- TABLE STRUCTURE OF CUSTOMERS
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    City VARCHAR(50) NOT NULL,
    State VARCHAR(2) NOT NULL
);
-- DUMPING DATA INTO CUSTOMERS
INSERT INTO
    Customers (CustomerID, FirstName, LastName, City, State)
VALUES
    (1, 'John', 'Doe', 'New York', 'NY'),
    (2, 'Jane', 'Doe', 'New York', 'NY'),
    (3, 'Bob', 'Smith', 'San Francisco', 'CA'),
    (4, 'Alice', 'Johnson', 'San Francisco', 'CA'),
    (5, 'Michael', 'Lee', 'Los Angeles', 'CA'),
    (6, 'Jennifer', 'Wang', 'Los Angeles', 'CA');
-- TABLE STRUCTURE OF BRANCHES
    CREATE TABLE Branches (
        BranchID INT PRIMARY KEY,
        BranchName VARCHAR(50) NOT NULL,
        City VARCHAR(50) NOT NULL,
        State VARCHAR(2) NOT NULL
    );
-- DUMPING DATA INTO BRANCHES
INSERT INTO
    Branches (BranchID, BranchName, City, State)
VALUES
    (1, 'Main', 'New York', 'NY'),
    (2, 'Downtown', 'San Francisco', 'CA'),
    (3, 'West LA', 'Los Angeles', 'CA'),
    (4, 'East LA', 'Los Angeles', 'CA'),
    (5, 'Uptown', 'New York', 'NY'),
    (6, 'Financial District', 'San Francisco', 'CA'),
    (7, 'Midtown', 'New York', 'NY'),
    (8, 'South Bay', 'San Francisco', 'CA'),
    (9, 'Downtown', 'Los Angeles', 'CA'),
    (10, 'Chinatown', 'New York', 'NY'),
    (11, 'Marina', 'San Francisco', 'CA'),
    (12, 'Beverly Hills', 'Los Angeles', 'CA'),
    (13, 'Brooklyn', 'New York', 'NY'),
    (14, 'North Beach', 'San Francisco', 'CA'),
    (15, 'Pasadena', 'Los Angeles', 'CA');
-- TABLE STRCTURE OF ACCOUNTS TABLE
    CREATE TABLE Accounts (
        AccountID INT PRIMARY KEY,
        CustomerID INT NOT NULL,
        BranchID INT NOT NULL,
        AccountType VARCHAR(50) NOT NULL,
        Balance DECIMAL(10, 2) NOT NULL,
        FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
        FOREIGN KEY (BranchID) REFERENCES Branches(BranchID)
    );
-- DUMPING DATA INTO ACCOUNTS TABLE
INSERT INTO
    Accounts (
        AccountID,
        CustomerID,
        BranchID,
        AccountType,
        Balance
    )
VALUES
    (1, 1, 5, 'Checking', 1000.00),
    (2, 1, 5, 'Savings', 5000.00),
    (3, 2, 1, 'Checking', 2500.00),
    (4, 2, 1, 'Savings', 10000.00),
    (5, 3, 2, 'Checking', 7500.00),
    (6, 3, 2, 'Savings', 15000.00),
    (7, 4, 8, 'Checking', 5000.00),
    (8, 4, 8, 'Savings', 20000.00),
    (9, 5, 14, 'Checking', 10000.00),
    (10, 5, 14, 'Savings', 50000.00),
    (11, 6, 2, 'Checking', 5000.00),
    (12, 6, 2, 'Savings', 10000.00),
    (13, 1, 5, 'Credit Card', -500.00),
    (14, 2, 1, 'Credit Card', -1000.00),
    (15, 3, 2, 'Credit Card', -2000.00);
-- TABLE STRUCTURE OF TRANSACTIONS TABLE
    CREATE TABLE Transactions (
        TransactionID INT PRIMARY KEY,
        AccountID INT NOT NULL,
        TransactionDate DATE NOT NULL,
        Amount DECIMAL(10, 2) NOT NULL,
        FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
    );
-- DUMPING DATA INTO TRANSACTION TABLE
INSERT INTO
    Transactions (
        TransactionID,
        AccountID,
        TransactionDate,
        Amount
    )
VALUES
    (1, 1, '2022-01-01', -500.00),
    (2, 1, '2022-01-02', -250.00),
    (3, 2, '2022-01-03', 1000.00),
    (4, 3, '2022-01-04', -1000.00),
    (5, 3, '2022-01-05', 500.00),
    (6, 4, '2022-01-06', 1000.00),
    (7, 4, '2022-01-07', -500.00),
    (8, 5, '2022-01-08', -2500.00),
    (9, 6, '2022-01-09', 500.00),
    (10, 6, '2022-01-10', -1000.00),
    (11, 7, '2022-01-11', -500.00),
    (12, 7, '2022-01-12', -250.00),
    (13, 8, '2022-01-13', 1000.00),
    (14, 8, '2022-01-14', -1000.00),
    (15, 9, '2022-01-15', 500.00);
SELECT
    *
FROM
    ACCOUNTS;
SELECT
    *
FROM
    BRANCHES;
SELECT
    *
FROM
    CUSTOMERS;
SELECT
    *
FROM
    TRANSACTIONS;
-- AD HOC ANALYSIS
    -- 1. What are the names of all the customers who live in New York?
SELECT
    CONCAT(FIRSTNAME, LASTNAME) AS FULL_NAME,
    CITY
FROM
    CUSTOMERS
WHERE
    CITY = 'New York';
-- 2. What is the total number of accounts in the Accounts table?
SELECT
    COUNT(ACCOUNTID) AS TOTAL_ACCOUNTS
FROM
    ACCOUNTS;
-- 3. What is the total balance of all checking accounts?
SELECT
    ACCOUNTTYPE,
    SUM(BALANCE) AS TOTAL_BAL
FROM
    ACCOUNTS
WHERE
    ACCOUNTTYPE = 'Checking'
GROUP BY
    ACCOUNTTYPE;
-- 4. What is the total balance of all accounts associated with customers who live in Los Angeles?
SELECT
    CONCAT(C.FIRSTNAME, C.LASTNAME) AS FULL_NAME,
    C.CITY,
    SUM(A.BALANCE) AS TOTAL_BALANCE
FROM
    CUSTOMERS C
    JOIN ACCOUNTS A USING(CUSTOMERID)
WHERE
    C.CITY = 'Los Angeles'
GROUP BY
    1,
    2;
-- 5. Which branch has the highest average account balance?
SELECT
    B.BRANCHNAME,
    MAX(A.BALANCE)
FROM
    BRANCHES B
    JOIN ACCOUNTS A USING(BRANCHID)
GROUP BY
    1
ORDER BY
    2 DESC;
-- 6. Which customer has the highest current balance in their accounts?
SELECT
    CONCAT(FIRSTNAME, LASTNAME) AS FULL_NAME,
    MAX(A.BALANCE) AS HIGHEST_BAL
FROM
    CUSTOMERS C
    JOIN ACCOUNTS A USING(CUSTOMERID)
GROUP BY
    1
ORDER BY
    1 DESC;
-- 7. Which customer has made the most transactions in the Transactions table?
SELECT
    CONCAT(FIRSTNAME, LASTNAME) AS FULL_NAME,
    COUNT(T.TRANSACTIONID) AS TOTAL_TXN
FROM
    CUSTOMERS C
    JOIN ACCOUNTS A USING(CUSTOMERID)
    JOIN TRANSACTIONS T USING(ACCOUNTID)
GROUP BY
    1
ORDER BY
    2 DESC;
-- 8.Which branch has the highest total balance across all of its accounts?
SELECT
    B.BRANCHNAME,
    B.CITY,
    SUM(A.BALANCE) AS TOTAL_BAL
FROM
    ACCOUNTS A
    JOIN BRANCHES B USING(BRANCHID)
GROUP BY
    1,
    2
ORDER BY
    3 DESC;
-- 9. Which customer has the highest total balance across all of their accounts, including savings and checking accounts?
SELECT
    CONCAT(FIRSTNAME, LASTNAME) AS FULL_NAME,
    SUM(A.BALANCE) AS TOTAL_BAL
FROM
    CUSTOMERS C
    JOIN ACCOUNTS A USING(CUSTOMERID)
WHERE
    A.ACCOUNTTYPE IN ('Savings', 'Checking')
GROUP BY
    1
ORDER BY
    2 DESC;
-- 10. Which branch has the highest number of transactions in the Transactions table?
SELECT
    B.BRANCHNAME,
    COUNT(T.TRANSACTIONID) AS TOTAL_TXN
FROM
    BRANCHES B
    JOIN ACCOUNTS A USING(BRANCHID)
    JOIN TRANSACTIONS T USING(ACCOUNTID)
GROUP BY
    1
ORDER BY
    2 DESC;