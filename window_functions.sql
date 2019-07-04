drop table participants;

create table participants (
  name varchar,
  finished_at timestamp with time zone,
  age_category varchar  
);

truncate participants;

insert into participants values ('John', '2019-01-01 8:00:12', 'kids');
insert into participants values ('Robert', '2019-01-01 8:05:12', 'kids');

insert into participants values ('Jane', '2019-01-01 8:01:12', 'adults');
insert into participants values ('Jennifer', '2019-01-01 8:01:15', 'adults');

with ranked_participants as (
  select
    name, 
    finished_at,
    age_category,
    rank() over w
  from 
    participants
  window w as (partition by age_category order by finished_at asc)
)
select * from ranked_participants where rank = 1;
