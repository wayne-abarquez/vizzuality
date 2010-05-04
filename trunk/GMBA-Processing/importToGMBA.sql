rename table temp_gmba_export_occurrence_density to occurrence_density;
# 10733436 rows affected (3 min 34.34 sec)
alter table occurrence_density 
add index(elevation, nub_id), 
add index(elevation, relief),
add index(cell_id);


rename table temp_gmba_export_download to occurrence_download;
# 12148980 rows affected (34 min 51.58 sec)
alter table occurrence_download 
add index(relief, nub_concept_id),
add index(elevation, nub_concept_id),
add index(elevation, kingdom_concept_id),
add index(elevation, phylum_concept_id),
add index(elevation, class_concept_id),
add index(order_concept_id),
add index(family_concept_id),
add index(genus_concept_id),
add index(species_concept_id);


