<?php 

session_start();
require_once($_SERVER['DOCUMENT_ROOT'] ."/config.php");



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

$smarty->display('query_'.$_SESSION['lang'].'.tpl');

?>