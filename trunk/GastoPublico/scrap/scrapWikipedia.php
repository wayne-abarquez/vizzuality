<?php

define("MAPS_HOST", "maps.google.com");
define("KEY", "abcdefg");
$conn = pg_pconnect ("host=localhost dbname=gastopublico user=postgres password=");
$base_url = "http://" . MAPS_HOST . "/maps/geo?output=xml" . "&key=" . KEY;

require_once(dirname(__FILE__) . '/google.php');

$sql="SELECT id,wikipedia_url FROM organismo WHERE org_contratante='Administración Local' ORDER BY poblacion";
$res= pg_fetch_all(pg_query($conn, $sql));

foreach($res as $org) {
    

    $url=$res['wikipedia_url'];
	$html = file_get_dom($url);
    foreach($html->find('table') as $table) {
        print_r($table);
    }
    
    
    /*
    $sql="UPDATE organismo SET wikipedia_url='$wikipediaUrl'";
    $result=pg_query($conn, $sql); 
    */
    
    

}




?>