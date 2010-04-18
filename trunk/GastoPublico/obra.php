<?php

require './libs/Smarty.class.php';
require 'services/GastoPublico.php';

$smarty = new Smarty;
$services = new GastoPublico;

$orga_data = $services->getLicitacionDetails($_REQUEST['id']);

$id_orga = $services->getNearOrganismos($orga_data['grupo_fk']);

$smarty->assign('section','home');


$obra = $services->getLicitacionDetails($_REQUEST['id']);
$obra_titulo = strtoupper($obra["titulo"]);



$smarty->assign('obra_title',$obra_titulo);
 
$smarty->assign('obra',$obra);


$smarty->assign('licitacion_id',$_REQUEST['id']);
$smarty->assign('otras_obras',$services->getOtherLicitacionesFromSameOrganismo($_REQUEST['id']));

$comments=$services->getCommentsByLicitacion($_REQUEST['id']);
foreach($comments as &$comment) {
	$comment["md5_imagen"] = "http://www.gravatar.com/avatar.php?gravatar_id=".md5($comment["email"]);
} 

$smarty->assign('comentarios',$comments );
$smarty->assign('orga_relacionados',$services->getNearOrganismos($orga_data['grupo_fk']));
$smarty->display('obra.tpl');


	
?>
