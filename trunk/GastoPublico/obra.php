<?php

require './libs/Smarty.class.php';
require 'services/GastoPublico.php';

$smarty = new Smarty;
$services = new GastoPublico;

$orga_data = $services->getLicitacionDetails($_REQUEST['id']);

$id_orga = $services->getNearOrganismos($orga_data['grupo_fk']);

$smarty->assign('section','home');


$obra = $services->getLicitacionDetails($_REQUEST['id']);
$obra_titulo = $obra["titulo"];



$smarty->assign('obra_title',$obra_titulo);
 
$smarty->assign('obra',$services->getLicitacionDetails($_REQUEST['id']));


$smarty->assign('licitacion_id',$_REQUEST['id']);
$smarty->assign('otras_obras',$services->getOtherLicitacionesFromSameOrganismo($_REQUEST['id']));
$smarty->assign('comentarios',$services->getCommentsByLicitacion($_REQUEST['id']));
$smarty->assign('orga_relacionados',$services->getNearOrganismos($orga_data['grupo_fk']));
$smarty->display('obra.tpl');


	
?>
