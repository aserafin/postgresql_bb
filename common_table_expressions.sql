create table if not exists sales
(
  date timestamp with time zone,
  sku_code varchar,
  quantity integer,
  price numeric,
  id serial not null,
  constraint sales_pkey primary key (id)
);

CREATE UNIQUE INDEX IF NOT EXISTS index_sales_sku_code_date
  ON sales
  USING btree
  (key COLLATE pg_catalog."default", date);

TRUNCATE sales;

insert into sales values('2018-10-01 11:00:00', 'A001', 2, 100.00);
insert into sales values('2018-10-01 12:00:00', 'A001', 4, 100.00);
insert into sales values('2018-10-02 11:00:00', 'A001', 2, 100.00);
insert into sales values('2018-10-02 12:00:00', 'A001', 4, 100.00);
insert into sales values('2018-10-03 11:00:00', 'A001', 2, 100.00);
insert into sales values('2018-10-03 12:00:00', 'A001', 4, 100.00);
insert into sales values('2018-10-04 11:00:00', 'A001', 2, 100.00);
insert into sales values('2018-10-04 12:00:00', 'A001', 4, 100.00);
insert into sales values('2018-10-05 11:00:00', 'A001', 2, 100.00);
insert into sales values('2018-10-05 12:00:00', 'A001', 4, 100.00);
insert into sales values('2018-10-06 11:00:00', 'A001', 2, 100.00);
insert into sales values('2018-10-06 12:00:00', 'A001', 4, 100.00);
insert into sales values('2018-10-07 11:00:00', 'A001', 2, 100.00);
insert into sales values('2018-10-07 12:00:00', 'A001', 4, 100.00);
insert into sales values('2018-10-08 11:00:00', 'A001', 2, 100.00);
insert into sales values('2018-10-08 12:00:00', 'A001', 4, 100.00);
insert into sales values('2018-10-09 11:00:00', 'A001', 2, 100.00);
insert into sales values('2018-10-09 12:00:00', 'A001', 4, 100.00);
insert into sales values('2018-10-10 11:00:00', 'A001', 2, 100.00);
insert into sales values('2018-10-10 12:00:00', 'A001', 4, 100.00);
insert into sales values('2018-10-11 11:00:00', 'A001', 2, 100.00);
insert into sales values('2018-10-11 12:00:00', 'A001', 4, 100.00);
insert into sales values('2018-10-12 11:00:00', 'A001', 2, 100.00);
insert into sales values('2018-10-12 12:00:00', 'A001', 4, 100.00);
insert into sales values('2018-10-13 11:00:00', 'A001', 2, 100.00);
insert into sales values('2018-10-13 12:00:00', 'A001', 4, 100.00);
insert into sales values('2018-10-14 11:00:00', 'A001', 2, 100.00);
insert into sales values('2018-10-14 12:00:00', 'A001', 4, 100.00);
insert into sales values('2018-10-15 11:00:00', 'A001', 2, 100.00);
insert into sales values('2018-10-15 12:00:00', 'A001', 4, 100.00);
insert into sales values('2018-10-16 11:00:00', 'A001', 2, 100.00);
insert into sales values('2018-10-16 12:00:00', 'A001', 4, 100.00);
insert into sales values('2018-10-17 11:00:00', 'A001', 2, 100.00);
insert into sales values('2018-10-17 12:00:00', 'A001', 4, 100.00);
insert into sales values('2018-10-18 11:00:00', 'A001', 2, 100.00);
insert into sales values('2018-10-18 12:00:00', 'A001', 4, 100.00);
insert into sales values('2018-10-19 11:00:00', 'A001', 2, 100.00);
insert into sales values('2018-10-19 12:00:00', 'A001', 4, 100.00);
insert into sales values('2018-10-20 11:00:00', 'A001', 2, 100.00);
insert into sales values('2018-10-20 12:00:00', 'A001', 4, 100.00);
insert into sales values('2018-10-21 11:00:00', 'A001', 2, 100.00);
insert into sales values('2018-10-21 12:00:00', 'A001', 4, 100.00);
insert into sales values('2018-10-22 11:00:00', 'A001', 2, 100.00);
insert into sales values('2018-10-22 12:00:00', 'A001', 4, 100.00);
insert into sales values('2018-10-23 11:00:00', 'A001', 2, 100.00);
insert into sales values('2018-10-23 12:00:00', 'A001', 4, 100.00);
insert into sales values('2018-10-24 11:00:00', 'A001', 2, 100.00);
insert into sales values('2018-10-24 12:00:00', 'A001', 4, 100.00);
insert into sales values('2018-10-25 11:00:00', 'A001', 2, 100.00);
insert into sales values('2018-10-25 12:00:00', 'A001', 4, 100.00);
insert into sales values('2018-10-26 11:00:00', 'A001', 2, 100.00);
insert into sales values('2018-10-26 12:00:00', 'A001', 4, 100.00);
insert into sales values('2018-10-27 11:00:00', 'A001', 2, 100.00);
insert into sales values('2018-10-27 12:00:00', 'A001', 4, 100.00);
insert into sales values('2018-10-28 11:00:00', 'A001', 2, 100.00);
insert into sales values('2018-10-28 12:00:00', 'A001', 4, 100.00);
insert into sales values('2018-10-29 11:00:00', 'A001', 2, 100.00);
insert into sales values('2018-10-29 12:00:00', 'A001', 4, 100.00);

-- we want to get data about daily sum of sales for the product and the running total up to current date
-- there is no guarantee that there always be sales for every day
-- so if we simply group by the date there might be "holes"

-- because of that we will start with generating all possible 1-day perdiods
-- with another postgresql gem generate_series

select start, start + interval '1 day' as end
from generate_series('2018-10-01', '2018-10-31', interval '1 day') as start;

-- CTE is a way to make your SQL queries more readable

with intervals as (
  select start, start + interval '1 day' as end
  from generate_series('2018-10-01', '2018-10-31', interval '1 day') as start
)
select * from intervals;

-- now lets join the sales data
with intervals as (
  select start, start + interval '1 day' as end
  from generate_series('2018-10-01', '2018-10-31', interval '1 day') as start
)
select
  intervals.start, intervals.end, s.*
from
  intervals left join sales s on (
    s.sku_code = 'A001'
    and s.date >= intervals.start
    and s.date < intervals.end
);
