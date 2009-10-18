<?php 

session_start();

// load Smarty library 
require 'libs/Smarty.class.php';
require 'services/RunnitServices.php';


$smarty = new Smarty; 
$services = new RunnitServices;


$smarty->assign('titulo_pagina', 'Login para continuar... - Runnity.com');

$smarty->assign('section', 'usuario');
$smarty->display('login.tpl');

?>