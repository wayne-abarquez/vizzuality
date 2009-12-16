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

$smarty->assign('nameauthoryearstring', $nameauthoryearstring);
$smarty->assign('highertaxon', $highertaxon);
$smarty->assign('genus', $genus);

$smarty->assign('SearchTaxonResults',$services->searchTaxon($nameauthoryearstring,$highertaxon,$genus,$offset));

$smarty->assign('section', 'taxonresult');
$smarty->display('taxonresult.tpl');

?>