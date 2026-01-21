-- Create the core table 'sales_analytics' from our sales_raw table
CREATE TABLE sales_analytics AS
SELECT
  order_id,
  TO_DATE(order_date,'DD-MM-YYYY') AS order_date,
  TO_DATE(ship_date,'DD-MM-YYYY') AS ship_date,
  region,
  category,
  sub_category,
  sales,
  profit,
  discount,
  (profit / NULLIF(sales,0)) AS profit_ratio,
  EXTRACT(YEAR FROM TO_DATE(order_date, 'DD-MM-YYYY')) AS order_year,
  EXTRACT(MONTH FROM TO_DATE(order_date, 'DD-MM-YYYY')) AS order_month,
  DATE_TRUNC('month', TO_DATE(order_date, 'DD-MM-YYYY')) AS order_month_start,
  (TO_DATE(ship_date, 'DD-MM-YYYY') - TO_DATE(order_date, 'DD-MM-YYYY')) AS shipping_days,
  CASE WHEN profit < 0 THEN 'Loss' WHEN (profit / NULLIF(sales,0)) < 0.1 THEN 'Low Margin' ELSE 'Healthy' END AS profitability_staus
FROM sales_raw;


-- Added country later
ALTER TABLE sales_analytics
ADD COLUMN country TEXT;

UPDATE sales_analytics a 
SET country = r.country
FROM sales_raw r
WHERE a.order_id = r.order_id;

SELECT * FROM sales_analytics

-- Copying sales_analytics table to csv as it turns out i can't afford paid tableau at the movement.
-- Need to change data type of order_month_start to DATE
ALTER TABLE sales_analytics
ALTER COLUMN order_month_start TYPE DATE;
--------------
COPY sales_analytics TO '/Users/junaidjaveed/Desktop/superstore_analysis/Data/sales_analytics.csv'
DELIMITER ','
CSV HEADER;


