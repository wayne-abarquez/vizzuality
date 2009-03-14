-- note that 0,1 are special in that they use always tile4 for X and Y
-- otherwise zoom levels always use 2 levels about them 2-4,3-5 etc
truncate table tile_0_taxon;
truncate table tile_1_taxon;
truncate table tile_2_taxon;
truncate table tile_3_taxon;
truncate table tile_4_taxon;
truncate table tile_5_taxon;
truncate table tile_6_taxon;
truncate table tile_7_taxon;
truncate table tile_8_taxon;
truncate table tile_9_taxon;
truncate table tile_10_taxon;
truncate table tile_11_taxon;
truncate table tile_12_taxon;
truncate table tile_13_taxon;
truncate table tile_14_taxon;
truncate table tile_15_taxon;
truncate table tile_16_taxon;
truncate table tile_17_taxon;
truncate table tile_18_taxon;
truncate table tile_19_taxon;

insert into tile_0_taxon
select tile4_x, tile4_y, taxon_id, sum(num_occ), tile0_x, tile0_y
from taxon_site
group by 1,2,5,6,3;

insert into tile_1_taxon
select tile5_x, tile5_y, taxon_id, sum(num_occ), tile1_x, tile1_y
from taxon_site
group by 1,2,5,6,3;

insert into tile_2_taxon
select tile6_x, tile6_y, taxon_id, sum(num_occ), tile2_x, tile2_y
from taxon_site
group by 1,2,5,6,3;

insert into tile_3_taxon
select tile7_x, tile7_y, taxon_id, sum(num_occ), tile3_x, tile3_y
from taxon_site
group by 1,2,5,6,3;

insert into tile_4_taxon
select tile8_x, tile8_y, taxon_id, sum(num_occ), tile4_x, tile4_y
from taxon_site
group by 1,2,5,6,3;

insert into tile_5_taxon
select tile9_x, tile9_y, taxon_id, sum(num_occ), tile5_x, tile5_y
from taxon_site
group by 1,2,5,6,3;

insert into tile_6_taxon
select tile10_x, tile10_y, taxon_id, sum(num_occ), tile6_x, tile6_y
from taxon_site
group by 1,2,5,6,3;

insert ignore into tile_7_taxon
select tile11_x, tile11_y, taxon_id, sum(num_occ), tile7_x, tile7_y
from taxon_site
group by 1,2,5,6,3;

insert into tile_8_taxon
select tile12_x, tile12_y, taxon_id, sum(num_occ), tile8_x, tile8_y
from taxon_site
group by 1,2,5,6,3;

insert into tile_9_taxon
select tile13_x, tile13_y, taxon_id, sum(num_occ), tile9_x, tile9_y
from taxon_site
group by 1,2,5,6,3;

insert into tile_10_taxon
select tile14_x, tile14_y, taxon_id, sum(num_occ), tile10_x, tile10_y
from taxon_site
group by 1,2,5,6,3;

insert into tile_11_taxon
select tile15_x, tile15_y, taxon_id, sum(num_occ), tile11_x, tile11_y
from taxon_site
group by 1,2,5,6,3;

insert into tile_12_taxon
select tile16_x, tile16_y, taxon_id, sum(num_occ), tile12_x, tile12_y
from taxon_site
group by 1,2,5,6,3;

insert into tile_13_taxon
select tile17_x, tile17_y, taxon_id, sum(num_occ), tile13_x, tile13_y
from taxon_site
group by 1,2,5,6,3;

insert into tile_14_taxon
select tile18_x, tile18_y, taxon_id, sum(num_occ), tile14_x, tile14_y
from taxon_site
group by 1,2,5,6,3;

insert into tile_15_taxon
select tile19_x, tile19_y, taxon_id, sum(num_occ), tile15_x, tile15_y
from taxon_site
group by 1,2,5,6,3;

insert into tile_16_taxon
select tile20_x, tile20_y, taxon_id, sum(num_occ), tile16_x, tile16_y
from taxon_site
group by 1,2,5,6,3;

insert into tile_17_taxon
select tile21_x, tile21_y, taxon_id, sum(num_occ), tile17_x, tile17_y
from taxon_site
group by 1,2,5,6,3;

insert into tile_18_taxon
select tile22_x, tile22_y, taxon_id, sum(num_occ), tile18_x, tile18_y
from taxon_site
group by 1,2,5,6,3;

insert into tile_19_taxon
select tile23_x, tile23_y, taxon_id, sum(num_occ), tile19_x, tile19_y
from taxon_site
group by 1,2,5,6,3;