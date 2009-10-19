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
$smarty->assign('comments',$services->getComments($_SESSION['user']['id'],'run'));

$data=$services->getRunDetails($_REQUEST['id']);

$smarty->assign('data',$data);

$targetPicture="/media/run/".$_REQUEST['id']."/".$_REQUEST['picId']."_".$_REQUEST['type'].".jpg";
$smarty->assign('targetPicture', $targetPicture);
$smarty->assign('pictures',$mediaServices->getObjectPictures('run',$_REQUEST['id']));

$smarty->assign('section', 'usuario');
$smarty->display('image.tpl');

?>