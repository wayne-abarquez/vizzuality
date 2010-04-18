<?php

require './libs/Smarty.class.php';
require 'services/GastoPublico.php';


$smarty = new Smarty;
$services = new GastoPublico;

$smarty->assign('section','home');
$smarty->assign('messageHome','localizated');

$smarty->assign('licitaciones',$services->getFeaturedLicitaciones());
$smarty->assign('regiones',$services->getFeaturedOrganismos());

$smarty->display('home.tpl');



?>