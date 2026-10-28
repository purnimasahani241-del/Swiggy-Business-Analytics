
-- =====================================================
-- PROJECT: SWIGGY BUSINESS ANALYTICS
-- DATABASE: Swiggy
-- TOOL: MySQL
-- TABLE: Orders
-- =====================================================


-- QUERY 1: Total Orders
SELECT COUNT(*) AS Total_Orders
FROM Orders;


-- QUERY 2: Total Revenue
SELECT SUM(amount) AS Total_Revenue
FROM Orders;


-- QUERY 3: Average Order Value
SELECT ROUND(AVG(amount), 2) AS Average_Order_Value
FROM Orders;


-- QUERY 4: Highest Revenue City
SELECT
    city,
    SUM(amount) AS Total_Revenue
FROM Orders
GROUP BY city
ORDER BY Total_Revenue DESC
LIMIT 1;


-- QUERY 5: Revenue by City
SELECT
    city,
    COUNT(*) AS Total_Orders,
    SUM(amount) AS Total_Revenue
FROM Orders
GROUP BY city
ORDER BY Total_Revenue DESC;


-- QUERY 6: Most Popular Category
SELECT
    category,
    COUNT(*) AS Total_Orders
FROM Orders
GROUP BY category
ORDER BY Total_Orders DESC
LIMIT 1;


-- QUERY 7: Category-wise Revenue
SELECT
    category,
    COUNT(*) AS Total_Orders,
    SUM(amount) AS Total_Revenue
FROM Orders
GROUP BY category
ORDER BY Total_Revenue DESC;


-- QUERY 8: Second Highest Distinct Order Amount
SELECT DISTINCT amount
FROM Orders
WHERE amount IS NOT NULL
ORDER BY amount DESC
LIMIT 1 OFFSET 1;


-- QUERY 9: Highest Value Order
SELECT
    order_id,
    customer_name,
    amount
FROM Orders
ORDER BY amount DESC
LIMIT 1;


-- QUERY 10: Orders Above Average Amount
SELECT
    order_id,
    customer_name,
    amount
FROM Orders
WHERE amount > (
    SELECT AVG(amount)
    FROM Orders
)
ORDER BY amount DESC;


-- QUERY 11: Total Spending by Customer
SELECT
    customer_name,
    COUNT(*) AS Total_Orders,
    SUM(amount) AS Total_Spending
FROM Orders
GROUP BY customer_name
ORDER BY Total_Spending DESC;


-- QUERY 12: Rank Customers by Total Spending
SELECT
    customer_name,
    SUM(amount) AS Total_Spending,
    RANK() OVER (
        ORDER BY SUM(amount) DESC
    ) AS Customer_Rank
FROM Orders
GROUP BY customer_name;


-- QUERY 13: Assign Row Numbers to Orders
SELECT
    order_id,
    customer_name,
    amount,
    ROW_NUMBER() OVER (
        ORDER BY order_id
    ) AS row_num
FROM Orders;


-- QUERY 14: Categorize Orders by Amount
SELECT
    order_id,
    customer_name,
    amount,
    CASE
        WHEN amount <= 500 THEN 'Budget'
        WHEN amount <= 800 THEN 'Medium'
        ELSE 'Premium'
    END AS Order_Category
FROM Orders;


-- QUERY 15: Highest Revenue City Ranking
SELECT
    city,
    SUM(amount) AS Total_Revenue,
    DENSE_RANK() OVER (
        ORDER BY SUM(amount) DESC
    ) AS City_Rank
FROM Orders
GROUP BY city;


-- QUERY 16: Highest Spending Customer
SELECT
    customer_name,
    SUM(amount) AS Total_Spending
FROM Orders
GROUP BY customer_name
ORDER BY Total_Spending DESC
LIMIT 1;


-- QUERY 17: Lowest Value Order
SELECT
    order_id,
    customer_name,
    amount
FROM Orders
ORDER BY amount ASC
LIMIT 1;


-- QUERY 18: Number of Orders by Customer
SELECT
    customer_name,
    COUNT(*) AS Total_Orders
FROM Orders
GROUP BY customer_name
ORDER BY Total_Orders DESC;


-- QUERY 19: Orders by City and Category
SELECT
    city,
    category,
    COUNT(*) AS Total_Orders,
    SUM(amount) AS Total_Revenue
FROM Orders
GROUP BY city, category
ORDER BY city, Total_Revenue DESC;


-- QUERY 20: Overall Business Summary
SELECT
    COUNT(*) AS Total_Orders,
    SUM(amount) AS Total_Revenue,
    ROUND(AVG(amount), 2) AS Average_Order_Value,
    MAX(amount) AS Highest_Order_Amount,
    MIN(amount) AS Lowest_Order_Amount
FROM Orders;
