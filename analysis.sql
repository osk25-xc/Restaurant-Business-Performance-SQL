-- Restaurant Business Performance | PostgreSQL
-- Synthetic restaurant order data for portfolio practice.
DROP TABLE IF EXISTS restaurant_orders;
CREATE TABLE restaurant_orders (
 order_id INT PRIMARY KEY, outlet VARCHAR(25), order_ts TIMESTAMP,
 menu_category VARCHAR(25), order_channel VARCHAR(20), amount NUMERIC(10,2),
 prep_minutes INT, rating NUMERIC(2,1)
);
INSERT INTO restaurant_orders VALUES
(1,'Pune-Central','2026-01-02 12:15','Meals','Dine-in',650,18,4.5),
(2,'Pune-Central','2026-01-02 19:40','Beverages','Delivery',220,12,4.1),
(3,'Mumbai-West','2026-01-03 13:10','Meals','Delivery',780,25,3.9),
(4,'Nashik-Road','2026-01-03 20:05','Snacks','Takeaway',340,14,4.3),
(5,'Pune-Central','2026-01-04 20:20','Meals','Dine-in',920,22,4.7),
(6,'Mumbai-West','2026-01-05 11:50','Beverages','Takeaway',180,8,4.0),
(7,'Nashik-Road','2026-01-06 14:30','Meals','Delivery',560,28,3.7),
(8,'Pune-Central','2026-01-07 18:45','Snacks','Delivery',410,16,4.2),
(9,'Mumbai-West','2026-01-08 20:10','Meals','Dine-in',1050,24,4.6),
(10,'Nashik-Road','2026-01-09 19:15','Beverages','Delivery',260,11,4.4),
(11,'Pune-Central','2026-01-10 13:05','Meals','Takeaway',720,19,4.5),
(12,'Mumbai-West','2026-01-11 21:00','Snacks','Delivery',390,17,3.8);
-- 1. Sales and service KPIs
SELECT COUNT(*) AS orders, SUM(amount) AS sales, ROUND(AVG(amount),2) AS avg_order_value,
 ROUND(AVG(prep_minutes),1) AS avg_prep_minutes, ROUND(AVG(rating),2) AS avg_rating
FROM restaurant_orders;
-- 2. Outlet scorecard
SELECT outlet, COUNT(*) AS orders, SUM(amount) AS sales, ROUND(AVG(rating),2) AS avg_rating
FROM restaurant_orders GROUP BY outlet ORDER BY sales DESC;
-- 3. Menu category mix
SELECT menu_category, COUNT(*) AS orders, SUM(amount) AS sales
FROM restaurant_orders GROUP BY menu_category ORDER BY sales DESC;
-- 4. Channel performance
SELECT order_channel, COUNT(*) AS orders, SUM(amount) AS sales,
 ROUND(AVG(prep_minutes),1) AS avg_prep
FROM restaurant_orders GROUP BY order_channel;
-- 5. Peak hour demand
SELECT EXTRACT(HOUR FROM order_ts) AS hour_of_day, COUNT(*) AS orders, SUM(amount) AS sales
FROM restaurant_orders GROUP BY 1 ORDER BY orders DESC;
-- 6. Prep-time bottlenecks
SELECT outlet, menu_category, ROUND(AVG(prep_minutes),1) AS avg_prep_minutes
FROM restaurant_orders GROUP BY outlet,menu_category ORDER BY avg_prep_minutes DESC;
-- 7. Rating distribution
SELECT rating, COUNT(*) AS review_count FROM restaurant_orders GROUP BY rating ORDER BY rating;
-- 8. Daily sales trend
SELECT order_ts::date AS order_day, COUNT(*) AS orders, SUM(amount) AS sales
FROM restaurant_orders GROUP BY 1 ORDER BY 1;
