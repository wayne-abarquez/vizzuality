<?php

require 'libs/Smarty.class.php';
require 'services/RunnitServices.php';

session_start();

$smarty = new Smarty;
$services = new RunnitServices;




$smarty->assign('section', 'registro');

$smarty->display('registro_success.tpl');
?>