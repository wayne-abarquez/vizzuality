<?php

require './libs/Smarty.class.php';
require 'services/GastoPublico.php';

$smarty = new Smarty;
$services = new GastoPublico;

$municipio = $services->getOrganismoData($_REQUEST['id']);
$smarty->assign('logoPartido',$services->getLogoPartido($municipio));


$smarty->assign('municipio',$municipio);
$smarty->assign('regiones',$services->getFeaturedOrganismos());
$smarty->assign('orga_relacionados',$services->getNearOrganismos($_REQUEST['id']));
$smarty->assign('lista_licitaciones',$services->licitacionesByOrganism($_REQUEST['id'],0));

$smarty->display('municipio.tpl');

?>
