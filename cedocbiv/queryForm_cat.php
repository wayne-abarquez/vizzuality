<?php 

session_start();

require 'libs/Smarty.class.php';
require 'services/Services.php';

$smarty = new Smarty; 
$services = new Services;

$smarty->assign('BDSelected', $_REQUEST['db']);

$smarty->assign('LastUpdate',$services->GetLastUpdate());
$smarty->assign('Numregistros',$services->GetNumberRegister());

$prueba = $services->GetGenus();
error_log($prueba);

$smarty->assign('GenusResults',$prueba);
$smarty->assign('HighertaxonResults',$services->GetHighertaxon());
$smarty->assign('Countries',$services->GetCountryname());

$smarty->display('queryForm_cat2.tpl');

?>