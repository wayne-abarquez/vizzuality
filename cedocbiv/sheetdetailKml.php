<?php 

session_start();
require_once($_SERVER['DOCUMENT_ROOT'] ."/config.php");

require 'libs/Smarty.class.php';
require 'services/Services.php';

$smarty = new Smarty; 
$services = new Services;

$UnitID = $_REQUEST['UnitID'];

$data =$services->getUnitCoordinateDetailsByUnitID($UnitID);
$smarty->assign('data',$data);

if($data['LatitudeDecimal']!='') {
	$smarty->assign('isUtm',false);
} else {
	$smarty->assign('isUtm',true);
}

header ("Content-Type: application/vnd.google-earth.kml+xml");
header("Content-Disposition: attachment; filename=sheetdetail".$UnitID.".kml");

$smarty->display('sheetdetailKml.tpl');


?>