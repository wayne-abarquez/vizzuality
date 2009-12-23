<?php 

session_start();
require_once(dirname(__FILE__) ."/config.php");

require 'libs/Smarty.class.php';
require 'services/Services.php';

$smarty = new Smarty; 
$services = new Services;

$UnitID = $_REQUEST['UnitID'];

$data =$services->getUnitCoordinateDetailsByUnitID($UnitID);
$data['LocalityText']= htmlspecialchars(utf8_encode($data['LocalityText']));
$data['BiotopeText']= htmlspecialchars(utf8_encode($data['BiotopeText']));
$data['NameAuthorYearString']= htmlspecialchars(utf8_encode($data['NameAuthorYearString']));

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