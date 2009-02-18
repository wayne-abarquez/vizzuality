<?php
// Wade Arnold: 1/6/2008
// Example is designed to show how to use PHP sessions. 
class EolServices {
    public function getProviders($taxonId) {
        $link = mysql_connect('localhost:3307', 'root', 'root');
        mysql_select_db('eol', $link) or die('Could not select database.');
        $sql="select dr.name as data_resource_name, dp.name as data_provider_name,data_provider_id,data_resource_id,1 as num_occ from taxon_resource tr left join data_provider dp on tr.data_provider_id= dp.id left join data_resource dr on dr.id=tr.data_resource_id where taxon_id=".$taxonId;
        error_log($sql);
        $result = mysql_query($sql);
        
        $output=array();
        while ($row = mysql_fetch_array($result, MYSQL_ASSOC)) {
            $output[]=$row;
        }
        return $output;        
	}

}
?>