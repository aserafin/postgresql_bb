drop table sales;
create table if not exists sales
(
  date date,
  sku_code varchar,
  quantity integer,
  price numeric,
  id serial not null,
  constraint sales_pkey primary key (id)
);

truncate sales;

insert into sales values('2019-01-01', 'A001', 10, 100);
insert into sales values('2019-01-02', 'A001', 1, 100);
insert into sales values('2019-01-03', 'A001', 3, 100);
insert into sales values('2019-01-05', 'A001', 3, 100);

select date(day) as day from generate_series('2019-01-01', '2019-01-07', interval '1 day') as day;

with days as (
  select date(day) as day from generate_series('2019-01-01', '2019-01-07', interval '1 day') as day
)
select days.day, coalesce(sales.quantity * sales.price, 0) as total from days left join sales on (days.day = sales.date);
