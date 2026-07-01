-- ================================================
-- CricInsight IPL Analytics Engine
-- Module 4 :  POTM Predictor!
-- Author : Sujal Sakla
-- ================================================

USE cricinsight;

with potm_cte as (
select match_id,batter,
(sum(batsman_runs)*1)+ (sum(is_wicket)*25) as performance_score
from deliveries D 
group by match_id,batter),
final_rank as(
select batter,match_id,
Rank() over(partition by match_id order by performance_score desc) as predicted_rank, M.player_of_match,
CASE WHEN batter = M.player_of_match THEN 'CORRECT' ELSE 'WRONG' END AS prediction
from potm_cte P
join matches M 
on p.match_id = M.id)
SELECT 
COUNT(*) AS total_predictions,
SUM(CASE WHEN prediction = 'CORRECT' THEN 1 ELSE 0 END) AS correct_predictions,
SUM(CASE WHEN prediction = 'CORRECT' THEN 1 ELSE 0 END) / COUNT(*) * 100 AS accuracy
FROM final_rank
WHERE predicted_rank = 1;


