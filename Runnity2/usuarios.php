<?php

session_start();

require 'libs/Smarty.class.php';
require 'services/RunnitServices.php';

$smarty = new Smarty;
$services = new RunnitServices;

$smarty->assign('section', 'search_user');
if(isset($_REQUEST['q'])) {
	$smarty->assign('titulo_pagina', 'Resultados de usuario en '.$_REQUEST['q'].' - Runnity.com');
	$smarty->assign('titulo_breadcrumb','Resultados de tu búsqueda de usuario');
} else {
	$smarty->assign('titulo_pagina', 'Todos los usuarios - Runnity.com');
	$smarty->assign('titulo_breadcrumb','Todos los usuarios');
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
 

$results=$services->searchusers($q,$offset);
$smarty->assign('results',$results['data']);
$smarty->assign('count', $results['count']);
$smarty->assign('offset', $offset);

$smarty->display('search_user.tpl');
?>