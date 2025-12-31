-- PaySim Fraud Analysis (SQLite)
-- Goal: Identify fraud patterns and signals using SQL-only analysis.
-- Table: paysim


-- 0) Quick check: what does the dataset look like?
-- Purpose: Confirm the table loaded correctly and preview columns/values.
select * 
from paysim limit 10;

-- 1) Schema check: what are the column types?
-- Purpose: understand data types and confirm columns imported as expected.
pragma table_info(paysim);


-- 2) Overall fraud rate: how common is fraud in this dataset?
select count(*) as total_transactions,
	SUM(isfraud) as fraud_cases,
	round(1.0*sum(isfraud)/count(*),4) as fraud_rate
FROM paysim;

-- 3) Risk by transaction type: which transaction types are most risky?
select type,
COUNT(*) as total_transactions,
sum(isfraud) as fraud_cases,
ROUND(1.0*sum(isfraud)/count(*),4) as fraud_rate
from paysim 
group by type
order by fraud_rate desc;


--4) Fraud vs transaction size: does fraud show up more with larger amounts?
select 
case 
	when amount<1000 then 'small'
	when amount between 1000 and 10000 then 'medium'
	else 'large'
end as amount_bucket,
count(*) as total_transactions,
sum(isfraud) as fraud_cases,
ROUND(1.0*sum(isfraud)/count(*),4) as fraud_rate
from paysim 
group by amount_bucket 
order by fraud_rate DESC;


-- 5) Balance mismatch signal: are mismatches more common in fraud vs non-fraud?
SELECT
  isFraud,
  COUNT(*) AS total_transactions,
  SUM(oldbalanceOrg - amount != newbalanceOrig) AS mismatch_cases,
  ROUND(1.0 * SUM(oldbalanceOrg - amount != newbalanceOrig) / COUNT(*), 4) AS mismatch_rate
FROM paysim
GROUP BY isFraud;

--6) Identify destination accounts involved in multiple confirmed fraudulent transactions.
SELECT
  nameDest,
  COUNT(*) AS fraud_attempts,
  SUM(amount) AS total_fraud_amount
FROM paysim
WHERE isFraud = 1
GROUP BY nameDest
HAVING COUNT(*) > 1
ORDER BY fraud_attempts DESC, total_fraud_amount DESC;


-- 7) Identify origin accounts involved in multiple confirmed fraudulent transactions.
SELECT
  nameOrig,
  COUNT(*) AS fraud_attempts,
  SUM(amount) AS total_fraud_amount
FROM paysim
WHERE isFraud = 1
GROUP BY nameOrig
HAVING COUNT(*) > 1
ORDER BY fraud_attempts DESC, total_fraud_amount DESC;

--8) Do the hours that have the most transactions mean they have the most fraud cases?
SELECT
  step,
  COUNT(*) AS total_transactions,
  sum(isFraud) AS fraud_cases,
  ROUND(1.0*SUM(isFraud)/COUNT(*),4) as fraud_rate
FROM paysim
GROUP BY step
ORDER BY total_transactions DESC;





