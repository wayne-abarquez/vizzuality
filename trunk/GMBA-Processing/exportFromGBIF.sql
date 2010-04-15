# this is the original formula but due to lack of precision in latitude it is wrong
# update temp_gmba set cell_id= ((floor(latitude*24) + 2160)*8640) + (floor(longitude*24) + 4320);
#
# GMBA uses
# gmbadata.cellnr:  first 4 digits of cellnr: (latitude + 180)*24, second 4 digits: (longitude + 180)*24
# to put into our cell_id we do
update temp_gmba set cell_id = (cast(substring(cellnr,1,4) as SIGNED)-2160) * 8640 + cast(substring(cellnr,5,4) as SIGNED); 

# check the gmba table has the index
alter table temp_gmba add index(relief),add index(cell_id);

# create a temporary table for exporting
CREATE TABLE temp_gmba_occurrence (
	id int,
	latitude float not null,
	longitude float not null,
	data_resource_id smallint not null,
	kingdom_concept_id int,
	phylum_concept_id int,
	class_concept_id int,
	order_concept_id int,
	family_concept_id int,
	genus_concept_id int,
	species_concept_id int,
	nub_concept_id int null,
	basis_of_record tinyint not null,
	cell_id int,
	mod_cell_id smallint);

# 158481906 rows affected (10 min 17.12 sec)
insert into temp_gmba_occurrence
select id, latitude, longitude, data_resource_id, kingdom_concept_id,
phylum_concept_id, class_concept_id, order_concept_id, family_concept_id,
genus_concept_id, species_concept_id, nub_concept_id, basis_of_record, null, null
from occurrence_record where latitude is not null and longitude is not null and geospatial_issue=0;

# 158481906 rows affected (12 min 49.34 sec)
update temp_gmba_occurrence set cell_id= ((floor(latitude*24) + 2164)*8640) + (floor(longitude*24) + 4320);

# 158481906 rows affected (8 min 33.69 sec)
alter table temp_gmba_occurrence add index(cell_id);

# trim the table to only content we have cell data for
# 12158725 rows affected (3 min 7.61 sec)
CREATE TABLE temp_gmba_occurrence_trimmed as 
select o.* from temp_gmba_occurrence o join temp_gmba e on o.cell_id=e.cell_id where e.relief>=200;

# 9910427 rows affected (42.42 sec)
update temp_gmba_occurrence_trimmed set mod_cell_id=mod(cell_id, 8640);

# 12158725 rows affected (23.77 sec)
alter table temp_gmba_occurrence_trimmed add index(cell_id);

# now group and add the count
# 4024771 rows affected (1 min 47.14 sec)
CREATE TABLE temp_gmba_occurrence_density as 
select latitude, longitude, data_resource_id, kingdom_concept_id,
phylum_concept_id, class_concept_id, order_concept_id, family_concept_id,
genus_concept_id, species_concept_id, nub_concept_id, basis_of_record, cell_id, mod_cell_id,
count(*) as count
from temp_gmba_occurrence_trimmed
group by cell_id, mod_cell_id, data_resource_id, kingdom_concept_id,
phylum_concept_id, class_concept_id, order_concept_id, family_concept_id,
genus_concept_id, species_concept_id, nub_concept_id, basis_of_record;

# create a temporary table for exporting
CREATE TABLE temp_gmba_export_density (
	cell_id int,
	mod_cell_id smallint,
	nub_id int,
	resource_id smallint,
	basis_of_record tinyint,
	count int
);

# kingdom to species
# 357662 rows affected (12.16 sec)
insert into temp_gmba_export_density
select cell_id, mod_cell_id, kingdom_concept_id, data_resource_id, basis_of_record, sum(count)
from temp_gmba_occurrence_density
where kingdom_concept_id!=nub_concept_id
group by 1,2,3,4,5;

# 430863 rows affected (11.91 sec)
insert into temp_gmba_export_density
select cell_id, mod_cell_id, phylum_concept_id, data_resource_id, basis_of_record, sum(count)
from temp_gmba_occurrence_density
where phylum_concept_id!=nub_concept_id
group by 1,2,3,4,5;

# 490072 rows affected (12.27 sec)
insert into temp_gmba_export_density
select cell_id, mod_cell_id, class_concept_id, data_resource_id, basis_of_record, sum(count)
from temp_gmba_occurrence_density
where class_concept_id!=nub_concept_id
group by 1,2,3,4,5;

# 1004701 rows affected (15.73 sec)
insert into temp_gmba_export_density
select cell_id, mod_cell_id, order_concept_id, data_resource_id, basis_of_record, sum(count)
from temp_gmba_occurrence_density
where order_concept_id!=nub_concept_id
group by 1,2,3,4,5;

# 1547334 rows affected (21.91 sec)
insert into temp_gmba_export_density
select cell_id, mod_cell_id, family_concept_id, data_resource_id, basis_of_record, sum(count)
from temp_gmba_occurrence_density
where family_concept_id!=nub_concept_id
group by 1,2,3,4,5;

# 2661694 rows affected (38.32 sec)
insert into temp_gmba_export_density
select cell_id, mod_cell_id, genus_concept_id, data_resource_id, basis_of_record, sum(count)
from temp_gmba_occurrence_density
where genus_concept_id!=nub_concept_id
group by 1,2,3,4,5;

# 216462 rows affected (2.88 sec)
insert into temp_gmba_export_density
select cell_id, mod_cell_id, species_concept_id, data_resource_id, basis_of_record, sum(count)
from temp_gmba_occurrence_density
where species_concept_id!=nub_concept_id
group by 1,2,3,4,5;

# 4024648 rows affected (1 min 12.21 sec)
insert into temp_gmba_export_density
select cell_id, mod_cell_id, nub_concept_id, data_resource_id, basis_of_record, sum(count)
from temp_gmba_occurrence_density
group by 1,2,3,4,5;

# 10733436 rows affected (15.36 sec)
alter table temp_gmba_export_density add index(cell_id);

# 10733436 rows affected (3 min 37.51 sec)  
create table temp_gmba_export_occurrence_density as select nub_id, g.cell_id as cell_id, mod_cell_id, resource_id, basis_of_record, count, elevation, relief, tvzcode
from temp_gmba_export_density d join temp_gmba g on d.cell_id=g.cell_id;


# create a table with just the occurrence ids of interest, and the environment data for those
# doing this in the single join below is too expensive for mysql
# 12158725 rows affected (6 min 37.21 sec)
create table temp_gmba_occurrence_ids as 
select o.id as id, e.elevation as elevation, e.relief as relief, e.tvzcode as tvzcode from 
temp_gmba_occurrence_trimmed o join temp_gmba e on o.cell_id = e.cell_id ;
# 12158725 rows affected (17.58 sec)
alter table temp_gmba_occurrence_ids add index(id);

# 
create table temp_gmba_export_download as
select
e.elevation as 'elevation',
e.relief as 'relief',
e.tvzcode as 'tvzcode',
o.data_provider_id as 'data_provider_id',
o.data_resource_id as 'data_resource_id', 
dp.name as 'data_provider', 
dr.name as 'dataset', 
r.collector_name as 'collector_name', 
o.occurrence_date as 'date_collected', 
r.institution_code as 'institution_code',
r.collection_code as 'collection_code',
r.catalogue_number as 'catalogue_number', 
lub.br_value as 'basis_of_record', 
o.modified as 'last_indexed', 
r.identifier_name as 'identifier', 
r.identification_date as 'identification_date', 
r.scientific_name as 'scientific_name_original', 
r.author as 'author', 
nn.canonical as 'scientific_name', 
kn.canonical as 'kingdom', 
pn.canonical as 'phylum', 
cn.canonical as 'class', 
orn.canonical as 'order_rank', 
fn.canonical as 'family', 
gn.canonical as 'genus', 
o.iso_country_code as 'country', 
r.locality as 'locality', 
r.county as 'county', 
r.continent_ocean as 'continent_or_ocean', 
r.state_province as 'state_or_province', 
c.region as 'region', 
dp.iso_country_code as 'provider_country', 
o.latitude as 'latitude_interpreted', 
r.longitude as 'longitude',
o.longitude as 'longitude_interpreted', 
r.lat_long_precision as 'coordinate_precision', 
o.geospatial_issue as 'geospatial_issue', 
o.cell_id as 'cell_id', 
o.centi_cell_id as 'centi_cell_id', 
r.min_depth as 'min_depth', 
r.max_depth as 'max_depth', 
r.min_altitude as 'min_altitude', 
r.max_altitude as 'max_altitude', 
r.altitude_precision as 'altitude_precision', 
cast(concat('http://data.gbif.org/occurrences/',o.id) as char) as 'gbif_portal_url', 
o.id as 'occurrence_id',
o.nub_concept_id as 'nub_concept_id',
o.kingdom_concept_id as 'kingdom_concept_id',
o.phylum_concept_id as 'phylum_concept_id',
o.class_concept_id as 'class_concept_id',
o.order_concept_id as 'order_concept_id',
o.family_concept_id as 'family_concept_id',
o.genus_concept_id as 'genus_concept_id',
o.species_concept_id as 'species_concept_id'
from
occurrence_record o
join temp_gmba_occurrence_ids e on o.id=e.id
join data_resource dr on dr.id = o.data_resource_id join data_provider dp on
o.data_provider_id = dp.id left join country c on o.iso_country_code =
c.iso_country_code left join lookup_basis_of_record lub on
o.basis_of_record=lub.br_key join
raw_occurrence_record r on o.id=r.id inner join taxon_concept nc on
o.nub_concept_id=nc.id inner join taxon_name nn on nc.taxon_name_id=nn.id
left join taxon_concept kc on nc.kingdom_concept_id=kc.id left join
taxon_name kn on kc.taxon_name_id=kn.id left join taxon_concept pc on
nc.phylum_concept_id=pc.id left join taxon_name pn on pc.taxon_name_id=pn.id
left join taxon_concept cc on nc.class_concept_id=cc.id left join taxon_name
cn on cc.taxon_name_id=cn.id left join taxon_concept oc on
nc.order_concept_id=oc.id left join taxon_name orn on
oc.taxon_name_id=orn.id left join taxon_concept fc on
nc.family_concept_id=fc.id left join taxon_name fn on fc.taxon_name_id=fn.id
left join taxon_concept gc on nc.genus_concept_id=gc.id left join taxon_name
gn on gc.taxon_name_id=gn.id;