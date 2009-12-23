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

$resultados = $services->searchSheets($nameauthoryearstring, $highertaxon,$genus,$localitytext, $countryname, $utmformula, $agenttext, $UnitID, $datetext,$datesearchtype,$offset);

if($resultados['singleId']!='') {
	header('Location: /sheetdetail.php?UnitID='.$resultados['singleId'].'&db='.$_REQUEST['db']);
}

if($resultados['singleName']!='') {
	header('Location: /taxondetail.php?nameauthoryearstring='.urlencode($resultados['singleName']).'&db='.$_REQUEST['db']);
}

$smarty->assign('SearchSheetsResults',$resultados);
$smarty->assign('families',$services->getAllFamilies());
$smarty->assign('countries',$services->getAllCountries());

$smarty->assign('kmlurl',add_or_change_parameter("iskml","true"));


$smarty->assign('section', 'sheetresult');
$smarty->display('sheetresult.tpl');




function add_or_change_parameter($parameter, $value)
{
 $params = array();
 $output = "?";
 $firstRun = true;
 foreach($_GET as $key=>$val)
 {
  if($key != $parameter)
  {
   if(!$firstRun)
   {
    $output .= "&";
   }
   else
   {
    $firstRun = false;
   }
   $output .= $key."=".urlencode($val);
  }
 }
 if(!$firstRun)
  $output .= "&";
 $output .= $parameter."=".urlencode($value);
 return htmlentities($output);
}



?>