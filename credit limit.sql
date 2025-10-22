-- effect of limit balance. min 10000, max 800000

SELECT
  MIN(limit_balance) AS min_limit,
  MAX(limit_balance) AS max_limit,
  AVG(limit_balance) AS avg_limit,
FROM `bigquery-public-data.ml_datasets.credit_card_default`;



SELECT
  ROUND(AVG(limit_balance), 0) AS avg_credit_limit,
  AVG(CAST(default_payment_next_month AS int64)) AS default_rate
FROM `bigquery-public-data.ml_datasets.credit_card_default`;



--divide credit limits into three categories. 
--<50K, 37.4%
-- 50K-200K, 21.21%
-- 200K-500K,14.73%
-->500K , 0
--highest default expectation is for lower credit limts which is less than 50000 euro.
SELECT
  CASE
    WHEN limit_balance < 50000 THEN '<50K'
    WHEN limit_balance BETWEEN 50000 AND 200000 THEN '50K-200K'
    WHEN limit_balance BETWEEN 200000 AND 500000 THEN '200K-500K'
    ELSE '>500K'
  END AS credit_limit_range,
  AVG(CAST(default_payment_next_month AS int64)) AS default_rate_limit
FROM `bigquery-public-data.ml_datasets.credit_card_default`
GROUP BY credit_limit_range
ORDER BY credit_limit_range;


--we need more details like how many default customers are in the each group etc.
-- for that we can use below

WITH credit_data AS (
  SELECT 
    CAST(default_payment_next_month AS INT64) AS default_flag,
    CASE
      WHEN limit_balance < 50000 THEN '<50K'
      WHEN limit_balance BETWEEN 50000 AND 200000 THEN '50K-200K'
      WHEN limit_balance BETWEEN 200000 AND 500000 THEN '200K-500K'
      ELSE '>500K'
    END AS credit_limit_range
  FROM `bigquery-public-data.ml_datasets.credit_card_default`
)
SELECT
  credit_limit_range,
  COUNT(*) AS num_clients,
  SUM(default_flag) AS num_defaults,
  ROUND(SUM(default_flag)/SUM(SUM(default_flag)) OVER (), 3) AS proportion_of_total_defaults,
  ROUND(AVG(default_flag), 3) AS default_rate_within_group
FROM credit_data
GROUP BY credit_limit_range
ORDER BY credit_limit_range;

-- according to this, highest number of clients and defaulters are in the 50k-200k group. but default rate within the grou is low. >500k only has 14 customers and 0 defaulters. but <50k category has highest propotion of defalties within the group, though more than 50% of defaulters are from 50-200 group.