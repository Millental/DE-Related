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

Cdrop table product 

CREATE TABLE product
(
 product_id   varchar(50) NOT NULL,
 category     varchar(50)  NULL,
 subcategory  varchar(50)  NULL,
 product_name varchar(500)  NULL,
 CONSTRAINT PK_prod PRIMARY KEY ( product_id )
);
-- добавляю первиный ключ
insert into product 
select product_id from (select distinct product_id from orders) o;
-- по первичному ключу подтягива по очереди дистинктом все поля
UPDATE product
SET category = (
  SELECT distinct category
  FROM orders
  WHERE product_id = product.product_id
)
---------------Geo
CREATE table geography as (select g.postal_code, o.city, o.state, o.country, o.region, p.person
from geography g
join orders o on g.postal_code = o.postal_code
join people p on o.region = p.region)
-- и потом просто назначил postal_code как primary key
ALTER TABLE geography
CONSTRAINT PK_geo PRIMARY KEY ( postal_code )
