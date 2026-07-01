-- ================================================
-- CricInsight IPL Analytics Engine
-- Module 3 : Team Strategy Analysis!
-- Author : Sujal Sakla
-- ================================================

use cricinsight;
select * from matches;
select * from deliveries;

-- Task 1 — Toss Advantage Analysis
select toss_decision,
SUM(CASE WHEN toss_winner = winner THEN 1 ELSE 0 END) / COUNT(*) * 100 as Luck
from matches
group by toss_decision; 

-- Task 2 — Best chasing teams!
select team2,
SUM(CASE WHEN team2 = winner THEN 1 ELSE 0 END) / COUNT(*) * 100 as LUCKY
from matches
group by team2
order by LUCKY desc;

-- Task 3 — Venue win rate analysis
 select venue,winner,
 count(*) as venue_winner
 from matches
 group by venue,winner
 having count(*) > 5
 order by venue_winner desc;