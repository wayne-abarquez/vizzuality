<?php 

session_start();

require 'libs/Smarty.class.php';
require 'services/RunnitServices.php';

$smarty = new Smarty;
$services = new RunnitServices;

$smarty->assign('section', 'calendario');
$smarty->assign('races', $services->getRunListSmall());

$smarty->display('calendario.tpl');
?>