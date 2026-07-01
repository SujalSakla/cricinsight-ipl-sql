-- ================================================
-- CricInsight IPL Analytics Engine
-- Module 5 :  Season Trends + CREATE VIEW! 
-- Author : Sujal Sakla
-- ================================================

USE cricinsight;

select * from matches;
select * from deliveries;

-- Task 1 : Average runs per match per season
WITH match_total AS (
    SELECT match_id, SUM(total_runs) AS match_runs
    FROM deliveries
    GROUP BY match_id
)
SELECT M.season, AVG(match_runs) AS avg_per_match
FROM match_total MT
JOIN matches M ON MT.match_id = M.id
GROUP BY M.season
ORDER BY M.season;

-- Task 2 : Year over year comparison using LAG()
WITH match_total AS (
    SELECT match_id, SUM(total_runs) AS match_runs
    FROM deliveries
    GROUP BY match_id
),
new_cte AS (
    SELECT M.season, AVG(match_runs) AS avg_per_match
    FROM match_total MT
    JOIN matches M ON MT.match_id = M.id
    GROUP BY M.season
)
SELECT season, avg_per_match,
LAG(avg_per_match) OVER (ORDER BY season) AS prev_season_avg
FROM new_cte;

--  ================================================
-- PART 2 : DATABASE VIEWS (for Power BI Dashboard)
-- ================================================

-- View 1 : Batting Summary
CREATE VIEW v_batting_summary AS
SELECT batter, SUM(batsman_runs) AS total_runs
FROM deliveries
GROUP BY batter;

-- View 2 : Bowling Summary
CREATE VIEW v_bowling_summary AS
SELECT bowler,
SUM(total_runs) / (COUNT(*) / 6) AS Economy_Rate,
SUM(is_wicket) AS total_wickets
FROM deliveries
GROUP BY bowler
HAVING COUNT(*) > 300;

-- View 3 : Team Strategy Summary
CREATE VIEW v_team_strategy AS
SELECT toss_decision,
SUM(CASE WHEN toss_winner = winner THEN 1 ELSE 0 END) / COUNT(*) * 100 AS win_pct
FROM matches
GROUP BY toss_decision;

-- View 4 : Season Trends
CREATE VIEW v_season_trends AS
WITH match_total AS (
    SELECT match_id, SUM(total_runs) AS match_runs
    FROM deliveries
    GROUP BY match_id
)
SELECT M.season, AVG(match_runs) AS avg_per_match
FROM match_total MT
JOIN matches M ON MT.match_id = M.id
GROUP BY M.season;
show tables;