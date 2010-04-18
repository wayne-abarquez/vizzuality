<?php

require './libs/Smarty.class.php';
require 'services/GastoPublico.php';

$smarty = new Smarty;
$services = new GastoPublico;


$smarty->assign('section','home');
$smarty->assign('messageHome','localizated');
$licitaciones=$services->getFeaturedLicitaciones();
foreach($licitaciones as &$lic) {
	$lic["titulo"]=ucfirst(strtolower($lic["titulo"]));
}

$smarty->assign('licitaciones',$licitaciones);
$smarty->assign('regiones',$services->getFeaturedOrganismos());

$organismosMapa = $services->getOrganismosForMapaHome();

$data="";
foreach($organismosMapa as $org) {
    $data.="{id:".$org['id'].",lat:".$org['lat'].",lon:".$org['lon'].",nombre:\"".$org['nombre']."\"},";
}
$data = substr_replace($data ,"",-1);
$smarty->assign('dataMapa',$data);
$smarty->display('home.tpl');


?>