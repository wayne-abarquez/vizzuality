<?php

session_start();

require 'libs/Smarty.class.php';
require 'services/RunnitServices.php';

$smarty = new Smarty;
$services = new RunnitServices;

$offset=0;
if(isset($_REQUEST['offset'])) {
    $offset=$_REQUEST['offset'];
}

$smarty->assign('section', 'searchresults');
if(isset($_REQUEST['q'])) {
	$smarty->assign('titulo_pagina', 'Resultados de carreras en '.$_REQUEST['q'].' - Runnity.com');
	$smarty->assign('titulo_breadcrumb','Resultados de tu búsqueda');
} else {
	$smarty->assign('titulo_pagina', 'Todas las carreras - Runnity.com');
	$smarty->assign('titulo_breadcrumb','Todas las carreras');
}

$smarty->assign('nextRaces',$services->getNextRuns());

$q="";
if (isset($_REQUEST['q'])) {
	$q=$_REQUEST['q'];
	if ($q="Busca carreras" or $q="Busca por nombre, localidad, provincia"){
		$q="";
	}
}

$tipoCarrera="";
if (isset($_REQUEST['inputTipoCarrera'])) {
	$tipoCarrera=$_REQUEST['inputTipoCarrera'];
}
$smarty->assign('hola', $tipoCarrera);


$results=$services->searchRuns($q,$tipoCarrera,$offset);
$smarty->assign('results',$results['data']);
$smarty->assign('count', $results['count']);
$smarty->assign('offset', $offset);

$smarty->display('searchresults.tpl');
?>