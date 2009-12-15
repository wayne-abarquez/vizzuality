<?php 

session_start();
require_once(dirname(__FILE__) ."/config.php");

require 'libs/Smarty.class.php';
require 'services/Services.php';

$smarty = new Smarty; 

$_SESSION['db']="algas";
$services = new Services;

$smarty->assign('NumregistrosAlgas',$services->getTotalRecords());
$smarty->assign('NumRegistrosImagenAlgas',$services->getTotalRecordsWithImage());
$smarty->assign('NumRegistrosGeoreferenciadosAlgas',$services->getTotalGeoreferenceRecords());

$_SESSION['db']="cormofitos";
$services = new Services;

$smarty->assign('NumregistrosCormofitos',$services->getTotalRecords());
$smarty->assign('NumRegistrosImagenCormofitos',$services->getTotalRecordsWithImage());
$smarty->assign('NumRegistrosGeoreferenciadosCormofitos',$services->getTotalGeoreferenceRecords());



$_SESSION['db']="briofitos";
$services = new Services;

$smarty->assign('NumregistrosBriofitos',$services->getTotalRecords());
$smarty->assign('NumRegistrosImagenBriofitos',$services->getTotalRecordsWithImage());
$smarty->assign('NumRegistrosGeoreferenciadosBriofitos',$services->getTotalGeoreferenceRecords());

$_SESSION['db']="carpoteca";
$services = new Services;

$smarty->assign('NumregistrosCarpoteca',$services->getTotalRecords());
$smarty->assign('NumRegistrosImagenCarpoteca',$services->getTotalRecordsWithImage());
$smarty->assign('NumRegistrosGeoreferenciadosCarpoteca',$services->getTotalGeoreferenceRecords());

$_SESSION['db']="hongos";
$services = new Services;

$smarty->assign('NumregistrosHongos',$services->getTotalRecords());
$smarty->assign('NumRegistrosImagenHongos',$services->getTotalRecordsWithImage());
$smarty->assign('NumRegistrosGeoreferenciadosHongos',$services->getTotalGeoreferenceRecords());

$_SESSION['db']="liquenes";
$services = new Services;

$smarty->assign('NumregistrosLiquenes',$services->getTotalRecords());
$smarty->assign('NumRegistrosImagenLiquenes',$services->getTotalRecordsWithImage());
$smarty->assign('NumRegistrosGeoreferenciadosLiquenes',$services->getTotalGeoreferenceRecords());


$smarty->assign('section', 'home');
$smarty->display('home2.tpl');

?>