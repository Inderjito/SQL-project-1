

create table diamonds(id SERIAL NOT NULL, carat NUMERIC(5,2),cut
VARCHAR(30), color TEXT,clarity VARCHAR(10),depth NUMERIC(5,2),"table" NUMERIC(5,2),price INTEGER,
x NUMERIC(5,2),y NUMERIC(5,2), z NUMERIC(5,2));

--copy file path
COPY diamonds(carat, cut, color, clarity, depth, "table",price, x, y, z) from'/Users/Sunita/diamonds.csv' DELIMITER',' CSV HEADER

select *from diamonds

-- table one 
create table diamond_cut(c_id SERIAL PRIMARY KEY NOT NULL, cut VARCHAR(25) NOT NULL);

-- table two
CREATE TABLE diamond_details(d_id SERIAL PRIMARY KEY NOT NULL, carat NUMERIC(5,2)NOT NULL, color TEXT NOT NULL, clarity 
							 VARCHAR(10), dept NUMERIC(5,2), table_t INT NOT NULL, price INT NOT NULL, x DECIMAL(5,2),y DECIMAL(5,2),
							z DECIMAL (5,2) NOT NULL, cut_id INT NOT NULL, FOREIGN KEY(cut_id) REFERENCES diamond_cut(c_id));

-- insert into table diamond_cut

INSERT INTO diamond_cut(cut) SELECT DISTINCT cut FROM diamonds;

-- insert into diamond_detial

INSERT INTO diamond_details( carat, color,clarity, dept, table_t, price, x,y,z, cut_id) SELECT carat, color, clarity, depth,"table",price, x,y,z, dc.c_id
FROM diamonds d inner join diamond_cut dc ON d.cut=dc.cut;


select * FROM diamond_cut;
select * from diamond_details



--window function
select carat, color, price,
Rank() over (partition by color order by price desc)
from diamond_details

--create view

CREATE view "flawless"AS
SELECT clarity
from diamond_details
where clarity ='VVS1';

SELECT* FROM "flawless";

create view " highest_price" as
select price
from diamond_details
where price = '6600';
 

create view "best_cut" as
select cut
from diamond_cut
where cut = 'Premium';

SELECT* from "best_cut";


select count(*), AVG(price), min(price), max(price)
from diamond_details
group by color



--create function

create function g_price_count( price_from int, price_to int)
	returns int
	language plpgsql
as
$$
declare
	price_count integer;
begin
	select count(*)
	into price_count
	from diamond_details
	where price between price_from and price_to;
	
	return price_count;
end;
$$;

-- call the function
select g_price_count(326,351);


select* from diamond_details



--  create index


CREATE INDEX idx_prem_cut
ON diamond_cut(cut);

explain select*
from diamond_cut
Where cut = 'premium';


CREATE INDEX idx_best_cut on diamond_details
(clarity, color);

explain select*
from diamond_details
where color = 'J'


select* from idx_best_cut
where color = 'E';

select * FROM diamond_cut;


select* from diamond_details
-- using group by clause




select clarity, color,count(*)
from diamond_details
group by clarity, color 
order by clarity, color desc


select color, count(*) 
From diamond_details
group by  color 
order by color desc


select clarity, count(*) 
From diamond_details
group by  clarity 
order by clarity desc

select * from diamond_details
where price between 17000 and 18000
And color = 'D'
limit 10


-- Having clause


select dept, count(*)
from diamond_details
group by dept
having count(*) > 61
order by dept desc

-- and or clause

select* from diamond_details
where price > 6000
and clarity ='VS1'
or color = 'D'


select * from diamond_details

-- store procedure

create or  replace  procedure select_all
as $$
select * from diamond_cut
end; $$ language plpgsql;



create or replace procedure diamonds( price int, dept int)
language plpgsql
as $$
begin
set

create or replace procedure select_all (price int, color text)
language plpgsql
as $$
begin
select  price, color
from diamond_details

commits;

end;$$

call select_all(price ,color)



select count(cut)
from diamonds

select* from diamond_details

select * 
from diamond_details
where price > 10000
and ( color = 'D')
or color = 'E'
order by price desc




select* from diamonds
where price > 18000

select * from diamonds
where price between 3500 and 4000

select distinct cut
from diamonds
limit 10

select max(price)
from diamonds

select min(price)
from diamonds

select avg(price)
from diamonds

select count(cut)
from diamonds

select sum(price)
from diamonds

select sum(price)
from diamonds
where cut = 'Premium'

select sum(price)
from diamonds
where 1=1
Group by cut

select dept,count(*), AVG(price), min(price), max(price)
from diamond_details
group by dept
limit 10

select color, AVG(price), min(price), max(price)
from diamond_details
group by color

select color, AVG(price), min(price), max(price)
from diamond_details
group by color


select table_t, count(*), AVG(table_t), min(table_t), max(table_t)
from diamond_details
group by table_t
order by table_t desc


select cut_id, count(*), AVG(price), min(price), max(price)
from diamond_details
group by cut_id
order by cut_id desc

select color, cut, count(*)
from diamonds
group by color 


select color, cut,
count(*) over(partition by cut)
from diamonds d2


select distinct clarity
from diamond_details

select distinct color, AVG(price), min(price), max(price)
from diamond_details
group by color

select distinct cut
from diamond_cut

select distinct cut count(*)
from diamond_cut

select * from diamond_details

CREATE OR REPLACE FUNCTION price(a INTEGER, b INTEGER)
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN a+b ;
END;
$$;
select price (351, 360);

COPY (SELECT * FROM diamond_details) TO '/path/to/your/file.csv' WITH CSV HEADER; 
COPY (SELECT * FROM diamond_details) TO 'output1.txt'; for psql.


select* from diamonds

select* from diamond_cut