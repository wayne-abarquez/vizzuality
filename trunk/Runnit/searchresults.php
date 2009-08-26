<?php

require 'libs/Smarty.class.php';
require 'services/RunnitServices.php';

$smarty = new Smarty;
$services = new RunnitServices;

$offset=0;
if(isset($_REQUEST['offset'])) {
    $offset=$_REQUEST['offset'];
}

$smarty->assign('section', 'searchresults');
$smarty->assign('titulo_pagina', 'Resultados de carreras en '.$_REQUEST['q'].' - Runnity.com');
$smarty->assign('nextRaces',$services->getNextRuns());

$results=$services->searchRuns($_REQUEST['q'],$_REQUEST['distancia_min'],$_REQUEST['distancia_max'],$offset);
$smarty->assign('results',$results['data']);
$smarty->assign('count', $results['count']);
$smarty->assign('offset', $offset);

$smarty->display('searchresults.tpl');
?>