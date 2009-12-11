<?php 

session_start();
require_once(dirname(__FILE__) ."/config.php");

require 'libs/Smarty.class.php';
require 'services/Services.php';

$smarty = new Smarty; 
$services = new Services;

$smarty->assign('BDSelected', $_REQUEST['db']);
$nameauthoryearstring = $_REQUEST['nameauthoryearstring'];

$smarty->assign('Pliegos',$services->getAllPliegosByTaxon($nameauthoryearstring));

$data=array();
$data =$services->getUnitCoordinateDetailsByTaxon($nameauthoryearstring);


if(count($data)>0) {
    $smarty->assign('hasGeo', true);
} else {
    $smarty->assign('hasGeo', false);
}


$smarty->assign('section', 'taxondetail');
$smarty->display('taxondetail.tpl');

?>