<?php 

session_start();

require 'libs/Smarty.class.php';
require 'services/Services.php';

$smarty = new Smarty; 
$services = new Services;



$smarty->assign('Numregistros',$services->getTotalRecords());
$smarty->assign('NumRegistrosImagen',$services->getTotalRecordsWithImage());
$smarty->assign('NumRegistrosGeoreferenciados',$services->getTotalGeoreferenceRecords());

$smarty->assign('section', 'home');
$smarty->display('home.tpl');

?>