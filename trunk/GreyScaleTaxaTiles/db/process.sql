-- note that 0,1 are special in that they use always tile4 for X and Y
-- otherwise zoom levels always use 2 levels about them 2-4,3-5 etc
truncate table tile_0_year;
truncate table tile_1_year;
truncate table tile_2_year;
truncate table tile_3_year;
truncate table tile_4_year;
truncate table tile_5_year;
truncate table tile_6_year;
truncate table tile_7_year;
truncate table tile_8_year;

insert into tile_0_year
select tile6_x, tile6_y, min(year), tile0_x, tile0_y
from year_site
group by 1,2,4,5;

insert into tile_1_year
select tile7_x, tile7_y, min(year), tile1_x, tile1_y
from year_site
group by 1,2,4,5;

insert into tile_2_year
select tile8_x, tile8_y, min(year), tile2_x, tile2_y
from year_site
group by 1,2,4,5;

insert into tile_3_year
select tile9_x, tile9_y, min(year), tile3_x, tile3_y
from year_site
group by 1,2,4,5;

insert ignore into tile_4_year
select tile10_x, tile10_y, min(year), tile4_x, tile4_y
from year_site
group by 1,2,4,5;

insert into tile_5_year
select tile11_x, tile11_y, min(year), tile5_x, tile5_y
from year_site
group by 1,2,4,5;

insert into tile_6_year
select tile12_x, tile12_y, min(year), tile6_x, tile6_y
from year_site
group by 1,2,4,5;

insert ignore into tile_7_year
select tile13_x, tile13_y, min(year), tile7_x, tile7_y
from year_site
group by 1,2,4,5;

insert into tile_8_year
select tile14_x, tile14_y, min(year), tile8_x, tile8_y
from year_site
group by 1,2,4,5;