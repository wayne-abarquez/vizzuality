<?php

require './libs/Smarty.class.php';
require 'services/GastoPublico.php';


$smarty = new Smarty;
$services = new GastoPublico;

$smarty->assign('licitaciones',$services->getFeaturedLicitaciones());
$smarty->assign('regiones',$services->getFeaturedOrganismos());

$smarty->assign('section','about');


$smarty->display('about.tpl');

?>