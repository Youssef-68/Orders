-- find top 10 highest renvue generating products
SELECT top 10 Product_Id, sum(Final_Price) as Sales FROM [orders].[dbo].[python]
GROUP BY Product_Id
ORDER BY Sales DESC;


--Sales by Category
SELECT Category, sum(Final_Price) as Sales FROM [orders].[dbo].[python]
GROUP BY Category
ORDER BY Category DESC;


--Unites sold by Category
SELECT Category, count(*) as units_sold FROM [orders].[dbo].[python]
GROUP BY Category
ORDER BY units_sold DESC;



--Sales by month
SELECT top 10 month(Order_Date) as order_month, year(Order_Date) as order_year, sum(Final_Price) as Sales FROM [orders].[dbo].[python]
GROUP BY Order_Date
ORDER BY Sales DESC;


--Sales by Region
SELECT Region, sum(Final_Price) AS Sales FROM [orders].[dbo].[python]
GROUP BY Region
ORDER BY Sales DESC;


--find month over month growth comparison for 2022 and 2023 sales eg : jan 2022 vs jan 2023
WITH mom as (
SELECT year(Order_Date) as order_year, month(Order_Date) as order_month,sum(Final_Price) as Sales FROM [orders].[dbo].[python]
GROUP BY year(order_date),month(order_date) )

SELECT order_month
, sum(case when order_year=2022 then sales else 0 end) as sales_2022
, sum(case when order_year=2023 then sales else 0 end) as sales_2023
FROM mom 
GROUP BY order_month
ORDER BY order_month;


--for each category which month had highest sales 
WITH monthly_sales as (
SELECT Category, month(Order_Date) as order_month, sum(Final_Price) as total_sales FROM [orders].[dbo].[python]
GROUP BY Category, month(Order_Date)
),
ranked_sales as (
SELECT *, RANK() OVER (PARTITION BY Category ORDER BY total_sales DESC) as sales_rank
FROM monthly_sales
)
SELECT Category, order_month, total_sales
FROM ranked_sales
WHERE sales_rank = 1
ORDER BY Category;
