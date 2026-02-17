
-- TELECOM CUSTOMER CHURN ANALYSIS
-- End-to-End SQL Workflow
-- Includes:
--   • Database setup
--   • Data cleaning & validation
--   • Exploratory Data Analysis (EDA)
--   • Feature engineering


-- ============================================================
-- 1. DATABASE SETUP
-- ============================================================

-- Create database and use it
CREATE DATABASE telecochurn;
USE telecochurn;


-- Create table structure before importing CSV
CREATE TABLE telco_churn (
    customerID VARCHAR(50),
    gender VARCHAR(10),
    SeniorCitizen INT,
    Partner VARCHAR(10),
    Dependents VARCHAR(10),
    tenure INT,
    PhoneService VARCHAR(10),
    MultipleLines VARCHAR(50),
    InternetService VARCHAR(50),
    OnlineSecurity VARCHAR(50),
    OnlineBackup VARCHAR(50),
    DeviceProtection VARCHAR(50),
    TechSupport VARCHAR(50),
    StreamingTV VARCHAR(50),
    StreamingMovies VARCHAR(50),
    Contract VARCHAR(50),
    PaperlessBilling VARCHAR(10),
    PaymentMethod VARCHAR(50),
    MonthlyCharges DECIMAL(10,2),
    TotalCharges VARCHAR(50),
    Churn VARCHAR(10)
);


-- Verify imported tables
SHOW TABLES;

-- Check row count after CSV import
SELECT COUNT(*) FROM `telecom churn customer data`;

-- Rename imported table to clean name
RENAME TABLE `telecom churn customer data`
TO teleco_churn;

-- Preview dataset
SELECT * FROM teleco_churn;


-- ============================================================
-- 2. DATA CLEANING & VALIDATION
-- ============================================================

-- Handle missing TotalCharges values
SELECT COUNT(*) AS missing_totalcharges
FROM teleco_churn
WHERE TRIM(TotalCharges) = '';

SET SQL_SAFE_UPDATES = 0;

UPDATE teleco_churn
SET TotalCharges = NULL
WHERE TRIM(TotalCharges) = '';

-- Verify missing values handled
SELECT COUNT(*)
FROM teleco_churn
WHERE TotalCharges IS NULL;

-- Check missing values across key columns
SELECT
    SUM(CASE WHEN tenure IS NULL THEN 1 ELSE 0 END) AS tenure_missing,
    SUM(CASE WHEN MonthlyCharges IS NULL THEN 1 ELSE 0 END) AS monthly_missing,
    SUM(CASE WHEN Churn IS NULL THEN 1 ELSE 0 END) AS churn_missing
FROM teleco_churn;


-- Fix data types (TotalCharges from text to numeric)
DESCRIBE teleco_churn;

ALTER TABLE teleco_churn
MODIFY COLUMN TotalCharges DECIMAL(10,2);


-- Validate churn target variable
SELECT DISTINCT Churn FROM teleco_churn;


-- ============================================================
-- 3. EXPLORATORY DATA ANALYSIS (EDA)
-- ============================================================

-- Overall churn distribution
SELECT 
    Churn,
    COUNT(*) AS customer_count,
    ROUND(COUNT(*) * 100.0 /
    (SELECT COUNT(*) FROM teleco_churn), 2) AS percentage
FROM teleco_churn
GROUP BY Churn;


-- Average charges comparison
SELECT 
    Churn,
    ROUND(AVG(MonthlyCharges),2) AS avg_monthly_charge,
    ROUND(AVG(TotalCharges),2) AS avg_total_charge
FROM teleco_churn
GROUP BY Churn;


-- Contract type vs churn
SELECT 
    Contract,
    Churn,
    COUNT(*) AS customer_count
FROM teleco_churn
GROUP BY Contract, Churn
ORDER BY Contract;


-- Tenure comparison
SELECT 
    Churn,
    ROUND(AVG(tenure),1) AS avg_tenure
FROM teleco_churn
GROUP BY Churn;


-- Internet service impact on churn
SELECT 
    InternetService,
    Churn,
    COUNT(*) AS customer_count
FROM teleco_churn
GROUP BY InternetService, Churn;


-- ============================================================
-- 3(b). USAGE & ENGAGEMENT ANALYSIS
-- ============================================================

-- Tenure statistics
SELECT 
    Churn,
    MIN(tenure) AS min_tenure,
    MAX(tenure) AS max_tenure,
    ROUND(AVG(tenure),1) AS avg_tenure
FROM teleco_churn
GROUP BY Churn;


-- Tenure groups
SELECT
    CASE
        WHEN tenure <= 12 THEN '0-12 Months'
        WHEN tenure <= 24 THEN '13-24 Months'
        WHEN tenure <= 48 THEN '25-48 Months'
        ELSE '48+ Months'
    END AS tenure_group,
    Churn,
    COUNT(*) AS customers
FROM teleco_churn
GROUP BY tenure_group, Churn
ORDER BY tenure_group;


-- Monthly charge impact
SELECT 
    Churn,
    ROUND(AVG(MonthlyCharges),2) AS avg_monthly_charge
FROM teleco_churn
GROUP BY Churn;


-- Technical support engagement
SELECT
    TechSupport,
    Churn,
    COUNT(*) AS customers
FROM teleco_churn
GROUP BY TechSupport, Churn;


-- Payment method behaviour
SELECT 
    PaymentMethod,
    Churn,
    COUNT(*) AS customers
FROM teleco_churn
GROUP BY PaymentMethod, Churn;


-- ============================================================
-- 4. FEATURE ENGINEERING
-- ============================================================

-- Tenure group feature
SELECT *,
CASE
    WHEN tenure <= 12 THEN '0-12 Months'
    WHEN tenure <= 24 THEN '13-24 Months'
    WHEN tenure <= 48 THEN '25-48 Months'
    ELSE '48+ Months'
END AS tenure_group
FROM teleco_churn;


-- Contract churn risk indicator
SELECT *,
CASE
    WHEN Contract = 'Month-to-month'
         THEN 'High Risk'
    ELSE 'Low Risk'
END AS contract_risk
FROM teleco_churn;


-- Customer engagement score
SELECT *,
(
    (OnlineSecurity = 'Yes') +
    (OnlineBackup = 'Yes') +
    (DeviceProtection = 'Yes') +
    (TechSupport = 'Yes') +
    (StreamingTV = 'Yes') +
    (StreamingMovies = 'Yes')
) AS engagement_score
FROM teleco_churn;


-- Average monthly spend estimate
SELECT *,
ROUND(TotalCharges / NULLIF(tenure,0),2)
AS avg_monthly_spend
FROM teleco_churn;


-- Final dataset preview
SELECT * FROM teleco_churn;
