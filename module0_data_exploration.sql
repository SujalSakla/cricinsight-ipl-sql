-- ================================================
-- CricInsight IPL Analytics Engine
-- Module 0 : Data Exploration
-- Author   : Sujal Sakla
-- ================================================

USE cricinsight;

-- Task 1 : Unique seasons in dataset
select distinct(season) from matches;

-- Task 2 : Total matches per season
select season, count(*) as played from matches
group by season;

-- Task 3 : All unique teams
select distinct team1 from matches;

-- Task 4 : Table structure
DESCRIBE matches;
DESCRIBE deliveries;

-- Task 5 : Matches with no result
select count(*) from matches 
where winner IS NULL;




