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
$comentarios=$services->getComments($data['datos']['id'],'users');
$smarty->assign('comments', $comentarios);

$smarty->assign('titulo_pagina', 'Pagina de usuario de '.$data['datos']['username'].' - Runnity.com');

$smarty->assign('section', 'usuario_publico');
$smarty->display('usuario_publico.tpl');

?>