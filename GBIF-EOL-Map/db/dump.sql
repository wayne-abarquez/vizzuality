create table temp_eol_taxon_resource (
	id int unsigned not null auto_increment
	, taxon_id int unsigned not null
	, data_provider_id smallint unsigned not null
	, data_resource_id smallint unsigned not null 
	, primary key (id) 
) engine=myisam;
insert into temp_eol_taxon_resource(taxon_id, data_provider_id, data_resource_id)
select 
	nub_concept_id,
	data_provider_id,
	data_resource_id
from occurrence_record
where nub_concept_id=13839800
group by 1,2,3;

create table temp_eol_taxon_site (
	id int unsigned not null auto_increment
	, taxon_id int unsigned not null
	, latitude float not null
	, longitude float not null
	, num_occ int unsigned not null default 0
	, primary key (id) 
) engine=myisam;
insert into temp_eol_taxon_site(taxon_id, latitude, longitude, num_occ)
select
	nub_concept_id,
	latitude,
	longitude,
	count(*)
from occurrence_record
where latitude is not null and longitude is not null and geospatial_issue =0
and nub_concept_id=13839800
group by 1,2,3;

-- dumping
select id, name into outfile '/var/lib/mysql/eol_data_provider.txt' from data_provider; 
select id, name into outfile '/var/lib/mysql/eol_data_resource.txt' from data_resource; 
select * into outfile '/var/lib/mysql/eol_taxon_resource.txt' from temp_eol_taxon_resource; 
select * into outfile '/var/lib/mysql/eol_taxon_site.txt' from temp_eol_taxon_site; 

-- clean up
drop table temp_eol_taxon_resource;
drop table temp_eol_taxon_site;
