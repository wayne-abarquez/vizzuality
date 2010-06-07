<?php 

session_start();

require 'libs/Smarty.class.php';
require 'services/RunnitServices.php';

$smarty = new Smarty; 
$services = new RunnitServices;

$smarty->assign('section', 'home');
$smarty->assign('titulo_pagina', 'Próximas carreras y atletas - Runnity.com');

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
	$smarty->assign('nextRaces',$services->getNextRuns($visitor_location['lat'],$visitor_location['lon'],150));
	$smarty->assign('nextImportantRaces',$services->getNextImportantRuns($visitor_location['lat'],$visitor_location['lon'],150));
} else {
	$smarty->assign('city', 'España');
	$smarty->assign('nextRaces',$services->getNextRuns());
	$smarty->assign('nextImportantRaces',$services->getNextImportantRuns());
}


//Recent activity
$smarty->assign('activity',$services->getLastActivity());

//Try to get runs for the province

$smarty->display('home.tpl');

function visitorLocation(){
    $location = array();
    $location['lat'] = "40.4";
	$location['lon'] = "-3.6833";
	$location['city'] = "Madrid";
	$location['country'] = "Spain";
	    
    @$link = mysql_connect('localhost', 'root', 'runnit');
    if (!$link) {
    	return $location;
    }



    @$db_selected = mysql_select_db("ipcity");
    if (!$db_selected) {
        return $location;
    }
    
	$ip = $_SERVER['REMOTE_ADDR'];
    
    $sql="SELECT region_name,country_name,latitude,longitude 
        FROM ip_group_city where ip_start <= INET_ATON('$ip') order by ip_start desc limit";

    @$query=mysql_query($sql);
    if (!$query) {
        return $location;
    }
    
    @$result = mysql_fetch_assoc($query);
    if($result){
        $location['lat'] = $result['latitude'];
    	$location['lon'] =  $result['longitude'];
    	$location['city'] =  $result['region_name'];
    	$location['country'] =  $result['country_name'];        
    } 
	
	return $location;
}

?>