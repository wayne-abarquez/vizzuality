<?php 
session_start();
if (!$_SESSION['logged']) {
	echo("No puedes acceder a esta pagina sin haberte logeado");
	die();
}


// load Smarty library 
require 'libs/Smarty.class.php';
require 'services/RunnitServices.php';

$smarty = new Smarty; 
$services = new RunnitServices;



$smarty->assign('section', 'usuario');
$smarty->display('user.tpl');

?>