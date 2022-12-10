-- Посчитаем различные метрики с использованием языка SQL
-- предварительно загрузили в DBEAVER-POSTGRES-LOCALHOST  три файла, создали из них три таблицы
-- ORDERS RETURNS PEOPLE
--total sales
SELECT SUM(sales) total
FROM orders
--total profit
SELECT SUM(profit) total
FROM orders
--profit ratio
SELECT SUM(profit)/SUM(sales) ratio 
FROM orders
--Profit per Order
SELECT SUM(profit)/count(distinct order_id) PPO
FROM orders
--Sales per Customer
select SUM(sales)/COUNT(distinct customer_id) SPC
from orders
-- Avg. Discount
SELECT AVG(discount)
from orders
--Monthly Sales by Segment 
select  segment, extract(month from cast(order_date as timestamp)) monthly, sum(sales) amount
from orders o 
group by segment, monthly
order by segment, monthly
--Monthly Sales by Product Category 
select  category, extract(month from cast(order_date as timestamp)) monthly, sum(sales) amount
from orders o 
group by category, monthly
order by category, monthly
--Sales and Profit by Customer - отсортировал по прибыльности, заодно получил CUSTOMER RANKING
select customer_name customer, sum(sales) amount, sum(profit) profit
from orders o
group by customer_name 
order by profit desc
--Sales per region, отсортировал по прибыльности
select region, sum(sales) amount, sum(profit) profit
from orders o
group by region 
order by profit desc

