-- Ice Cream Business Analysis using DuckDB
-- Load CSVs once for the session
CREATE OR REPLACE TABLE dim_date AS SELECT * FROM read_csv_auto('../14_data_warehouse/data/dim_date.csv');
CREATE OR REPLACE TABLE dim_customer AS SELECT * FROM read_csv_auto('../14_data_warehouse/data/dim_customer.csv');
CREATE OR REPLACE TABLE dim_product AS SELECT * FROM read_csv_auto('../14_data_warehouse/data/dim_product.csv');
CREATE OR REPLACE TABLE dim_store AS SELECT * FROM read_csv_auto('../14_data_warehouse/data/dim_store.csv');
CREATE OR REPLACE TABLE fact_sales AS SELECT * FROM read_csv_auto('../14_data_warehouse/data/fact_sales.csv');

-- 01 Highest sales day
SELECT d.date, SUM(f.sales_amount) AS total_sales
FROM fact_sales f JOIN dim_date d ON f.date_id=d.date_id
GROUP BY d.date ORDER BY total_sales DESC LIMIT 1;

-- 02 Lowest sales day
SELECT d.date, SUM(f.sales_amount) AS total_sales
FROM fact_sales f JOIN dim_date d ON f.date_id=d.date_id
GROUP BY d.date ORDER BY total_sales ASC LIMIT 1;

-- 03 Highest order day
SELECT d.date, COUNT(DISTINCT f.transaction_id) AS orders
FROM fact_sales f JOIN dim_date d ON f.date_id=d.date_id
GROUP BY d.date ORDER BY orders DESC LIMIT 1;

-- 04 Lowest order day among days with sales
SELECT d.date, COUNT(DISTINCT f.transaction_id) AS orders
FROM fact_sales f JOIN dim_date d ON f.date_id=d.date_id
GROUP BY d.date ORDER BY orders ASC, d.date ASC LIMIT 1;

-- 05 Daily sales with previous day and percentage change
WITH daily AS (SELECT d.date, SUM(f.sales_amount) sales FROM fact_sales f JOIN dim_date d ON f.date_id=d.date_id GROUP BY d.date)
SELECT date, sales, LAG(sales) OVER(ORDER BY date) previous_sales, ROUND(100*(sales-LAG(sales) OVER(ORDER BY date))/NULLIF(LAG(sales) OVER(ORDER BY date),0),2) pct_change FROM daily ORDER BY date;

-- 06 First significant sales decrease (>20%)
WITH daily AS (SELECT d.date, SUM(f.sales_amount) sales FROM fact_sales f JOIN dim_date d ON f.date_id=d.date_id GROUP BY d.date), x AS (SELECT *, LAG(sales) OVER(ORDER BY date) prev_sales FROM daily)
SELECT date, sales, prev_sales, ROUND(100*(sales-prev_sales)/NULLIF(prev_sales,0),2) pct_change FROM x WHERE prev_sales IS NOT NULL AND sales < prev_sales*0.80 ORDER BY date LIMIT 1;

-- 07 Best-selling product on a particular date: replace the date literal
SELECT d.date, p.product_name, SUM(f.quantity) units, SUM(f.sales_amount) sales
FROM fact_sales f JOIN dim_date d ON f.date_id=d.date_id JOIN dim_product p ON f.product_key=p.product_key
WHERE d.date = DATE '2026-06-15'
GROUP BY d.date,p.product_name ORDER BY units DESC, sales DESC;

-- 08 Best-selling product in a particular week
SELECT d.year, d.week_of_year, p.product_name, SUM(f.quantity) units, SUM(f.sales_amount) sales
FROM fact_sales f JOIN dim_date d ON f.date_id=d.date_id JOIN dim_product p ON f.product_key=p.product_key
WHERE d.year=2026 AND d.week_of_year=25
GROUP BY d.year,d.week_of_year,p.product_name ORDER BY units DESC;

-- 09 Best-selling product in each week
WITH weekly AS (SELECT d.year,d.week_of_year,p.product_name,SUM(f.quantity) units,SUM(f.sales_amount) sales FROM fact_sales f JOIN dim_date d ON f.date_id=d.date_id JOIN dim_product p ON f.product_key=p.product_key GROUP BY 1,2,3), ranked AS (SELECT *, ROW_NUMBER() OVER(PARTITION BY year,week_of_year ORDER BY units DESC,sales DESC) rn FROM weekly) SELECT * FROM ranked WHERE rn=1 ORDER BY year,week_of_year;

-- 10 Product with highest sales
SELECT p.product_name,SUM(f.sales_amount) sales,SUM(f.quantity) units FROM fact_sales f JOIN dim_product p ON f.product_key=p.product_key GROUP BY p.product_name ORDER BY sales DESC LIMIT 1;

-- 11 Product with lowest sales
SELECT p.product_name,SUM(f.sales_amount) sales,SUM(f.quantity) units FROM fact_sales f JOIN dim_product p ON f.product_key=p.product_key GROUP BY p.product_name ORDER BY sales ASC LIMIT 1;

-- 12 Highest-sales day for each product
WITH x AS (SELECT p.product_name,d.date,SUM(f.sales_amount) sales FROM fact_sales f JOIN dim_product p ON f.product_key=p.product_key JOIN dim_date d ON f.date_id=d.date_id GROUP BY 1,2), r AS (SELECT *,ROW_NUMBER() OVER(PARTITION BY product_name ORDER BY sales DESC,date) rn FROM x) SELECT * FROM r WHERE rn=1 ORDER BY product_name;

-- 13 Last day each product had an order
SELECT p.product_name,MAX(d.date) last_order_date FROM fact_sales f JOIN dim_product p ON f.product_key=p.product_key JOIN dim_date d ON f.date_id=d.date_id GROUP BY p.product_name ORDER BY last_order_date;

-- 14 First day each product had an order
SELECT p.product_name,MIN(d.date) first_order_date FROM fact_sales f JOIN dim_product p ON f.product_key=p.product_key JOIN dim_date d ON f.date_id=d.date_id GROUP BY p.product_name ORDER BY first_order_date;

-- 15 Product sales by month
SELECT d.year,d.month,d.month_name,p.product_name,SUM(f.sales_amount) sales,SUM(f.quantity) units FROM fact_sales f JOIN dim_date d ON f.date_id=d.date_id JOIN dim_product p ON f.product_key=p.product_key GROUP BY 1,2,3,4 ORDER BY 1,2,sales DESC;

-- 16 Store with highest sales
SELECT s.store_name,s.city,SUM(f.sales_amount) sales FROM fact_sales f JOIN dim_store s ON f.store_key=s.store_key GROUP BY 1,2 ORDER BY sales DESC LIMIT 1;

-- 17 Highest sales day by store
WITH x AS (SELECT s.store_name,d.date,SUM(f.sales_amount) sales FROM fact_sales f JOIN dim_store s ON f.store_key=s.store_key JOIN dim_date d ON f.date_id=d.date_id GROUP BY 1,2), r AS (SELECT *,ROW_NUMBER() OVER(PARTITION BY store_name ORDER BY sales DESC,date) rn FROM x) SELECT * FROM r WHERE rn=1;

-- 18 Customer with highest spend
SELECT c.customer_name,c.city,SUM(f.sales_amount) sales FROM fact_sales f JOIN dim_customer c ON f.customer_key=c.customer_key GROUP BY 1,2 ORDER BY sales DESC LIMIT 1;

-- 19 Sales by weekday
SELECT d.weekday,SUM(f.sales_amount) sales,COUNT(DISTINCT f.transaction_id) orders FROM fact_sales f JOIN dim_date d ON f.date_id=d.date_id GROUP BY d.weekday ORDER BY sales DESC;

-- 20 Sales by month
SELECT d.year,d.month,d.month_name,SUM(f.sales_amount) sales,COUNT(DISTINCT f.transaction_id) orders FROM fact_sales f JOIN dim_date d ON f.date_id=d.date_id GROUP BY 1,2,3 ORDER BY 1,2;

-- 21 Days when sales first fell below ₹50,000 (for this dataset threshold may need adjusting; query is reusable)
WITH daily AS (SELECT d.date,SUM(f.sales_amount) sales FROM fact_sales f JOIN dim_date d ON f.date_id=d.date_id GROUP BY d.date) SELECT * FROM daily WHERE sales < 50000 ORDER BY date LIMIT 1;

-- 22 Days when sales first fell below ₹1,00,000
WITH daily AS (SELECT d.date,SUM(f.sales_amount) sales FROM fact_sales f JOIN dim_date d ON f.date_id=d.date_id GROUP BY d.date) SELECT * FROM daily WHERE sales < 100000 ORDER BY date LIMIT 1;

-- 23 Last day with a selected product order
SELECT p.product_name,MAX(d.date) last_order_date FROM fact_sales f JOIN dim_product p ON f.product_key=p.product_key JOIN dim_date d ON f.date_id=d.date_id WHERE p.product_name='Vanilla' GROUP BY p.product_name;

-- 24 Last day with two orders (exactly 2 transactions)
WITH daily AS (SELECT d.date,COUNT(DISTINCT f.transaction_id) orders FROM fact_sales f JOIN dim_date d ON f.date_id=d.date_id GROUP BY d.date) SELECT * FROM daily WHERE orders=2 ORDER BY date DESC LIMIT 1;

-- 25 First day daily orders dropped from 2 to 1
WITH daily AS (SELECT d.date,COUNT(DISTINCT f.transaction_id) orders FROM fact_sales f JOIN dim_date d ON f.date_id=d.date_id GROUP BY d.date), x AS (SELECT *,LAG(orders) OVER(ORDER BY date) prev_orders FROM daily) SELECT * FROM x WHERE prev_orders=2 AND orders=1 ORDER BY date LIMIT 1;

-- 26 Days where a product had zero orders: build a date x product grid so missing facts become zero
WITH grid AS (SELECT d.date,p.product_key,p.product_name FROM dim_date d CROSS JOIN dim_product p), sales AS (SELECT f.date_id,f.product_key,SUM(f.quantity) units FROM fact_sales f GROUP BY 1,2) SELECT g.date,g.product_name,COALESCE(s.units,0) units FROM grid g LEFT JOIN sales s ON s.date_id=CAST(STRFTIME(g.date,'%Y%m%d') AS INTEGER) AND s.product_key=g.product_key WHERE COALESCE(s.units,0)=0 ORDER BY g.date,g.product_name;

-- 27 Last zero-order day for a selected product
WITH grid AS (SELECT d.date,p.product_key,p.product_name FROM dim_date d CROSS JOIN dim_product p), sales AS (SELECT f.date_id,f.product_key,SUM(f.quantity) units FROM fact_sales f GROUP BY 1,2), zeros AS (SELECT g.date,g.product_name FROM grid g LEFT JOIN sales s ON s.date_id=CAST(STRFTIME(g.date,'%Y%m%d') AS INTEGER) AND s.product_key=g.product_key WHERE COALESCE(s.units,0)=0) SELECT product_name,MAX(date) last_zero_order_date FROM zeros WHERE product_name='Vanilla' GROUP BY product_name;

-- 28 Product that was the only product selling on a day
WITH daily_products AS (SELECT d.date,COUNT(DISTINCT f.product_key) product_count FROM fact_sales f JOIN dim_date d ON f.date_id=d.date_id GROUP BY d.date), only_days AS (SELECT date FROM daily_products WHERE product_count=1) SELECT od.date,p.product_name,SUM(f.sales_amount) sales FROM only_days od JOIN dim_date d ON d.date=od.date JOIN fact_sales f ON f.date_id=d.date_id JOIN dim_product p ON p.product_key=f.product_key GROUP BY od.date,p.product_name ORDER BY od.date;

-- 29 Promotion-like analysis: if discount_rate > 0 represents a promotion
SELECT p.product_name,MIN(d.date) first_promo_day,MAX(d.date) last_promo_day,COUNT(DISTINCT d.date) promo_days FROM fact_sales f JOIN dim_product p ON f.product_key=p.product_key JOIN dim_date d ON f.date_id=d.date_id WHERE f.discount_rate>0 GROUP BY p.product_name ORDER BY last_promo_day;

-- 30 Last promotion day across all products
SELECT MAX(d.date) last_promotion_day FROM fact_sales f JOIN dim_date d ON f.date_id=d.date_id WHERE f.discount_rate>0;

-- 31 Daily sales pattern change using 7-day moving average
WITH daily AS (SELECT d.date,SUM(f.sales_amount) sales FROM fact_sales f JOIN dim_date d ON f.date_id=d.date_id GROUP BY d.date), x AS (SELECT *,AVG(sales) OVER(ORDER BY date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) moving_avg_7 FROM daily) SELECT * FROM x ORDER BY date;

-- 32 Sales by product and store
SELECT p.product_name,s.store_name,SUM(f.sales_amount) sales,SUM(f.quantity) units FROM fact_sales f JOIN dim_product p ON f.product_key=p.product_key JOIN dim_store s ON f.store_key=s.store_key GROUP BY 1,2 ORDER BY sales DESC;

-- 33 Sales by city and product
SELECT s.city,p.product_name,SUM(f.sales_amount) sales FROM fact_sales f JOIN dim_store s ON f.store_key=s.store_key JOIN dim_product p ON f.product_key=p.product_key GROUP BY 1,2 ORDER BY 1,sales DESC;

-- 34 Customer segment performance
SELECT c.segment,SUM(f.sales_amount) sales,COUNT(DISTINCT f.transaction_id) orders,SUM(f.quantity) units FROM fact_sales f JOIN dim_customer c ON f.customer_key=c.customer_key GROUP BY c.segment ORDER BY sales DESC;

-- 35 Top 5 products for every month
WITH x AS (SELECT d.year,d.month,p.product_name,SUM(f.sales_amount) sales FROM fact_sales f JOIN dim_date d ON f.date_id=d.date_id JOIN dim_product p ON f.product_key=p.product_key GROUP BY 1,2,3), r AS (SELECT *,ROW_NUMBER() OVER(PARTITION BY year,month ORDER BY sales DESC) rn FROM x) SELECT * FROM r WHERE rn<=5 ORDER BY year,month,rn;
