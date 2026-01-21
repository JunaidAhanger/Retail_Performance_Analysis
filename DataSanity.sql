SELECT count(*) FROM sales_raw;

-- WE wil check the date ranges of the dataset
SELECT MIN(TO_DATE(order_date, 'DD-MM-YYYY')) AS min_order_date,
MAX(TO_DATE(order_date, 'DD-MM-YYYY')) AS max_order_date
FROM sales_raw;

-- Are there any null values in sales, profit, region
SELECT COUNT(*) FILTER(WHERE sales is null) as sales_null,
COUNT(*) FILTER(WHERE profit is null) as profit_null,
COUNT(*) FILTER (WHERE region is null) as region_null
FROM sales_raw;

-- Are there any negative or zero values in sales and profit
SELECT COUNT(*) FILTER (WHERE sales <= 0) AS bad_sales,
COUNT(*) FILTER (WHERE profit < 0 ) AS loss_orders
FROM sales_raw;

-- Cardinality check on order_id and subcategory
SELECT COUNT(DISTINCT order_id) FROM sales_raw; 
SELECT COUNT(DISTINCT sub_category) FROM sales_raw;


