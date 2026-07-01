-- ================================================
-- CricInsight IPL Analytics Engine
-- Module 1 : Batting Analytics
-- Author : Sujal Sakla
-- ================================================

USE cricinsight;

-- Task 1 : Top 10 all time run scorers
select batter,sum(batsman_runs) as total_runs from deliveries
group by batter
order by sum(batsman_runs) desc limit 10;

-- Task 2 : Strike rate per batter (min 200 balls)
  select batter,sum(batsman_runs)/count(*) *100 as strike_rate 
  from deliveries
  group by batter
  having count(ball)>200
  order by strike_rate desc
  limit 10;
  
  -- Task 3 : Most fours and sixes per batter
select batter,
sum(case when batsman_runs = 4 then 1 else 0 end) as four,
sum(case when batsman_runs = 6 then 1 else 0 end) as six
from deliveries
group by batter
ORDER BY (four + six) DESC
limit 10;

-- Task 4 : Total runs per season (JOIN)
select season,sum(total_runs) as most_score
from deliveries D
inner join matches M
on D.match_id=M.id
group by season;

