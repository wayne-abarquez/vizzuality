<?php 

session_start();
require_once(dirname(__FILE__) ."/config.php");

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

if (isset($_REQUEST['nameauthoryearstring'])) 	{ $nameauthoryearstring = $_REQUEST['nameauthoryearstring']; } else {$nameauthoryearstring = "";}
if (isset($_REQUEST['highertaxon'])) 			{ $highertaxon = $_REQUEST['highertaxon']; } else {$highertaxon = "";}
if (isset($_REQUEST['genus'])) 				{ $genus = $_REQUEST['genus']; } else {$genus = "";}
if (isset($_REQUEST['localitytext']))		 	{ $localitytext = $_REQUEST['localitytext']; } else {$localitytext = "";}
if (isset($_REQUEST['countryname'])) 			{ $countryname = $_REQUEST['countryname']; } else {$countryname = "";}
if (isset($_REQUEST['utmformula'])) 			{ $utmformula = $_REQUEST['utmformula']; } else {$utmformula = "";}
if (isset($_REQUEST['agenttext'])) 			{ $agenttext = $_REQUEST['agenttext']; } else {$agenttext = "";}
if (isset($_REQUEST['UnitID'])) 				{ $UnitID = $_REQUEST['UnitID']; } else {$UnitID = "";}
if (isset($_REQUEST['datetext'])) 				{ $datetext = $_REQUEST['datetext'];} else {$datetext = "";}
if (isset($_REQUEST['datesearchtype'])) 		{ $datesearchtype = $_REQUEST['datesearchtype'];} else {$datesearchtype = "";}

$results=$services->searchSheets($nameauthoryearstring,$highertaxon,$genus,$localitytext,$countryname,$utmformula,$agenttext,$UnitID,$datetext,$datesearchtype,$offset);

foreach($results['datos'] as &$res) {
    $res['localitytext']= utf8_encode($res['localitytext']);
    $res['BiotopeText']= utf8_encode($res['BiotopeText']);
    $res['nameauthoryearstring']= utf8_encode($res['nameauthoryearstring']);
}

$smarty->assign('SearchSheetsResults',$results);


header ("Content-Type: application/vnd.google-earth.kml+xml");
header("Content-Disposition: attachment; filename=cedocbivSearchResults.kml");

$smarty->display('sheetresultKml.tpl');


?>