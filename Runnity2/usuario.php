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

$fotosSet=$mediaServices->getUserPictures($_SESSION['user']['id']);
$smarty->assign('pictures',$fotosSet);
$smarty->assign('user_id',$_SESSION['user']['id']);

$smarty->assign('titulo_pagina', 'Pagina de usuario de '.$_SESSION['user']['username'].' - Runnity.com');
$smarty->assign('nextRaces',$services->getUserRuns($_SESSION['user']['id']));
$smarty->assign('friends',$services->getUserFriends($_SESSION['user']['id']));
$smarty->assign('comments',$services->getComments($_SESSION['user']['id'],'user'));
$smarty->assign('records',$services->getAllRecordsForUser($_SESSION['user']['id']));
/* $smarty->assign('privateData',$services->getUserPrivateData($_SESSION['user']['username'])); */

$privateData=$services->getUserPrivateData($_SESSION['user']['username']);
$smarty->assign('privateData',$privateData);

$variable=$privateData;
$anio=substr($variable['datos']['birthday'],0,4);

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

/* $smarty->assign('groupUsers',$services->getGroupUsers(1)); */

$smarty->assign('section', 'usuario');
$smarty->display('user.tpl');


?>