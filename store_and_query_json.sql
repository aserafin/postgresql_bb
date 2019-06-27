CREATE TABLE IF NOT EXISTS orders (
  id integer,
  info jsonb
);

insert into orders values(1, '{"price": 100, "tax": 10, "items": [{"sku_code": "A001", "quantity": 1}, {"sku_code": "A003", "quantity": 2}]}');
insert into orders values(2, '{"price": 200, "tax": 20, "items": [{"sku_code": "A002", "quantity": 5}]}');

-- now we can select elements of info field as json

select info->'price', info->'tax' from orders;

-- or as text

select info->>'price', info->>'tax' from orders;

-- let's say we want to show first item of each order

select info#>'{items, 0}' from orders;

-- let's say we want to see all sku_code grouped by order

select orders.id, array_agg(items.value->>'sku_code') from orders, jsonb_array_elements(orders.info->'items') as items group by orders.id;

-- let's say we want to know how many items in each order
select id, jsonb_array_length(info->'items') from orders;

-- let's say we want orders with sku_code A001
select * from orders where info->'items' @> '[{"sku_code": "A001"}]'

-- let's say we want to sum quantity inside items
select sum(cast(items.value->>'quantity' as integer)) from orders, jsonb_array_elements(orders.info->'items') as items group by orders.id;
