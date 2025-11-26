Q - Given the table icc_world_cups, the task is to calculate for each team Total Matches Played, Total Matches Won, Total Matches Lost.

---Schema

create table icc_world_cups
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);

---Sample Data

INSERT INTO icc_world_cups values('India','SL','India');
INSERT INTO icc_world_cups values('SL','Aus','Aus');
INSERT INTO icc_world_cups values('SA','Eng','Eng');
INSERT INTO icc_world_cups values('Eng','NZ','NZ');
INSERT INTO icc_world_cups values('Aus','India','India');

---Query

select * from icc_world_cups;

select Team_Name, COUNT(1) as No_of_Matches_Played, SUM(Win_Flag) as No_of_Matches_Won, 
COUNT(1) - SUM(Win_Flag) as No_of_Matches_Lost FROM 
(select team_1 as Team_Name , case when team_1=winner then 1 else 0 end as Win_Flag from  
icc_world_cups
union all
select Team_2 , case when team_2=winner then 1 else 0 end as Win_Flag from  icc_world_cups) A
Group by Team_Name
order by No_of_Matches_Won desc;

---Explanation

Each match contains two teams (team_1 and team_2).
Using UNION ALL, both teams from every match are combined into a single dataset so that we can perform team-wise calculations.

A Win_Flag is created using a CASE expression:

1 if the team won the match

0 if the team lost

Team-wise performance is calculated as:

COUNT(1) → Total matches played

SUM(Win_Flag) → Total matches won

COUNT(1) - SUM(Win_Flag) → Total matches lost

Results are sorted in descending order of wins so that the best-performing teams appear at the top.





