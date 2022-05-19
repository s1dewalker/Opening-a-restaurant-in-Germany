--ADDING CITY NAMES

select * from resto..Berlin_resto$

ALTER TABLE resto..Berlin_resto$
ADD City varchar(255)

UPDATE resto..Berlin_resto$
SET    City = 'Berlin';

--------------------------------------------------

select * from resto..Dortmund_resto$

ALTER TABLE resto..Dortmund_resto$
ADD City varchar(255)

UPDATE resto..Dortmund_resto$
SET    City = 'Dortmund';

--------------------------------------------------

select * from resto..Duesseldorf_resto$

ALTER TABLE resto..Duesseldorf_resto$
ADD City varchar(255)

UPDATE resto..Duesseldorf_resto$
SET    City = 'Duesseldorf';

--------------------------------------------------

select * from resto..Essen_resto$

ALTER TABLE resto..Essen_resto$
ADD City varchar(255)

UPDATE resto..Essen_resto$
SET    City = 'Essen';

--------------------------------------------------

select * from resto..Frankfurt_resto$

ALTER TABLE resto..Frankfurt_resto$
ADD City varchar(255)

UPDATE resto..Frankfurt_resto$
SET    City = 'Frankfurt';

--------------------------------------------------

select * from resto..Hamburg_resto$

ALTER TABLE resto..Hamburg_resto$
ADD City varchar(255)

UPDATE resto..Hamburg_resto$
SET    City = 'Hamburg';

--------------------------------------------------

select * from resto..Hannover_resto$

ALTER TABLE resto..Hannover_resto$
ADD City varchar(255)

UPDATE resto..Hannover_resto$
SET    City = 'Hannover';

--------------------------------------------------

select * from resto..Leipzig_resto$

ALTER TABLE resto..Leipzig_resto$
ADD City varchar(255)

UPDATE resto..Leipzig_resto$
SET    City = 'Leipzig';

--------------------------------------------------

select * from resto..Munich_resto$

ALTER TABLE resto..Munich_resto$
ADD City varchar(255)

UPDATE resto..Munich_resto$
SET    City = 'Munich';

--------------------------------------------------

select * from resto..Stuttgart_resto$

ALTER TABLE resto..Stuttgart_resto$
ADD City varchar(255)

UPDATE resto..Stuttgart_resto$
SET    City = 'Stuttgart';

--------------------------------------------------

select * from resto..Bielefeld_resto$

ALTER TABLE resto..Bielefeld_resto$
ADD City varchar(255)

UPDATE resto..Bielefeld_resto$
SET    City = 'Bielefeld';

--------------------------------------------------

select * from resto..Bochum_resto$

ALTER TABLE resto..Bochum_resto$
ADD City varchar(255)

UPDATE resto..Bochum_resto$
SET    City = 'Bochum';

ALTER TABLE resto..Bochum_resto$
ALTER COLUMN [min price] nvarchar(255)

ALTER TABLE resto..Bochum_resto$
ALTER COLUMN [max price] nvarchar(255)

--------------------------------------------------

select * from resto..Bonn_resto$

ALTER TABLE resto..Bonn_resto$
ADD City varchar(255)

UPDATE resto..Bonn_resto$
SET    City = 'Bonn';

--------------------------------------------------

select * from resto..Dresden_resto$

ALTER TABLE resto..Dresden_resto$
ADD City varchar(255)

UPDATE resto..Dresden_resto$
SET    City = 'Dresden';

--------------------------------------------------

select * from resto..Duisburg_resto$

ALTER TABLE resto..Duisburg_resto$
ADD City varchar(255)

UPDATE resto..Duisburg_resto$
SET    City = 'Duisburg';

ALTER TABLE resto..Duisburg_resto$
ALTER COLUMN [min price] nvarchar(255)

ALTER TABLE resto..Duisburg_resto$
ALTER COLUMN [max price] nvarchar(255)

--------------------------------------------------

select * from resto..Mannheim_resto$

ALTER TABLE resto..Mannheim_resto$
ADD City varchar(255)

UPDATE resto..Mannheim_resto$
SET    City = 'Mannheim';

--------------------------------------------------

select * from resto..Wuppertal_resto$

ALTER TABLE resto..Wuppertal_resto$
ADD City varchar(255)

UPDATE resto..Wuppertal_resto$
SET    City = 'Wuppertal';

--------------------------------------------------

select * from resto..Cologne_resto$

ALTER TABLE resto..Cologne_resto$
ADD City varchar(255)

UPDATE resto..Cologne_resto$
SET    City = 'Cologne';

--------------------------------------------------

select * from resto..Karlsruhe_resto$

ALTER TABLE resto..Karlsruhe_resto$
ADD City varchar(255)

UPDATE resto..Karlsruhe_resto$
SET    City = 'Karlsruhe';

ALTER TABLE resto..Karlsruhe_resto$
ALTER COLUMN [min price] nvarchar(255)

ALTER TABLE resto..Karlsruhe_resto$
ALTER COLUMN [max price] nvarchar(255)
--------------------------------------------------

select * from resto..Nuremberg_resto$

ALTER TABLE resto..Nuremberg_resto$
ADD City varchar(255)

UPDATE resto..Nuremberg_resto$
SET    City = 'Nuremberg';

--------------------------------------------------

--Finding the data type to be changed

SELECT
  *
FROM
  resto.INFORMATION_SCHEMA.TABLES;
GO

SELECT DATA_TYPE 
FROM resto.INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME   = 'Berlin_resto$'
SELECT DATA_TYPE 
FROM resto.INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME   = 'Karlsruhe_resto$' 

SELECT COLUMN_NAME
FROM resto.INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME   = 'Berlin_resto$'

--Creating a new final table

drop table if exists final_table
select a.* 
into   final_table
from   resto..Berlin_resto$ a
union all
select b.* from   resto..Dortmund_resto$ b
union all
select c.* from resto..Duesseldorf_resto$ c
union all
select d.* from resto..Essen_resto$ d
union all
select e.* from resto..Frankfurt_resto$ e
union all
select f.* from resto..Hamburg_resto$ f
union all
select g.* from resto..Hannover_resto$ g
union all
select h.* from resto..Leipzig_resto$ h
union all
select i.* from resto..Munich_resto$ i
union all
select j.* from resto..Stuttgart_resto$ j
union all
select k.* from resto..Bielefeld_resto$ k
union all
select l.* from resto..Bonn_resto$ l
union all
select m.* from resto..Dresden_resto$ m
union all
select n.* from resto..Mannheim_resto$ n
union all
select o.* from resto..Wuppertal_resto$ o
union all
select p.* from resto..Cologne_resto$ p
union all
select q.* from resto..Nuremberg_resto$ q
union all
select r.* from resto..Bochum_resto$ r
union all
select s.* from resto..Duisburg_resto$ s
union all
select t.* from resto..Karlsruhe_resto$ t

select * from final_table

select city, avg(rating) from final_table group by City

select name, latitude, longitude, Bar, Italian, Japanese, American, Steakhouse, Cafe, Indian, Asian, Healthy, German, 
[Central European], Mediterranean, European, [Vegan Options], [Gluten Free Options], Seafood, rating_category, top1 from
(select *, case when rank1>1 then 'Not Top 1%' else 'Top 1%'end top1 from
(select *, (ranking_position/ranking_denominator)*100 as rank1 from final_table) t1) t2

select City, count(*) from final_table
where Cafe = 'Available'
group by City

--AFTER CLUSTERING
select * from resto..Cluster

select City, count(*) cafes from final_table
where Steakhouse = 'Available'
group by City order by 2

select City, count(*) cafes from final_table
where Cafe = 'Available'
group by City order by 2

select City, a.name, a.latitude, a.longitude, Cluster from resto..Cluster a inner join  final_table b on a.name=b.name
order by City

SELECT AVG(rating) cafe FROM final_table
where Cafe = 'Available'

SELECT AVG(rating) Bar FROM final_table
where Bar = 'Available'

SELECT AVG(rating) Steakhouse FROM final_table
where Steakhouse = 'Available'

SELECT AVG(rating) Seafood FROM final_table
where Seafood = 'Available'

select top 10 city, avg(rating) avg_rating from final_table
group by city order by avg(rating) desc

select count(*)  Cafe from final_table
where Cafe = 'Available'

select count(*)  Bar from final_table
where Bar = 'Available'

select count(*)  Steakhouse from final_table
where Steakhouse = 'Available'

select City, count(*)  Steakhouse from final_table
where Steakhouse = 'Available'
GROUP BY City ORDER BY count(*)

select * from final_table


SELECT AVG(rating) indian FROM final_table
where Indian = 'Available'

SELECT AVG(rating) am FROM final_table
where American = 'Available'

SELECT AVG(rating) ger FROM final_table
where German = 'Available'

SELECT AVG(rating) ita FROM final_table
where Italian = 'Available'

SELECT AVG(rating) jAP FROM final_table
where Japanese = 'Available'

SELECT AVG(rating) med FROM final_table
where Mediterranean = 'Available'

create table avg_ratings(
category varchar(100),
rating float
);

INSERT INTO avg_ratings (category, rating)
select 'American', 4.367 union all select 
'Indian', 4.5 union all select
'German', 4.338 union all select
'Italian', 4.435 union all select
'Japanese', 4.442 union all select
'Mediterranean', 4.463

select * from avg_ratings