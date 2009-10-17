<?php 

session_start();

// load Smarty library 
require 'libs/Smarty.class.php';
require 'services/RunnitServices.php';
require 'services/MediaServices.php';


$smarty = new Smarty; 
$services = new RunnitServices;
$mediaServices = new MediaServices;


$smarty->assign('titulo_pagina', 'Detalle de imagen - Runnity.com');
$smarty->assign('comments',$services->getComments($_SESSION['user']['id'],'user'));

$smarty->assign('section', 'usuario');
$smarty->display('image.tpl');

?>