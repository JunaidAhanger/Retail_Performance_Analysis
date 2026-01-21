---CREATE sales table

CREATE TABLE sales_raw (
  row_id NUMERIC,
  order_id TEXT,
  order_date DATE,
  ship_date DATE,
  ship_mode TEXT,
  customer_id TEXT,
  customer_name TEXT,
  segment TEXT,
  city TEXT,
  state TEXT,
  country TEXT,
  postal_code TEXT,
  market TEXT,
  region TEXT,
  product_id TEXT,
  category TEXT,
  sub_category TEXT,
  product_name TEXT,
  sales NUMERIC,
  quantity NUMERIC,
  discount NUMERIC,
  profit NUMERIC,
  shipping_cost NUMERIC,
  order_priority TEXT);
--import csv
-- fix the data type problem in order_date and ship_date columns
ALTER TABLE sales_raw
ALTER COLUMN order_date TYPE TEXT,
ALTER COLUMN ship_date TYPE TEXT;

-- Faced error: ERROR:  invalid byte sequence for encoding "UTF8": 0xe1 0x72 0x65
-- CONTEXT:  COPY sales_raw, line 26 FIX:
TRUNCATE TABLE sales_raw;
COPY sales_raw
FROM '//Users/junaidjaveed/Desktop/superstore_analysis/Data/Global_Superstore2.csv'
DELIMITER ','
CSV HEADER
ENCODING 'LATIN1';

-- Check if data is imported
SELECT COUNT(*) FROM sales_raw;

  
