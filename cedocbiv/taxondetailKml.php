<?php 

session_start();
require_once($_SERVER['DOCUMENT_ROOT'] ."/config.php");

require 'libs/Smarty.class.php';
require 'services/Services.php';

$smarty = new Smarty; 
$services = new Services;

$nameauthoryearstring = $_REQUEST['nameauthoryearstring'];

$data =$services->getUnitCoordinateDetailsByTaxon($nameauthoryearstring);
$smarty->assign('data',$data);

header ("Content-Type: application/vnd.google-earth.kml+xml");
/* header("Content-Disposition: attachment; filename=taxondetail".$nameauthoryearstring.".kml"); */
header("Content-Disposition: attachment; filename=taxondetail.kml");


$smarty->display('taxondetailKml.tpl');


?>