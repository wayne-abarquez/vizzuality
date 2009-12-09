<?php 

session_start();
require_once($_SERVER['DOCUMENT_ROOT'] ."/config.php");

require 'libs/Smarty.class.php';
require 'services/Services.php';

$smarty = new Smarty; 
$services = new Services;

$smarty->assign('BDSelected', $_REQUEST['db']);

$offset=0;
if(isset($_REQUEST['offset'])) {
    $offset=$_REQUEST['offset'];
}

$smarty->assign('offset', $offset);

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

$smarty->assign('SearchSheetsResults',$services->searchSheets($nameauthoryearstring,$highertaxon,$genus,$localitytext,$countryname,$utmformula,$agenttext,$UnitID,$datetext,$datesearchtype,$offset));
$smarty->assign('families',$services->getAllFamilies());
$smarty->assign('countries',$services->getAllCountries());

$smarty->assign('section', 'sheetresult');
$smarty->display('sheetresult_'.$_SESSION['lang'].'.tpl');

?>