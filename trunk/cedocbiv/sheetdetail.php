<?php 

session_start();
require_once(dirname(__FILE__) ."/config.php");

require 'libs/Smarty.class.php';
require 'services/Services.php';

$smarty = new Smarty; 
$services = new Services;

$smarty->assign('BDSelected', $_REQUEST['db']);
$UnitID = $_REQUEST['UnitID'];

$data=$services->getAllUnitDetailsByUnitID($UnitID);
$smarty->assign('Units',$data);

$smarty->assign('Ident',$services->getAllIdentificByUnitID($UnitID));
$smarty->assign('Images',$services->getAllImagesByUnitID($UnitID));
$smarty->assign('Agents',$services->getAllAgentsByUnitID($UnitID));
$smarty->assign('Areas',$services->getAllAreasByUnitID($UnitID));


if($data['LatitudeDecimal']!='') {
	$smarty->assign('isUtm',false);
} else {
	$smarty->assign('isUtm',true);
}

$smarty->assign('section', 'sheetdetail');
$smarty->display('sheetdetail2.tpl');

?>