<?php 

session_start();


// load Smarty library 
require 'libs/Smarty.class.php';
require 'services/RunnitServices.php';
require 'services/MediaServices.php';


$smarty = new Smarty; 
$services = new RunnitServices;
$mediaServices = new MediaServices;


if(isset($_REQUEST['u'])) {
    $username=$_REQUEST['u'];
} else {
    echo("falta parametro u");
    die();
}

$data=$services->getUserInfo($username);
$smarty->assign('data', $data);

if (isset($_SESSION['logged']) and $_SESSION['logged']) {
    $smarty->assign('isAlreadyFriend', $services->isUserAlreadyFriend($data['datos']['id']));
}

$fotosSet=$mediaServices->getUserPictures($data['datos']['id']);
$smarty->assign('pictures',$fotosSet);

$smarty->assign('friends',$services->getUserFriends($data['datos']['id']));

$comentarios=$services->getComments($data['datos']['id'],'user');
$smarty->assign('comments', $comentarios);
$smarty->assign('nextRaces',$services->getUserRuns($data['datos']['id']));

$smarty->assign('titulo_pagina', 'Pagina de usuario de '.$data['datos']['username'].' - Runnity.com');

$anio=substr($data['datos']['birthday'],0,4);

//categoría
switch ($anio){
	case ($anio>="1987" && $anio<="1989"):
		$categoria="Promesa";
	break;
	case ($anio>="1990" && $anio<="1991"):
		$categoria="Júnior";
	break;
	case ($anio>="1992" && $anio<="1993"):
		$categoria="Juvenil";
	break;
	case ($anio>="1994" && $anio<="1995"):
		$categoria="Cadete";
	break;
	case ($anio>="1996" && $anio<="1997"):
		$categoria="Infantil";
	break;
	case ($anio>="1998" && $anio<="1999"):
		$categoria="Alevín";
	break;
	case ($anio>="2000" && $anio<="2001"):
		$categoria="Benjamín";
	break;
		case ($anio<="1974"):
		$categoria="Veterano";
	break;
	case ($anio>="1975" && $anio<="1986"):
		$categoria="Senior";
	break;
	case ($anio>="2002"):
		$categoria="Pre-Benjamín";
	break;
}
$smarty->assign('categoria',$categoria);

$smarty->assign('section', 'usuario');
$smarty->display('usuario_publico.tpl');

?>