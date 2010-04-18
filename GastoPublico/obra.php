<?php

require './libs/Smarty.class.php';
require 'services/GastoPublico.php';

$smarty = new Smarty;
$services = new GastoPublico;

$orga_data = $services->getLicitacionDetails($_REQUEST['id']);

$id_orga = $services->getNearOrganismos($orga_data['grupo_fk']);


$smarty->assign('obra',$services->getLicitacionDetails($_REQUEST['id']));
$smarty->assign('otras_obras',$services->getOtherLicitacionesFromSameOrganismo($_REQUEST['id']));
$smarty->assign('comentarios',$services->getCommentsByLicitacion($_REQUEST['id']));
$smarty->assign('orga_relacionados',$services->getNearOrganismos($orga_data['grupo_fk']));
$smarty->display('obra.tpl');

function getLogoPartido($organismo) {
	$urlLogo = "images/iconospartido/andalucista.png";
	
	if ($organismo["partido_politico"] == "PP"){
		$urlLogo = "images/iconospartido/pp.png";
		return $urlLogo;
	}
	if ($organismo["partido_politico"] == "CIU"){
		$urlLogo = "images/iconospartido/ciu.png";
		return $urlLogo;	
	}
	if ($organismo["partido_politico"] == "ESQUERRA"){
		$urlLogo = "images/iconospartido/esquerra.png";	
		return $urlLogo;
	}
	if ($organismo["partido_politico"] == "FALANGE"){
		$urlLogo = "images/iconospartido/falange.png";	
		return $urlLogo;
	}
	if ($organismo["partido_politico"] == "PP"){
		$urlLogo = "images/iconospartido/iu.png";	
		return $urlLogo;
	}
	if ($organismo["partido_politico"] == "LOSVERDES"){
		$urlLogo = "images/iconospartido/losverdes.png";	
		return $urlLogo;
	}
	if ($organismo["partido_politico"] == "PNV"){
		$urlLogo = "images/iconospartido/pnv.png";	
		return $urlLogo;
	}
	if ($organismo["partido_politico"] == "PSOE"){
		$urlLogo = "images/iconospartido/psoe.png";	
		return $urlLogo;
	}

	
      return $urlLogo;
  }

?>
