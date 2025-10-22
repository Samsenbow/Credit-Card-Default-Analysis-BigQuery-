-- default.payment.next.month: Default payment (1=yes, 0=no), therefore, the sum of default.payment.next.month gives the 
-- number of clients are likey to be default in next month

SELECT 
  SUM(CAST(default_payment_next_month AS int64)) AS sum_default_rate
FROM `bigquery-public-data.ml_datasets.credit_card_default`;

-- 635 clients will expect to be default next month. now lets move to find average

SELECT 
  AVG(CAST(default_payment_next_month AS int64)) AS avg_default_rate
FROM `bigquery-public-data.ml_datasets.credit_card_default`;

-- average rate of default is 0.214165261382 around 21%.
