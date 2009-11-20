<?php

session_start();

require 'libs/Smarty.class.php';
require 'services/RunnitServices.php';
require 'services/MediaServices.php';

$smarty = new Smarty;
$services = new RunnitServices;
$mediaServices = new MediaServices;


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

$smarty->assign('meta_keywords', $data['name'] . ',' . $data['event_location'] . ',' . 'running,popular,carrera popular,carrera, atletismo,correr,runner,fotos,comentarios');

if($data['description']) {
	$smarty->assign('meta_description', $data['event_date'] . ' ' . $data['name'] . ',' . $data['event_location'] . ',' . $data['description']);
}else{
	$smarty->assign('meta_description', 'Información, fotos y comentarios sobre ' . $data['name'] . ',' . $data['event_location'] . ',' .$data['event_date']);
}

$smarty->assign('data',$data);
$smarty->assign('runners',$services->getLastUsersInscribedToRuns($_REQUEST['id']));
$smarty->assign('comments',$services->getComments($_REQUEST['id'],'run'));

$smarty->assign('similarTypeRaces',$services->getRunsSimilarDistance($_REQUEST['id'],$data['distance_meters'],$data['start_point_lat'],$data['start_point_lon']));
$smarty->assign('runsInSameDates',$services->getRunsInSimilarDates($_REQUEST['id'],$data['start_point_lat'],$data['start_point_lon']));

$smarty->assign('pictures',$mediaServices->getObjectPictures('run',$_REQUEST['id']));

$smarty->display('carrera.tpl');

?>