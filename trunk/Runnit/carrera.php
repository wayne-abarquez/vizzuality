<?php

session_start();

require 'libs/Smarty.class.php';
require 'services/RunnitServices.php';

$smarty = new Smarty;
$services = new RunnitServices;



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

$smarty->assign('data',$data);
$smarty->assign('runners',$services->getLastUsersInscribedToRuns($_REQUEST['id']));
$smarty->assign('comments',$services->getComments($_REQUEST['id'],'run'));
$smarty->assign('nextRaces',$services->getRunsCloseToAnother($_REQUEST['id']));


$smarty->display('carrera.tpl');

?>