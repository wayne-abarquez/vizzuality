<?php 

session_start();


// load Smarty library 
require 'libs/Smarty.class.php';
require 'services/RunnitServices.php';


$smarty = new Smarty; 
$services = new RunnitServices;

if(isset($_REQUEST['u'])) {
    $username=$_REQUEST['u'];
} else {
    echo("falta parametro u");
    die();
}

$data=$services->getUserInfo($username);
$comentarios=$services->getComments($data['datos']['id'],'users');

$targetPicture=$services->basePath .'media/avatar/' . $data['datos']['id'] . '.jpg';
if (file_exists($targetPicture)) {
	$smarty->assign('user_image', "/media/avatar/". $data['datos']['id'] . ".jpg?".rand()); 
} else {
	$smarty->assign('user_image', "/media/avatar/0.jpg"); 
}


$smarty->assign('titulo_pagina', 'Pagina de usuario de '.$data['datos']['username'].' - Runnity.com');

$smarty->assign('section', 'usuario_publico');
$smarty->display('usuario_publico.tpl');

?>