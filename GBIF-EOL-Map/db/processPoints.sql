-- this takes the same approach as the density layer,
-- but it creates a representative point for the grid, rather than 
-- the count of records within the cell
-- this is to achieve the similar effect that google employes
-- for flickr and panaramio overlays:
-- http://maps.google.com/?ie=UTF8&t=p&lci=org.wikipedia.en&ll=36.315125,-68.203125&spn=85.268341,178.066406&z=3

drop table if exists tile_0_taxon_point;
drop table if exists tile_1_taxon_point;
drop table if exists tile_2_taxon_point;
drop table if exists tile_3_taxon_point;
drop table if exists tile_4_taxon_point;
drop table if exists tile_5_taxon_point;
drop table if exists tile_6_taxon_point;
drop table if exists tile_7_taxon_point;
drop table if exists tile_8_taxon_point;
drop table if exists tile_9_taxon_point;
drop table if exists tile_10_taxon_point;
drop table if exists tile_11_taxon_point;
drop table if exists tile_12_taxon_point;
drop table if exists tile_13_taxon_point;
drop table if exists tile_14_taxon_point;
drop table if exists tile_15_taxon_point;
drop table if exists tile_16_taxon_point;
drop table if exists tile_17_taxon_point;
drop table if exists tile_18_taxon_point;
drop table if exists tile_19_taxon_point;


-- TODO - change the mediumint to tinyint and smallint where possible

create table tile_0_taxon_point (
	x mediumint unsigned
	, y mediumint unsigned
	, taxon_id int unsigned not null
	, point_x float
	, point_y float
	, tile_orig_x mediumint unsigned
	, tile_orig_y mediumint unsigned
	, primary key (x,y) 
) engine=myisam;
create index ix_tile_0_origXY on tile_0_taxon_point (taxon_id,tile_orig_x,tile_orig_y);

insert into tile_0_taxon_point
select tile4_x, tile4_y, taxon_id, null, null, tile0_x, tile0_y
from taxon_site
group by 1,2,6,7,3;

-- insert the representative point
update tile_0_taxon_point p,
(select taxon_id, longitude as x, latitude as y, tile4_x, tile4_y from taxon_site) ts
set p.point_x = ts.x, p.point_y=ts.y
where ts.taxon_id=p.taxon_id
and ts.tile4_x = p.x
and ts.tile4_y = p.y;

create table tile_1_taxon_point (
	x mediumint unsigned
	, y mediumint unsigned
	, taxon_id int unsigned not null
	, point_x float
	, point_y float
	, tile_orig_x mediumint unsigned
	, tile_orig_y mediumint unsigned
	, primary key (x,y) 
) engine=myisam;
create index ix_tile_1_origXY on tile_1_taxon_point (taxon_id,tile_orig_x,tile_orig_y);

insert into tile_1_taxon_point
select tile5_x, tile5_y, taxon_id, null, null, tile1_x, tile1_y
from taxon_site
group by 1,2,6,7,3;

-- insert the representative point
update tile_1_taxon_point p,
(select taxon_id, longitude as x, latitude as y, tile5_x, tile5_y from taxon_site) ts
set p.point_x = ts.x, p.point_y=ts.y
where ts.taxon_id=p.taxon_id
and ts.tile5_x = p.x
and ts.tile5_y = p.y;

create table tile_2_taxon_point (
	x mediumint unsigned
	, y mediumint unsigned
	, taxon_id int unsigned not null
	, point_x float
	, point_y float
	, tile_orig_x mediumint unsigned
	, tile_orig_y mediumint unsigned
	, primary key (x,y) 
) engine=myisam;
create index ix_tile_2_origXY on tile_2_taxon_point (taxon_id,tile_orig_x,tile_orig_y);

insert into tile_2_taxon_point
select tile6_x, tile6_y, taxon_id, null, null, tile2_x, tile2_y
from taxon_site
group by 1,2,6,7,3;

-- insert the representative point
update tile_2_taxon_point p,
(select taxon_id, longitude as x, latitude as y, tile6_x, tile6_y from taxon_site) ts
set p.point_x = ts.x, p.point_y=ts.y
where ts.taxon_id=p.taxon_id
and ts.tile6_x = p.x
and ts.tile6_y = p.y;

create table tile_3_taxon_point (
	x mediumint unsigned
	, y mediumint unsigned
	, taxon_id int unsigned not null
	, point_x float
	, point_y float
	, tile_orig_x mediumint unsigned
	, tile_orig_y mediumint unsigned
	, primary key (x,y) 
) engine=myisam;
create index ix_tile_3_origXY on tile_3_taxon_point (taxon_id,tile_orig_x,tile_orig_y);

insert into tile_3_taxon_point
select tile7_x, tile7_y, taxon_id, null, null, tile3_x, tile3_y
from taxon_site
group by 1,2,6,7,3;

-- insert the representative point
update tile_3_taxon_point p,
(select taxon_id, longitude as x, latitude as y, tile7_x, tile7_y from taxon_site) ts
set p.point_x = ts.x, p.point_y=ts.y
where ts.taxon_id=p.taxon_id
and ts.tile7_x = p.x
and ts.tile7_y = p.y;

create table tile_4_taxon_point (
	x mediumint unsigned
	, y mediumint unsigned
	, taxon_id int unsigned not null
	, point_x float
	, point_y float
	, tile_orig_x mediumint unsigned
	, tile_orig_y mediumint unsigned
	, primary key (x,y) 
) engine=myisam;
create index ix_tile_4_origXY on tile_4_taxon_point (taxon_id,tile_orig_x,tile_orig_y);

insert into tile_4_taxon_point
select tile8_x, tile8_y, taxon_id, null, null, tile4_x, tile4_y
from taxon_site
group by 1,2,6,7,3;

-- insert the representative point
update tile_4_taxon_point p,
(select taxon_id, longitude as x, latitude as y, tile8_x, tile8_y from taxon_site) ts
set p.point_x = ts.x, p.point_y=ts.y
where ts.taxon_id=p.taxon_id
and ts.tile8_x = p.x
and ts.tile8_y = p.y;

create table tile_5_taxon_point (
	x mediumint unsigned
	, y mediumint unsigned
	, taxon_id int unsigned not null
	, point_x float
	, point_y float
	, tile_orig_x mediumint unsigned
	, tile_orig_y mediumint unsigned
	, primary key (x,y) 
) engine=myisam;
create index ix_tile_5_origXY on tile_5_taxon_point (taxon_id,tile_orig_x,tile_orig_y);

insert into tile_5_taxon_point
select tile9_x, tile9_y, taxon_id, null, null, tile5_x, tile5_y
from taxon_site
group by 1,2,6,7,3;

-- insert the representative point
update tile_5_taxon_point p,
(select taxon_id, longitude as x, latitude as y, tile9_x, tile9_y from taxon_site) ts
set p.point_x = ts.x, p.point_y=ts.y
where ts.taxon_id=p.taxon_id
and ts.tile9_x = p.x
and ts.tile9_y = p.y;

create table tile_6_taxon_point (
	x mediumint unsigned
	, y mediumint unsigned
	, taxon_id int unsigned not null
	, point_x float
	, point_y float
	, tile_orig_x mediumint unsigned
	, tile_orig_y mediumint unsigned
	, primary key (x,y) 
) engine=myisam;
create index ix_tile_6_origXY on tile_6_taxon_point (taxon_id,tile_orig_x,tile_orig_y);

insert into tile_6_taxon_point
select tile10_x, tile10_y, taxon_id, null, null, tile6_x, tile6_y
from taxon_site
group by 1,2,6,7,3;

-- insert the representative point
update tile_6_taxon_point p,
(select taxon_id, longitude as x, latitude as y, tile10_x, tile10_y from taxon_site) ts
set p.point_x = ts.x, p.point_y=ts.y
where ts.taxon_id=p.taxon_id
and ts.tile10_x = p.x
and ts.tile10_y = p.y;


create table tile_7_taxon_point (
	x mediumint unsigned
	, y mediumint unsigned
	, taxon_id int unsigned not null
	, point_x float
	, point_y float
	, tile_orig_x mediumint unsigned
	, tile_orig_y mediumint unsigned
	, primary key (x,y) 
) engine=myisam;
create index ix_tile_7_origXY on tile_7_taxon_point (taxon_id,tile_orig_x,tile_orig_y);

insert into tile_7_taxon_point
select tile11_x, tile11_y, taxon_id, null, null, tile7_x, tile7_y
from taxon_site
group by 1,2,6,7,3;

-- insert the representative point
update tile_7_taxon_point p,
(select taxon_id, longitude as x, latitude as y, tile11_x, tile11_y from taxon_site) ts
set p.point_x = ts.x, p.point_y=ts.y
where ts.taxon_id=p.taxon_id
and ts.tile11_x = p.x
and ts.tile11_y = p.y;

create table tile_8_taxon_point (
	x mediumint unsigned
	, y mediumint unsigned
	, taxon_id int unsigned not null
	, point_x float
	, point_y float
	, tile_orig_x mediumint unsigned
	, tile_orig_y mediumint unsigned
	, primary key (x,y) 
) engine=myisam;
create index ix_tile_8_origXY on tile_8_taxon_point (taxon_id,tile_orig_x,tile_orig_y);

insert into tile_8_taxon_point
select tile12_x, tile12_y, taxon_id, null, null, tile8_x, tile8_y
from taxon_site
group by 1,2,6,7,3;

-- insert the representative point
update tile_8_taxon_point p,
(select taxon_id, longitude as x, latitude as y, tile12_x, tile12_y from taxon_site) ts
set p.point_x = ts.x, p.point_y=ts.y
where ts.taxon_id=p.taxon_id
and ts.tile12_x = p.x
and ts.tile12_y = p.y;

create table tile_9_taxon_point (
	x mediumint unsigned
	, y mediumint unsigned
	, taxon_id int unsigned not null
	, point_x float
	, point_y float
	, tile_orig_x mediumint unsigned
	, tile_orig_y mediumint unsigned
	, primary key (x,y) 
) engine=myisam;
create index ix_tile_9_origXY on tile_9_taxon_point (taxon_id,tile_orig_x,tile_orig_y);

insert into tile_9_taxon_point
select tile13_x, tile13_y, taxon_id, null, null, tile9_x, tile9_y
from taxon_site
group by 1,2,6,7,3;

-- insert the representative point
update tile_9_taxon_point p,
(select taxon_id, longitude as x, latitude as y, tile13_x, tile13_y from taxon_site) ts
set p.point_x = ts.x, p.point_y=ts.y
where ts.taxon_id=p.taxon_id
and ts.tile13_x = p.x
and ts.tile13_y = p.y;

create table tile_10_taxon_point (
	x mediumint unsigned
	, y mediumint unsigned
	, taxon_id int unsigned not null
	, point_x float
	, point_y float
	, tile_orig_x mediumint unsigned
	, tile_orig_y mediumint unsigned
	, primary key (x,y) 
) engine=myisam;
create index ix_tile_10_origXY on tile_10_taxon_point (taxon_id,tile_orig_x,tile_orig_y);

insert into tile_10_taxon_point
select tile14_x, tile14_y, taxon_id, null, null, tile10_x, tile10_y
from taxon_site
group by 1,2,6,7,3;

-- insert the representative point
update tile_10_taxon_point p,
(select taxon_id, longitude as x, latitude as y, tile14_x, tile14_y from taxon_site) ts
set p.point_x = ts.x, p.point_y=ts.y
where ts.taxon_id=p.taxon_id
and ts.tile14_x = p.x
and ts.tile14_y = p.y;

