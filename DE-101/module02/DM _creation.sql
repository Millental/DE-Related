-- Здесь я отражу весь ход запросов, посвященный лабе 2.4
-- я уже нарисовал Модель данных в SQLDBM.COM и теперь переношу потаблично с помощью скриптов свою модель в DBEAVER
-- ************************************** calendar

CREATE TABLE public.calendar
(
 order_date date NOT NULL,
 year       int NULL,
 quarter    int  NULL,
 month      int  NULL,
 week       int  NULL,
 weekday    int  NULL,
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

-- ************************************** product

CREATE TABLE product
(
 product_id   varchar(50) NOT NULL,
 category     varchar(50) NOT NULL,
 subcategory  varchar(50) NOT NULL,
 product_name varchar(50) NOT NULL,
 segment      varchar(50) NOT NULL,
 CONSTRAINT PK_1 PRIMARY KEY ( product_id )
);
