create table year_site (
	year int unsigned not null default 0
	, tile0_x tinyint unsigned
	, tile0_y tinyint unsigned
	, tile1_x tinyint unsigned
	, tile1_y tinyint unsigned
	, tile2_x tinyint unsigned
	, tile2_y tinyint unsigned
	, tile3_x tinyint unsigned
	, tile3_y tinyint unsigned
	, tile4_x tinyint unsigned
	, tile4_y tinyint unsigned
	, tile5_x tinyint unsigned
	, tile5_y tinyint unsigned
	, tile6_x tinyint unsigned
	, tile6_y tinyint unsigned
	, tile7_x tinyint unsigned
	, tile7_y tinyint unsigned
	, tile8_x tinyint unsigned
	, tile8_y tinyint unsigned
	, tile9_x smallint unsigned
	, tile9_y smallint unsigned
	, tile10_x smallint unsigned
	, tile10_y smallint unsigned
	, tile11_x smallint unsigned
	, tile11_y smallint unsigned
	, tile12_x smallint unsigned
	, tile12_y smallint unsigned
	, tile13_x smallint unsigned
	, tile13_y smallint unsigned
	, tile14_x smallint unsigned
	, tile14_y smallint unsigned
	, tile15_x smallint unsigned
	, tile15_y smallint unsigned
	, tile16_x smallint unsigned
	, tile16_y smallint unsigned
	, tile17_x mediumint unsigned
	, tile17_y mediumint unsigned
	, tile18_x mediumint unsigned
	, tile18_y mediumint unsigned
	, tile19_x mediumint unsigned
	, tile19_y mediumint unsigned
	, tile20_x mediumint unsigned
	, tile20_y mediumint unsigned
	, tile21_x mediumint unsigned
	, tile21_y mediumint unsigned
	, tile22_x mediumint unsigned
	, tile22_y mediumint unsigned
	, tile23_x mediumint unsigned
	, tile23_y mediumint unsigned
) engine=myisam;
create index year_site_0 on year_site (year,tile0_x,tile0_y);
create index year_site_1 on year_site (year,tile1_x,tile1_y);
create index year_site_2 on year_site (year,tile2_x,tile2_y);
create index year_site_3 on year_site (year,tile3_x,tile3_y);
create index year_site_4 on year_site (year,tile4_x,tile4_y);
create index year_site_5 on year_site (year,tile5_x,tile5_y);
create index year_site_6 on year_site (year,tile6_x,tile6_y);
create index year_sitee_7 on year_site (year,tile7_x,tile7_y);
create index year_site_8 on year_site (year,tile8_x,tile8_y);
create index year_site_9 on year_site (year,tile9_x,tile9_y);
create index year_site_10 on year_site (year,tile10_x,tile10_y);
create index year_site_11 on year_site (year,tile11_x,tile11_y);
create index year_site_12 on year_site (year,tile12_x,tile12_y);
create index year_site_13 on year_site (year,tile13_x,tile13_y);
create index year_site_14 on year_site (year,tile14_x,tile14_y);
create index year_site_15 on year_site (year,tile15_x,tile15_y);
create index year_site_16 on year_site (year,tile16_x,tile16_y);
create index year_site_17 on year_site (year,tile17_x,tile17_y);
create index year_site_18 on year_site (year,tile18_x,tile18_y);
create index year_site_19 on year_site (year,tile19_x,tile19_y);
create index year_site_20 on year_site (year,tile20_x,tile20_y);
create index year_site_21 on year_site (year,tile21_x,tile21_y);
create index year_site_22 on year_site (year,tile22_x,tile22_y);
create index year_site_23 on year_site (year,tile23_x,tile23_y);


drop table tile_0_year;
drop table tile_1_year;
drop table tile_2_year;
drop table tile_3_year;
drop table tile_4_year;
drop table tile_5_year;
drop table tile_6_year;
drop table tile_7_year;
drop table tile_8_year;

create table tile_0_year (
	x int unsigned
	, y int unsigned
	, year int unsigned not null
	, tile_orig_x int unsigned
	, tile_orig_y int unsigned
	, primary key (x,y) 
) engine=myisam;



create table tile_1_year (
	x int unsigned
	, y int unsigned
	, year int unsigned not null
	, tile_orig_x int unsigned
	, tile_orig_y int unsigned
	, primary key (x,y) 
) engine=myisam;



create table tile_2_year (
	x int unsigned
	, y int unsigned
	, year int unsigned not null
	, tile_orig_x int unsigned
	, tile_orig_y int unsigned
	, primary key (year,x,y) 
) engine=myisam;



create table tile_3_year (
	x int unsigned
	, y int unsigned
	, year int unsigned not null
	, tile_orig_x int unsigned
	, tile_orig_y int unsigned
	, primary key (year,x,y) 
) engine=myisam;



create table tile_4_year (
	x int unsigned
	, y int unsigned
	, year int unsigned not null
	, tile_orig_x int unsigned
	, tile_orig_y int unsigned
	, primary key (year,x,y) 
) engine=myisam;



create table tile_5_year (
	x smallint unsigned
	, y smallint unsigned
	, year int unsigned not null
	, tile_orig_x int unsigned
	, tile_orig_y int unsigned
	, primary key (year,x,y) 
) engine=myisam;



create table tile_6_year (
	x smallint unsigned
	, y smallint unsigned
	, year int unsigned not null
	, tile_orig_x int unsigned
	, tile_orig_y int unsigned
	, primary key (year,x,y) 
) engine=myisam;



create table tile_7_year (
	x smallint unsigned
	, y smallint unsigned
	, year int unsigned not null
	, tile_orig_x int unsigned
	, tile_orig_y int unsigned
	, primary key (year,x,y) 
) engine=myisam;



create table tile_8_year (
	x smallint unsigned
	, y smallint unsigned
	, year int unsigned not null
	, tile_orig_x int unsigned
	, tile_orig_y int unsigned
	, primary key (year,x,y) 
) engine=myisam;



