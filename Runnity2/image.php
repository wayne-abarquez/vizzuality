<?php 

session_start();

// load Smarty library 
require 'libs/Smarty.class.php';
require 'services/RunnitServices.php';
require 'services/MediaServices.php';


$smarty = new Smarty; 
$services = new RunnitServices;
$mediaServices = new MediaServices;


$smarty->assign('titulo_pagina', 'Detalle de imagen - Runnity.com');
$smarty->assign('comments',$services->getComments($_SESSION['user']['id'],'user'));
require_once($_SERVER['DOCUMENT_ROOT'] ."/runnit-config.php");

$data=$services->getRunDetails($_REQUEST['id']);
if(!isset($data['name'])) {
	header("HTTP/1.0 404 Not Found"); 
	$smarty->assign('section', '404');
	$smarty->assign('titulo_pagina', '404 - Pagina no encontrada');
	$smarty->display('404.tpl');	
	die();
}

$data['description'] = nl2br($data['description']);
$smarty->assign('titulo_pagina', $data['name'] . ' - Runnity.com');

$smarty->assign('meta_keywords', $data['name'] . ',' . $data['event_location'] . ',' . 'running,popular,carrera popular,carrera, atletismo,correr,runner');
$smarty->assign('meta_description', $data['event_date'] . ' ' . $data['name'] . ',' . $data['event_location']);

$smarty->assign('data',$data);

$targetPicture="/media/run/".$_REQUEST['id']."/".$_REQUEST['picId']."_".$_REQUEST['type'].".jpg";
$smarty->assign('targetPicture', $targetPicture);
$smarty->assign('pictures',$mediaServices->getObjectPictures('run',$_REQUEST['id']));

$smarty->assign('section', 'usuario');
$smarty->display('image.tpl');

?>