<?php

session_start();

require 'libs/Smarty.class.php';
require 'services/RunnitServices.php';

$smarty = new Smarty;
$services = new RunnitServices;

$smarty->assign('section', 'searchresults');
if(isset($_REQUEST['q'])) {
	$smarty->assign('titulo_pagina', 'Resultados de carreras en '.$_REQUEST['q'].' - Runnity.com');
	$smarty->assign('titulo_breadcrumb','Resultados de tu búsqueda');
} else {
	$smarty->assign('titulo_pagina', 'Todas las carreras - Runnity.com');
	$smarty->assign('titulo_breadcrumb','Todas las carreras');
}

$offset=0;
if(isset($_REQUEST['offset'])) {
    $offset=$_REQUEST['offset'];
}

$hayQ=false;
$q="";
if (isset($_REQUEST['q'])) {
	$q=$_REQUEST['q'];
	if ($q=="Busca carreras" or $q=="Busca por nombre, localidad, provincia"){
		$q="";
	}
	if(strlen($q)>0) {
	    $hayQ=true;
	}
}

$tipoCarrera="";
if (isset($_REQUEST['tipoCarrera'])) {
	$tipoCarrera=$_REQUEST['tipoCarrera'];
}
$smarty->assign('tipoCarrera', $tipoCarrera);

$fechaInicio="";
$fechaInicioOld="";
if (isset($_REQUEST['fechaInicio'])) {
	$fechaInicio=$_REQUEST['fechaInicio'];
	$fechaInicioOld=$fechaInicio;
	$dia=substr($fechaInicio,0,2);
	$mes=substr($fechaInicio,3,2);
	$anio=substr($fechaInicio,6,4);
	if($fechaInicio!=""){
		$fechaInicio = $anio."-".$mes."-".$dia;
	}
}
$smarty->assign('fechaInicio', $fechaInicio);
$smarty->assign('fechaInicioOld', $fechaInicioOld);

$fechaFin="";
$fechaFinOld="";
if (isset($_REQUEST['fechaFin'])) {
	$fechaFin=$_REQUEST['fechaFin'];
	$fechaFinOld=$fechaFin;
	$dia=substr($fechaFin,0,2);
	$mes=substr($fechaFin,3,2);
	$anio=substr($fechaFin,6,4);
	if($fechaFin!=""){
		$fechaFin = $anio."-".$mes."-".$dia;
	}
}
$smarty->assign('fechaFin', $fechaFin);
$smarty->assign('fechaFinOld', $fechaFinOld);


if (isset($_REQUEST['tipoBusqueda'])) {
	$tipoBusqueda=$_REQUEST['tipoBusqueda'];
} else {
    if($q=="") {
        $tipoBusqueda="Proximas";
    } else {
        $tipoBusqueda="Todas";
    }
 
}

$smarty->assign('tipoBusqueda', $tipoBusqueda);

$results=$services->searchRuns($q,$tipoCarrera,$tipoBusqueda,$fechaInicio,$fechaFin,$offset);
$smarty->assign('results',$results['data']);
$smarty->assign('count', $results['count']);
$smarty->assign('offset', $offset);

if(isset($_REQUEST['format']) && $_REQUEST['format']=="rss") {
    $titulo="Runnity.com: ".$q.", ".$tipoCarrera;
    $smarty->assign('titulo',$titulo);
    $smarty->display('rss.tpl');
} else {
    $smarty->display('searchresults.tpl');
}


?>