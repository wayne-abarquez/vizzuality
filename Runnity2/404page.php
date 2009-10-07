<?php

require 'libs/Smarty.class.php';
require 'services/RunnitServices.php';

$smarty = new Smarty;
$services = new RunnitServices;

$smarty->assign('nextRaces',$services->getNextRuns());
$smarty->assign('section', '404');
$smarty->assign('titulo_pagina', '404 - Pagina no encontrada');
$smarty->display('404.tpl');

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
} else {
	$smarty->assign('city', 'Espa–a');
}

?>