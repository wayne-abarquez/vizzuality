-- create the taxa table
create table temp_euro_starling as select latitude, longitude, year 
from occurrence_record
where nub_concept_id=13821756 
and year>1840 and geospatial_issue=0 and latitude is not null and longitude is not null group by latitude, longitude, year;


-- export and run the tile id script
-- it holds data from 1841-2009, hence the (1.5*) which is close enough to provide us with 0-255 (it produces 1-253)
mysql -u tim -p*** -h mogo -e "select latitude, longitude, floor(1.5*(min(year)-1840)) from temp_euro_starling  group by 1,2 order by 3" -N demoportal > /tmp/starling.txt



 

