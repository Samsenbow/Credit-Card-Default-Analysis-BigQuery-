-- now lets try to find demographic variations. there are four demographic details in the data set.education, sex, age, and marital status.
-- for this GROUP BY can be used

-- first education. there are five education levels. let's try to find average default rate for each eduaction level.
-- find avg default rate which is group by education_level

SELECT
 education_level,
 ROUND(AVG(CAST(default_payment_next_month AS FLOAT64)), 3) AS default_rate
FROM `bigquery-public-data.ml_datasets.credit_card_default`
GROUP BY education_level
ORDER BY default_rate DESC;

-- there are 6 education levels, but 5 and 6 both label as "unknown" and the highest default rate is for 6 - unknown.6,2,3,1,5,4 is the order. default rate for category 4 is 0. and 4 is for other.

-- now lets move to sex

SELECT
 sex,
 ROUND(AVG(CAST(default_payment_next_month AS FLOAT64)), 3) AS default_rate_sex
FROM `bigquery-public-data.ml_datasets.credit_card_default`
GROUP BY sex
ORDER BY default_rate_sex DESC;

-- 1 male 22.5% , 2 female 20.7%

--marital status

SELECT
 marital_status,
 ROUND(AVG(CAST(default_payment_next_month AS FLOAT64)), 3) AS default_rate_marital
FROM `bigquery-public-data.ml_datasets.credit_card_default`
GROUP BY marital_status
ORDER BY default_rate_marital DESC;

-- 1 married 22.7%, 2 unmarried 20.5%, 3 other 17.1%


-- age. age is in years. 

SELECT
  MIN(age) AS min_age,
  MAX(age) AS max_age,
  AVG(age) AS avg_age,
FROM `bigquery-public-data.ml_datasets.credit_card_default`;

--min 21, max 69, avg 35.2


--i divide age into three groups. 21-37, 37-53 and greater than 53.

SELECT
  CASE
    WHEN age < 37 THEN 'Under 37'
    WHEN age BETWEEN 37 AND 53 THEN '37-53'
    ELSE 'Over 53'
  END AS age_group,
  ROUND(AVG(CAST(default_payment_next_month AS FLOAT64)), 3) AS default_rate_age
FROM `bigquery-public-data.ml_datasets.credit_card_default`
GROUP BY age_group
ORDER BY default_rate_age DESC;

-- under 37, 20.9%, 37-53 22.1%, over 53, 24.2%. when age goes up, average default rate goes up too.


