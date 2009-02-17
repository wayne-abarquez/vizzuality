create table data_provider (
	id smallint unsigned not null
	, name varchar(255) not null
	, primary key (id)
) engine=myisam;



create table data_resource (
	id smallint unsigned not null
	, name varchar(255) not null
	, primary key (id)
) engine=myisam;



create table taxon_resource (
	id int unsigned not null auto_increment
	, taxon_id int unsigned not null
	, data_provider_id smallint unsigned not null
	, data_resource_id smallint unsigned not null 
	, primary key (id) 
) engine=myisam;
create index ix_eol_taxon_resource_taxon_id on taxon_resource (taxon_id);



create table taxon_site (
	id int unsigned not null auto_increment
	, taxon_id int unsigned not null
	, latitude float not null
	, longitude float not null
	, num_occ int unsigned not null default 0
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
	, primary key (id) 
) engine=myisam;
create index ix_taxon_site_tile_0 on taxon_site (taxon_id,tile0_x,tile0_y);
create index ix_taxon_site_tile_1 on taxon_site (taxon_id,tile1_x,tile1_y);
create index ix_taxon_site_tile_2 on taxon_site (taxon_id,tile2_x,tile2_y);
create index ix_taxon_site_tile_3 on taxon_site (taxon_id,tile3_x,tile3_y);
create index ix_taxon_site_tile_4 on taxon_site (taxon_id,tile4_x,tile4_y);
create index ix_taxon_site_tile_5 on taxon_site (taxon_id,tile5_x,tile5_y);
create index ix_taxon_site_tile_6 on taxon_site (taxon_id,tile6_x,tile6_y);
create index ix_taxon_site_tile_7 on taxon_site (taxon_id,tile7_x,tile7_y);
create index ix_taxon_site_tile_8 on taxon_site (taxon_id,tile8_x,tile8_y);
create index ix_taxon_site_tile_9 on taxon_site (taxon_id,tile9_x,tile9_y);
create index ix_taxon_site_tile_10 on taxon_site (taxon_id,tile10_x,tile10_y);
create index ix_taxon_site_tile_11 on taxon_site (taxon_id,tile11_x,tile11_y);
create index ix_taxon_site_tile_12 on taxon_site (taxon_id,tile12_x,tile12_y);
create index ix_taxon_site_tile_13 on taxon_site (taxon_id,tile13_x,tile13_y);
create index ix_taxon_site_tile_14 on taxon_site (taxon_id,tile14_x,tile14_y);
create index ix_taxon_site_tile_15 on taxon_site (taxon_id,tile15_x,tile15_y);
create index ix_taxon_site_tile_16 on taxon_site (taxon_id,tile16_x,tile16_y);
create index ix_taxon_site_tile_17 on taxon_site (taxon_id,tile17_x,tile17_y);
create index ix_taxon_site_tile_18 on taxon_site (taxon_id,tile18_x,tile18_y);
create index ix_taxon_site_tile_19 on taxon_site (taxon_id,tile19_x,tile19_y);
create index ix_taxon_site_tile_20 on taxon_site (taxon_id,tile20_x,tile20_y);
create index ix_taxon_site_tile_21 on taxon_site (taxon_id,tile21_x,tile21_y);
create index ix_taxon_site_tile_22 on taxon_site (taxon_id,tile22_x,tile22_y);
create index ix_taxon_site_tile_23 on taxon_site (taxon_id,tile23_x,tile23_y);


create table tile_0_taxon (
	x tinyint unsigned
	, y tinyint unsigned
	, taxon_id int unsigned not null
	, num_occ int unsigned not null default 0
	, tile_orig_x tinyint unsigned
	, tile_orig_y tinyint unsigned
	, primary key (x,y) 
) engine=myisam;
create index ix_tile_0_origXY on tile_0_taxon (taxon_id,tile_orig_x,tile_orig_y);



create table tile_1_taxon (
	x tinyint unsigned
	, y tinyint unsigned
	, taxon_id int unsigned not null
	, num_occ int unsigned not null default 0
	, tile_orig_x tinyint unsigned
	, tile_orig_y tinyint unsigned
	, primary key (x,y) 
) engine=myisam;
create index ix_tile_1_origXY on tile_1_taxon (taxon_id,tile_orig_x,tile_orig_y);



create table tile_2_taxon (
	x tinyint unsigned
	, y tinyint unsigned
	, taxon_id int unsigned not null
	, num_occ int unsigned not null default 0
	, tile_orig_x tinyint unsigned
	, tile_orig_y tinyint unsigned
	, primary key (x,y) 
) engine=myisam;
create index ix_tile_2_origXY on tile_2_taxon (taxon_id,tile_orig_x,tile_orig_y);



create table tile_3_taxon (
	x tinyint unsigned
	, y tinyint unsigned
	, taxon_id int unsigned not null
	, num_occ int unsigned not null default 0
	, tile_orig_x tinyint unsigned
	, tile_orig_y tinyint unsigned
	, primary key (x,y) 
) engine=myisam;
create index ix_tile_3_origXY on tile_3_taxon (taxon_id,tile_orig_x,tile_orig_y);



create table tile_4_taxon (
	x tinyint unsigned
	, y tinyint unsigned
	, taxon_id int unsigned not null
	, num_occ int unsigned not null default 0
	, tile_orig_x tinyint unsigned
	, tile_orig_y tinyint unsigned
	, primary key (x,y) 
) engine=myisam;
create index ix_tile_4_origXY on tile_4_taxon (taxon_id,tile_orig_x,tile_orig_y);



create table tile_5_taxon (
	x tinyint unsigned
	, y tinyint unsigned
	, taxon_id int unsigned not null
	, num_occ int unsigned not null default 0
	, tile_orig_x tinyint unsigned
	, tile_orig_y tinyint unsigned
	, primary key (x,y) 
) engine=myisam;
create index ix_tile_5_origXY on tile_5_taxon (taxon_id,tile_orig_x,tile_orig_y);



create table tile_6_taxon (
	x tinyint unsigned
	, y tinyint unsigned
	, taxon_id int unsigned not null
	, num_occ int unsigned not null default 0
	, tile_orig_x tinyint unsigned
	, tile_orig_y tinyint unsigned
	, primary key (x,y) 
) engine=myisam;
create index ix_tile_6_origXY on tile_6_taxon (taxon_id,tile_orig_x,tile_orig_y);



create table tile_7_taxon (
	x smallint unsigned
	, y smallint unsigned
	, taxon_id int unsigned not null
	, num_occ int unsigned not null default 0
	, tile_orig_x tinyint unsigned
	, tile_orig_y tinyint unsigned
	, primary key (x,y) 
) engine=myisam;
create index ix_tile_7_origXY on tile_7_taxon (taxon_id,tile_orig_x,tile_orig_y);



create table tile_8_taxon (
	x smallint unsigned
	, y smallint unsigned
	, taxon_id int unsigned not null
	, num_occ int unsigned not null default 0
	, tile_orig_x tinyint unsigned
	, tile_orig_y tinyint unsigned
	, primary key (x,y) 
) engine=myisam;
create index ix_tile_8_origXY on tile_8_taxon (taxon_id,tile_orig_x,tile_orig_y);



create table tile_9_taxon (
	x smallint unsigned
	, y smallint unsigned
	, taxon_id int unsigned not null
	, num_occ int unsigned not null default 0
	, tile_orig_x smallint unsigned
	, tile_orig_y smallint unsigned
	, primary key (x,y) 
) engine=myisam;
create index ix_tile_9_origXY on tile_9_taxon (taxon_id,tile_orig_x,tile_orig_y);



create table tile_10_taxon (
	x smallint unsigned
	, y smallint unsigned
	, taxon_id int unsigned not null
	, num_occ int unsigned not null default 0
	, tile_orig_x smallint unsigned
	, tile_orig_y smallint unsigned
	, primary key (x,y) 
) engine=myisam;
create index ix_tile_10_origXY on tile_10_taxon (taxon_id,tile_orig_x,tile_orig_y);



create table tile_11_taxon (
	x smallint unsigned
	, y smallint unsigned
	, taxon_id int unsigned not null
	, num_occ int unsigned not null default 0
	, tile_orig_x smallint unsigned
	, tile_orig_y smallint unsigned
	, primary key (x,y) 
) engine=myisam;
create index ix_tile_11_origXY on tile_11_taxon (taxon_id,tile_orig_x,tile_orig_y);



create table tile_12_taxon (
	x smallint unsigned
	, y smallint unsigned
	, taxon_id int unsigned not null
	, num_occ int unsigned not null default 0
	, tile_orig_x smallint unsigned
	, tile_orig_y smallint unsigned
	, primary key (x,y) 
) engine=myisam;
create index ix_tile_12_origXY on tile_12_taxon (taxon_id,tile_orig_x,tile_orig_y);



create table tile_13_taxon (
	x smallint unsigned
	, y smallint unsigned
	, taxon_id int unsigned not null
	, num_occ int unsigned not null default 0
	, tile_orig_x smallint unsigned
	, tile_orig_y smallint unsigned
	, primary key (x,y) 
) engine=myisam;
create index ix_tile_13_origXY on tile_13_taxon (taxon_id,tile_orig_x,tile_orig_y);



create table tile_14_taxon (
	x smallint unsigned
	, y smallint unsigned
	, taxon_id int unsigned not null
	, num_occ int unsigned not null default 0
	, tile_orig_x smallint unsigned
	, tile_orig_y smallint unsigned
	, primary key (x,y) 
) engine=myisam;
create index ix_tile_14_origXY on tile_14_taxon (taxon_id,tile_orig_x,tile_orig_y);



create table tile_15_taxon (
	x mediumint unsigned
	, y mediumint unsigned
	, taxon_id int unsigned not null
	, num_occ int unsigned not null default 0
	, tile_orig_x smallint unsigned
	, tile_orig_y smallint unsigned
	, primary key (x,y) 
) engine=myisam;
create index ix_tile_15_origXY on tile_15_taxon (taxon_id,tile_orig_x,tile_orig_y);



create table tile_16_taxon (
	x mediumint unsigned
	, y mediumint unsigned
	, taxon_id int unsigned not null
	, num_occ int unsigned not null default 0
	, tile_orig_x smallint unsigned
	, tile_orig_y smallint unsigned
	, primary key (x,y) 
) engine=myisam;
create index ix_tile_16_origXY on tile_16_taxon (taxon_id,tile_orig_x,tile_orig_y);



create table tile_17_taxon (
	x mediumint unsigned
	, y mediumint unsigned
	, taxon_id int unsigned not null
	, num_occ int unsigned not null default 0
	, tile_orig_x mediumint unsigned
	, tile_orig_y mediumint unsigned
	, primary key (x,y) 
) engine=myisam;
create index ix_tile_17_origXY on tile_17_taxon (taxon_id,tile_orig_x,tile_orig_y);



create table tile_18_taxon (
	x mediumint unsigned
	, y mediumint unsigned
	, taxon_id int unsigned not null
	, num_occ int unsigned not null default 0
	, tile_orig_x mediumint unsigned
	, tile_orig_y mediumint unsigned
	, primary key (x,y) 
) engine=myisam;
create index ix_tile_18_origXY on tile_18_taxon (taxon_id,tile_orig_x,tile_orig_y);



create table tile_19_taxon (
	x mediumint unsigned
	, y mediumint unsigned
	, taxon_id int unsigned not null
	, num_occ int unsigned not null default 0
	, tile_orig_x mediumint unsigned
	, tile_orig_y mediumint unsigned
	, primary key (x,y) 
) engine=myisam;
create index ix_tile_19_origXY on tile_19_taxon (taxon_id,tile_orig_x,tile_orig_y);



create table tile_20_taxon (
	x mediumint unsigned
	, y mediumint unsigned
	, taxon_id int unsigned not null
	, num_occ int unsigned not null default 0
	, tile_orig_x mediumint unsigned
	, tile_orig_y mediumint unsigned
	, primary key (x,y) 
) engine=myisam;
create index ix_tile_20_origXY on tile_20_taxon (taxon_id,tile_orig_x,tile_orig_y);



create table tile_21_taxon (
	x mediumint unsigned
	, y mediumint unsigned
	, taxon_id int unsigned not null
	, num_occ int unsigned not null default 0
	, tile_orig_x mediumint unsigned
	, tile_orig_y mediumint unsigned
	, primary key (x,y) 
) engine=myisam;
create index ix_tile_21_origXY on tile_21_taxon (taxon_id,tile_orig_x,tile_orig_y);
