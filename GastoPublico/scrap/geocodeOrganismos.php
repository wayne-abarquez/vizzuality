<?php

define("MAPS_HOST", "maps.google.com");
define("KEY", "abcdefg");
$conn = pg_pconnect ("host=localhost dbname=gastopublico user=postgres password=");
$base_url = "http://" . MAPS_HOST . "/maps/geo?output=xml" . "&key=" . KEY;



$sql="SELECT id,via,poblacion,pais FROM organismo";
$res= pg_fetch_all(pg_query($conn, $sql));

foreach($res as $org) {
    $request_url = $base_url . "&q=" . urlencode($org['via'].",".$org['poblacion'].",spain");
	$request_response = utf8_encode(file_get_contents($request_url));
    $xml = simplexml_load_string($request_response);
	$status = $xml->Response->Status->code;
	if (strcmp($status, "200") == 0) {
		$coordinates = $xml->Response->Placemark->Point->coordinates;
		$coordinatesSplit = split(",", $coordinates);
		$lat = $coordinatesSplit[1];
		$lon = $coordinatesSplit[0];

        $sql="UPDATE organismo SET the_geom=setsrid(makepoint($lon, $lat),4326) WHERE id=".$org['id'];
        $result=pg_query($conn, $sql); 
        echo(".");
    }	        

}




?>