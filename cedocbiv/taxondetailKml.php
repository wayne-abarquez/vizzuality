<?php 

session_start();
require_once(dirname(__FILE__) ."/config.php");

require 'libs/Smarty.class.php';
require 'services/Services.php';

$smarty = new Smarty; 
$services = new Services;

$nameauthoryearstring = $_REQUEST['nameauthoryearstring'];

$data =$services->getUnitCoordinateDetailsByTaxon($nameauthoryearstring);

foreach($data as &$res) {
    $res['LocalityText']= htmlspecialchars(utf8_encode($res['LocalityText']));
    $res['BiotopeText']= htmlspecialchars(utf8_encode($res['BiotopeText']));
    $res['NameAuthorYearString']= htmlspecialchars(utf8_encode($res['NameAuthorYearString']));
}

$smarty->assign('data',$data);

header ("Content-Type: application/vnd.google-earth.kml+xml");
header("Content-Disposition: attachment; filename=taxondetail.kml");

$smarty->display('taxondetailKml.tpl');


?>