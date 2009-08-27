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

$targetPicture=$services->basePath .'media/avatar/' . $_SESSION['user']['id'] . '.jpg';
if (file_exists($targetPicture)) {
	$smarty->assign('user_image', "/media/avatar/". $_SESSION['user']['id'] . ".jpg?".rand()); 
} else {
	$smarty->assign('user_image', "/media/avatar/0.jpg"); 
}


$smarty->assign('titulo_pagina', 'Pagina de usuario de '.$_SESSION['user']['username'].' - Runnity.com');
$smarty->assign('nextRaces',$services->getUserRuns($_SESSION['user']['id']));

$smarty->assign('section', 'usuario');
$smarty->display('user.tpl');

?>