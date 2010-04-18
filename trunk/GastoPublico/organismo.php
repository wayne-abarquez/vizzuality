<?php

require './libs/Smarty.class.php';
require 'services/GastoPublico.php';

$smarty = new Smarty;
$services = new GastoPublico;

$smarty->assign('organismo',$services->getOrganismoData($_REQUEST['id']));
$smarty->assign('regiones',$services->getFeaturedOrganismos());
$smarty->assign('orga_relacionados',$services->getNearOrganismos($_REQUEST['id']));
$smarty->assign('lista_licitaciones',$services->getFeaturedOrganismos($_REQUEST['id'],0));

$smarty->display('organismo.tpl');

?>