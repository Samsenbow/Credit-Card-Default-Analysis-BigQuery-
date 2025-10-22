
--missing values check

SELECT
  SUM(CASE WHEN limit_balance IS NULL THEN 1 ELSE 0 END) AS missing_limit_balance,
  SUM(CASE WHEN sex IS NULL THEN 1 ELSE 0 END) AS missing_sex,
  SUM(CASE WHEN education_level IS NULL THEN 1 ELSE 0 END) AS missing_education,
  SUM(CASE WHEN marital_status IS NULL THEN 1 ELSE 0 END) AS missing_marriage,
  SUM(CASE WHEN age IS NULL THEN 1 ELSE 0 END) AS missing_age,
  SUM(CASE WHEN default_payment_next_month IS NULL OR default_payment_next_month = '' THEN 1 ELSE 0 END) AS missing_default
FROM `bigquery-public-data.ml_datasets.credit_card_default`;

-- no missing values here

-- find duplicate ID

SELECT 
  ID, COUNT(*) AS count
FROM `bigquery-public-data.ml_datasets.credit_card_default`
GROUP BY ID
HAVING COUNT(*) > 1;

-- no duplicate ID


-- cheking for outliers are tricky. first get summary stats for numeric variables (limit_balance)

SELECT
  MIN(limit_balance) AS min_limit,
  MAX(limit_balance) AS max_limit,
  AVG(limit_balance) AS avg_limit,
  STDDEV(limit_balance) AS std_limit
FROM `bigquery-public-data.ml_datasets.credit_card_default`;

--quantiles

SELECT
  APPROX_QUANTILES(limit_balance, 4) AS quartiles
FROM `bigquery-public-data.ml_datasets.credit_card_default`;

