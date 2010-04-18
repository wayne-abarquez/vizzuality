<?php

require './libs/Smarty.class.php';
require 'services/GastoPublico.php';

$smarty = new Smarty;
$services = new GastoPublico;

$organismo = $services->getOrganismoData($_REQUEST['id']);
$smarty->assign('logoPartido',$services->getLogoPartido($organismo));

$smarty->assign('organismo',$organismo);
$smarty->assign('regiones',$services->getFeaturedOrganismos());
$smarty->assign('orga_relacionados',$services->getNearOrganismos($_REQUEST['id']));
$smarty->assign('lista_licitaciones',$services->licitacionesByOrganism($_REQUEST['id'],0));


	if ($organismo['org_contratante'] == 'Administración Local') {
		$smarty->display('municipio.tpl');
	} else {
		$smarty->display('organismo.tpl');
	}


?>