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
$smarty->assign('data', $data);
$smarty->assign('isAlreadyFriend', $services->isUserAlreadyFriend($data['datos']['id']));

$comentarios=$services->getComments($data['datos']['id'],'user');
$smarty->assign('comments', $comentarios);
$smarty->assign('nextRaces',$services->getUserRuns($data['datos']['id']));

$smarty->assign('titulo_pagina', 'Pagina de usuario de '.$data['datos']['username'].' - Runnity.com');

$smarty->assign('section', 'usuario');
$smarty->display('usuario_publico.tpl');

?>