-- let's take a second look at the running totals query

with intervals as (
  select start, start + interval '1 day' as end
  from generate_series('2018-10-01', '2018-10-31', interval '1 day') as start
),
sales_grouped_by_day as (
  select intervals.start, coalesce(sum(quantity * price), 0) as total
  from intervals left join sales s on (
    s.sku_code = 'A001'
    and s.date >= intervals.start
    and s.date < intervals.end
  )
  group by intervals.start
)
select
  sales_grouped_by_day.start,
  total,
  sum(total) over (order by start asc rows between unbounded preceding and current row) as running_total
from
  sales_grouped_by_day

-- since we computed those values there is a high chance that we want to return them
-- via json api
-- we can do that with jbuilder or active model serializers but we can also
-- do it directly in the database

with intervals as (
  select start, start + interval '1 day' as end
  from generate_series('2018-10-01', '2018-10-31', interval '1 day') as start
),
sales_grouped_by_day as (
  select intervals.start, coalesce(sum(quantity * price), 0) as total
  from intervals left join sales s on (
    s.sku_code = 'A001'
    and s.date >= intervals.start
    and s.date < intervals.end
  )
  group by intervals.start
),
running_totals as (
  select
    sales_grouped_by_day.start,
    total,
    sum(total) over (order by start asc rows between unbounded preceding and current row) as running_total
  from
    sales_grouped_by_day)
select json_agg(row_to_json(running_totals.*)) from running_totals
