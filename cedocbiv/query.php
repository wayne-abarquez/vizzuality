<?php 

session_start();
require_once(dirname(__FILE__) ."/config.php");



require 'libs/Smarty.class.php';
require 'services/Services.php';

$smarty = new Smarty; 
$services = new Services;

$smarty->assign('BDSelected', $_REQUEST['db']);
$_SESSION['db']=$_REQUEST['db'];

$smarty->assign('LastUpdate',$services->getLastUpdate());
$smarty->assign('Numregistros',$services->getTotalRecords());

$smarty->assign('genus',$services->getAllGenus());
$smarty->assign('families',$services->getAllFamilies());
$smarty->assign('countries',$services->getAllCountries());

//set the default suggestions
if($_SESSION['db']=="algas") {
    $smarty->assign('nomCientifSug',"Cystos*");
    $smarty->assign('localitSug',"Cap*");
    $smarty->assign('recolSug',"Ribe*");
    $smarty->assign('numHerbSug',"1983");
}
if($_SESSION['db']=="briofitos") {
    $smarty->assign('nomCientifSug',"Acaul*");
    $smarty->assign('localitSug',"Barc*");
    $smarty->assign('recolSug',"Cana*");
    $smarty->assign('numHerbSug',"682");    
}
if($_SESSION['db']=="cormofitos") {
    $smarty->assign('nomCientifSug',"Anthyl*");
    $smarty->assign('localitSug',"Balag*");
    $smarty->assign('recolSug',"Senne*");
    $smarty->assign('numHerbSug',"52610");    
}
if($_SESSION['db']=="carpoteca") {
    $smarty->assign('nomCientifSug',"Anthy*");
    $smarty->assign('localitSug',"Vall*");
    $smarty->assign('recolSug',"Berd*");
    $smarty->assign('numHerbSug',"1193");    
}
if($_SESSION['db']=="hongos") {
    $smarty->assign('nomCientifSug',"Taphr*");
    $smarty->assign('localitSug',"Sala*");
    $smarty->assign('recolSug',"Des*");
    $smarty->assign('numHerbSug',"43");    
}
if($_SESSION['db']=="liquenes") {
    $smarty->assign('nomCientifSug',"Calop*");
    $smarty->assign('localitSug',"Del*");
    $smarty->assign('recolSug',"Llim*");
    $smarty->assign('numHerbSug',"1478");    
}

$smarty->display('query.tpl');

?>