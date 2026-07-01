-- ================================================
-- CricInsight IPL Analytics Engine
-- Module 2 : Bowling + Advanced Batting Analytics
-- Author : Sujal Sakla
-- ================================================

USE cricinsight;

-- Task 1 : Phase wise strike rate per batter
select batter,
sum(case when `over` between 0 and 6 then batsman_runs else 0 end ) / nullif(sum(case when `over` between 0 and 6 then 1 else 0 end ),0) * 100 as powerlaystrike_rate,
sum(case when `over` between 7 and 15 then batsman_runs else 0 end ) / nullif(sum(case when `over` between 7 and 15 then 1 else 0 end ),0) * 100 as middlestrike_rate,
sum(case when `over` between 16 and 20 then batsman_runs else 0 end ) / nullif(sum(case when `over` between 16 and 20 then 1 else 0 end ),0) * 100 as deathstrike_rate
from deliveries
group by batter
having count(*)>200
ORDER BY powerlaystrike_rate DESC, middlestrike_rate DESC, deathstrike_rate DESC
limit 10;

-- Task 2 : Season rank per batter using window function
with my_cte as (
select D.batter, M.season,sum(batsman_runs) as total_runs
from deliveries D
inner join matches M
on D.match_id=M.id
group by batter,season)
select  batter, season, total_runs,
RANK() over (partition by season order by total_runs desc) as season_rank
from my_cte;

-- Task 3 : Bowling economy rate (min 300 balls)
select bowler,
sum(total_runs)/(count(*)/6) as Economy_Rate
from deliveries
group by bowler
having count(*)>300
order by Economy_Rate Asc
limit 10;


