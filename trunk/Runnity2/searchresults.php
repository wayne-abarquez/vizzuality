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

$q="";
if (isset($_REQUEST['q'])) {
	$q=$_REQUEST['q'];
	if ($q="Busca carreras" or $q="Busca por nombre, localidad, provincia"){
		$q="";
	}
}

$tipoCarrera="Todas";
if (isset($_REQUEST['tipoCarrera'])) {
	$tipoCarrera=$_REQUEST['tipoCarrera'];
}

$smarty->assign('tipoCarrera', $tipoCarrera);

$fechaInicio="";
if (isset($_REQUEST['fechaInicio'])) {
	$fechaInicio=$_REQUEST['fechaInicio'];
	$dia=substr($fechaInicio,0,2);
	$mes=substr($fechaInicio,3,2);
	$anio=substr($fechaInicio,6,4);
	$fechaInicio = $anio."-".$mes."-".$dia;
}
$smarty->assign('fechaInicio', $fechaInicio);

$fechaFin="";
if (isset($_REQUEST['fechaFin'])) {
	$fechaFin=$_REQUEST['fechaFin'];
	$dia=substr($fechaFin,0,2);
	$mes=substr($fechaFin,3,2);
	$anio=substr($fechaFin,6,4);
	$fechaFin = $anio."-".$mes."-".$dia;
}
$smarty->assign('fechaFin', $fechaFin);

$tipoBusqueda="Todas";
$smarty->assign('tipoBusqueda', $tipoBusqueda);
$results=$services->searchRuns($q,$tipoCarrera,$tipoBusqueda,$fechaInicio,$fechaFin,$offset);
$smarty->assign('results',$results['data']);
$smarty->assign('count', $results['count']);
$smarty->assign('offset', $offset);

$smarty->display('searchresults.tpl');
?>