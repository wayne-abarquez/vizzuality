<?php

session_start();

require 'libs/Smarty.class.php';
require 'services/RunnitServices.php';
require 'services/MediaServices.php';

$smarty = new Smarty;
$services = new RunnitServices;
$mediaServices = new MediaServices;



function visitorLocation(){
	$ip = $_SERVER['REMOTE_ADDR'];
	//$ip="87.222.21.38";	
	
	$d = file_get_contents("http://www.ipinfodb.com/ip_query.php?ip=$ip&output=xml");
 
	//Use backup server if cannot make a connection
	if (!$d){
		$backup = file_get_contents("http://backup.ipinfodb.com/ip_query.php?ip=$ip&output=xml");
		$answer = new SimpleXMLElement($backup);
		if (!$backup) return false; // Failed to open connection
	}else{
		$answer = new SimpleXMLElement($d);
	}
 
	$location = array();
	$location['lat'] = $answer->Latitude;
	$location['lon'] = $answer->Longitude;
	$location['city'] = $answer->City;
	return $location;
}

$data=$services->getRunDetails($_REQUEST['id']);
if(!isset($data['name'])) {
	header("HTTP/1.0 404 Not Found"); 
	$smarty->assign('section', '404');
	$smarty->assign('titulo_pagina', '404 - Pagina no encontrada');
	$smarty->display('404.tpl');	
	die();
}

$smarty->assign('section', 'carrera');

$data['description'] = nl2br($data['description']);
$smarty->assign('titulo_pagina', $data['name'] . ' - Runnity.com');

$smarty->assign('meta_keywords', $data['name'] . ',' . $data['event_location'] . ',' . 'running,popular,carrera popular,carrera, atletismo,correr,runner');
$smarty->assign('meta_description', $data['event_date'] . ' ' . $data['name'] . ',' . $data['event_location']);

$smarty->assign('data',$data);
$smarty->assign('runners',$services->getLastUsersInscribedToRuns($_REQUEST['id']));
$smarty->assign('comments',$services->getComments($_REQUEST['id'],'run'));

//Get information about the city
//Set geolocation cookie
if(!isset($_COOKIE["geolocation"])){
	$visitor_location = visitorLocation();
	if($visitor_location['city']) {
	    
	    if($visitor_location['country'] == "Spain") {
    		setcookie("geolocation", $visitor_location['city']);
    		setcookie("lat", $visitor_location['lat']);
    		setcookie("lon", $visitor_location['lon']);	        
	    } else {
	        //Default to Madrid
	        $location['lat'] = "40.4";
        	$location['lon'] = "-3.6833";
        	$location['city'] = "Madrid";
        	$location['country'] = "Spain";
	        
	    }
	
	}
}else{
	$visitor_location = array();
	$visitor_location['lat'] = $_COOKIE["lat"];
	$visitor_location['lon'] = $_COOKIE["lon"];
	$visitor_location['city'] = $_COOKIE["geolocation"];
}

if ($visitor_location['city']!='') {
	$smarty->assign('city', $visitor_location['city']);
	$smarty->assign('similarTypeRaces',$services->getRunsSimilarDistance($_REQUEST['id'],$data['distance_meters'],$visitor_location['lat'],$visitor_location['lon'],150));
	$smarty->assign('runsInSameDates',$services->getRunsInSimilarDates($_REQUEST['id'],$visitor_location['lat'],$visitor_location['lon'],150));

} else {
	$smarty->assign('city', 'España');
	$smarty->assign('similarTypeRaces',$services->getRunsSimilarDistance($_REQUEST['id'],$data['distance_meters']));
	$smarty->assign('runsInSameDates',$services->getRunsInSimilarDates($_REQUEST['id']));
}
/*
$smarty->assign('similarTypeRaces',$services->getRunsSimilarDistance($_REQUEST['id'],$data['distance_meters']));
$smarty->assign('runsInSameDates',$services->getRunsInSimilarDates($_REQUEST['id']));
*/
$smarty->assign('pictures',$mediaServices->getObjectPictures('run',$_REQUEST['id']));

$smarty->display('carrera.tpl');

?>