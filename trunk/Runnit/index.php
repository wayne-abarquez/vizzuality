<?php 

session_start();

require 'libs/Smarty.class.php';
require 'services/RunnitServices.php';

$smarty = new Smarty; 
$services = new RunnitServices;

$smarty->assign('section', 'index');
$smarty->assign('titulo_pagina', 'Próximas carreras y atletas - Runnity.com');


$smarty->assign('runners',$services->getLastUsersInscribedToRuns());


//Get information about the city
//Set geolocation cookie
if(!isset($_COOKIE["geolocation"])){
	$visitor_location = visitorLocation();
	if($visitor_location['city']) {
		setcookie("geolocation", $visitor_location['city']);
		setcookie("lat", $visitor_location['lat']);
		setcookie("lon", $visitor_location['lon']);		
	}
}else{
	$visitor_location = array();
	$visitor_location['lat'] = $_COOKIE["lat"];
	$visitor_location['lon'] = $_COOKIE["lon"];
	$visitor_location['city'] = $_COOKIE["geolocation"];
}

if ($visitor_location['city']!='') {
	$smarty->assign('city', $visitor_location['city']);
	$smarty->assign('nextRaces',$services->getNextRuns($visitor_location['lat'],$visitor_location['lon'],150));
} else {
	$smarty->assign('city', 'España');
	$smarty->assign('nextRaces',$services->getNextRuns());
}

//Try to get runs for the province

$smarty->display('home.tpl');



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

?>