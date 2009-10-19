<?php 

session_start();

if (!isset($_SESSION['logged'])) {
    header( 'Location: /login.php?url='.urlencode($_SERVER["REQUEST_URI"]) ) ;   
	die();
}



// load Smarty library 
require 'libs/Smarty.class.php';
require 'services/RunnitServices.php';
require 'services/MediaServices.php';


$smarty = new Smarty; 
$services = new RunnitServices;
$mediaServices = new MediaServices;


$smarty->assign('titulo_pagina', 'Pagina de usuario de '.$_SESSION['user']['username'].' - Runnity.com');
$smarty->assign('nextRaces',$services->getUserRuns($_SESSION['user']['id']));
$smarty->assign('friends',$services->getUserFriends($_SESSION['user']['id']));
$smarty->assign('comments',$services->getComments($_SESSION['user']['id'],'user'));
$smarty->assign('records',$services->getAllRecordsForUser($_SESSION['user']['id']));

$smarty->assign('privateData',$services->getUserPrivateData($_SESSION['user']['username']));
$smarty->assign('pictures',$mediaServices->getObjectPictures('picture',$_SESSION['user']['id']));

$smarty->assign('section', 'usuario');
$smarty->display('user.tpl');


?>