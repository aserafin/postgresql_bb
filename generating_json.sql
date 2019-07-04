with ranked_participants as (
  select
    name, 
    finished_at,
    age_category,
    rank() over w
  from 
    participants
  window w as (partition by age_category order by finished_at asc )
)
select json_agg(row_to_json(ranked_participants.*))  from ranked_participants where rank = 1;
