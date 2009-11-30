<?php 

session_start();

require 'libs/Smarty.class.php';
require 'services/Services.php';

$smarty = new Smarty; 
$services = new Services;

$smarty->assign('BDSelected', $_REQUEST['db']);

$maxRows_Runits = 20;
$pageNum_Runits = 0;
if (isset($_GET['pageNum_Runits'])) {
  $pageNum_Runits = $_GET['pageNum_Runits'];
}
$startRow_Runits = $pageNum_Runits * $maxRows_Runits;

if ($_REQUEST['nameauthoryearstring']) 	{ $nameauthoryearstring = $_REQUEST['nameauthoryearstring']; } else {$nameauthoryearstring = "";}
if ($_REQUEST['highertaxon']) 			{ $highertaxon = $_REQUEST['highertaxon']; } else {$highertaxon = "";}
if ($_REQUEST['genus']) 				{ $genus = $_REQUEST['genus']; } else {$genus = "";}
if ($_REQUEST['localitytext'])		 	{ $localitytext = $_REQUEST['localitytext']; } else {$localitytext = "";}
if ($_REQUEST['countryname']) 			{ $countryname = $_REQUEST['countryname']; } else {$countryname = "";}
if ($_REQUEST['utmformula']) 			{ $utmformula = $_REQUEST['utmformula']; } else {$utmformula = "";}
if ($_REQUEST['agenttext']) 			{ $agenttext = $_REQUEST['agenttext']; } else {$agenttext = "";}
if ($_REQUEST['UnitID']) 				{ $UnitID = $_REQUEST['UnitID']; } else {$UnitID = "";}
if ($_REQUEST['datetext']) 				{ $datetext = $_REQUEST['datetext'];} else {$datetext = "";}
if ($_REQUEST['datesearchtype']) 		{ $datesearchtype = $_REQUEST['datesearchtype'];} else {$datesearchtype = "";}

$smarty->assign('nameauthoryearstring', $nameauthoryearstring);
$smarty->assign('highertaxon', $highertaxon);
$smarty->assign('genus', $genus);
$smarty->assign('localitytext', $localitytext);
$smarty->assign('countryname', $countryname);
$smarty->assign('utmformula', $utmformula);
$smarty->assign('agenttext', $agenttext);
$smarty->assign('UnitID', $UnitID);
$smarty->assign('datetext', $datetext);
$smarty->assign('datesearchtype', $datesearchtype);


//if ($_REQUEST['orderby']) 				{ $orderby = $_REQUEST['orderby']; }

$smarty->assign('SearchResults',$services->Search($pageNum_Runits,$nameauthoryearstring,$highertaxon,$genus,$localitytext,$countryname,$utmformula,$agenttext,$UnitID,$datetext,$datesearchtype));

$smarty->assign('section', 'bdresult_cat');
$smarty->display('bdresult_cat.tpl');

?>