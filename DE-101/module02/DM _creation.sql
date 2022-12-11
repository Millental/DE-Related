-- Здесь я отражу весь ход запросов, посвященный лабе 2.4
-- я уже нарисовал Модель данных в SQLDBM.COM и теперь переношу потаблично с помощью скриптов свою модель в DBEAVER
-- ************************************** calendar

CREATE TABLE public.calendar
(
 order_date date NOT NULL,
 year       int NOT NULL,
 quarter    int NOT NULL,
 month      int NOT NULL,
 week       int NOT NULL,
 weekday    int NOT NULL,
 CONSTRAINT PK_1 PRIMARY KEY ( order_date )
);
-- сначала перенесем из материнской таблицы orders колонку "Order_date" - это наше некалькулируемое поле и первичный ключ в одном лице
insert into calendar 
select order_date from (select distinct order_date from orders) o

-- далее заполним все столбцы
update public.calendar 
set "year" = extract(year from cast(order_date as timestamp)),
"month" = extract(month from cast(order_date as timestamp)),
"week" = extract(week from cast(order_date as timestamp)),
"quarter" = extract(quarter from cast(order_date as timestamp)),
"weekday" = extract(isodow from cast(order_date as timestamp))
