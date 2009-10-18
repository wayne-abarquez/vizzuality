<?php 

// load Smarty library 
require 'libs/Smarty.class.php';
require 'services/RunnitServices.php';

session_start();

$services = new RunnitServices;

if(isset($_REQUEST['action'])) {
	//comprobar login y pasarle si acaso...
    try {
        $user= $services->login($_REQUEST['username'],$_REQUEST['password']);
		header( 'Location: '.$_REQUEST['url'] ) ;
    } catch(Exception $e) {
    }	
} 

if (!isset($_REQUEST['url'])) {
	error_log("intento de login sin URL");
	header( 'Location: /' ) ;   
    exit();
}
$url = $_REQUEST['url'];


if (isset($_SESSION['user'])) {
	//Aqui seria posible poder enviarle directamente
}




$smarty = new Smarty; 



$smarty->assign('titulo_pagina', 'Login para continuar... - Runnity.com');

$smarty->assign('section', 'usuario');
$smarty->assign('url', $url);
$smarty->display('login.tpl');

?>