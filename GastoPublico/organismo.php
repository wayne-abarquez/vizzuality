<?php

require './libs/Smarty.class.php';
require 'services/GastoPublico.php';

$smarty = new Smarty;
$services = new GastoPublico;

$organismo = $services->getOrganismoData($_REQUEST['id']);

$smarty->assign('section','home');

$smarty->assign('organismo',$organismo);

$smarty->assign('regiones',$services->getFeaturedOrganismos());
$smarty->assign('orga_relacionados',$services->getNearOrganismos($_REQUEST['id']));
$smarty->assign('lista_licitaciones',$services->licitacionesByOrganism($_REQUEST['id'],0));

$urlLogoPartido = "../images/iconospartido/default.png";

if ($organismo["partido_politico"] == "PP"){
	$urlLogoPartido = "../images/iconospartido/pp.png";
}
if ($organismo["partido_politico"] == "CIU"){
	$urlLogoPartido = "../images/iconospartido/ciu.png";
}
if ($organismo["partido_politico"] == "ESQUERRA"){
	$urlLogoPartido = "../images/iconospartido/esquerra.png";	
}
if ($organismo["partido_politico"] == "FALANGE"){
	$urlLogoPartido = "../images/iconospartido/falange.png";	
}
if ($organismo["partido_politico"] == "PP"){
	$urlLogoPartido = "../images/iconospartido/iu.png";	
}
if ($organismo["partido_politico"] == "LOSVERDES"){
	$urlLogoPartido = "../images/iconospartido/losverdes.png";	
}
if ($organismo["partido_politico"] == "PNV"){
	$urlLogoPartido = "../images/iconospartido/pnv.png";	
}
if ($organismo["partido_politico"] == "PSOE"){
	$urlLogoPartido = "../images/iconospartido/psoe.png";	
}
	
$smarty->assign('logoPartido',$urlLogoPartido);
	
	if ($organismo['org_contratante'] == 'Administración Local') {
		$smarty->display('municipio.tpl');
	} else {
		$smarty->display('organismo.tpl');
	}
		


?>