-- Посчитаем различные метрики с использованием языка SQL
-- предварительно загрузили в DBEAVER-POSTGRES-LOCALHOST  три файла, создали из них три таблицы
-- ORDERS RETURNS PEOPLE
1
SELECT sum(sales) total
FROM orders
