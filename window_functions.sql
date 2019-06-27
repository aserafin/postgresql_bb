-- to calculate running total for each day we need to use window functions

-- since we want to have runnig total until the current row we need to order by date 
-- and take into account rows with unbound preceding and the current row

-- as a result of the query in the total column we will see 600 for every day of the month (except the last 2) and in running total we will see sum up until the current row

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