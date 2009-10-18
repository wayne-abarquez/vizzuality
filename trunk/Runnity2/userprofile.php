<?php 

session_start();
// load Smarty library 
require 'libs/Smarty.class.php';
require 'services/RunnitServices.php';
require 'services/MediaServices.php';


$smarty = new Smarty; 
$services = new RunnitServices;
$mediaServices = new MediaServices;


if (!isset($_SESSION['logged'])) {
    header( 'Location: /login.php?url='.urlencode($_SERVER["REQUEST_URI"]) ) ;   
	die();
}

$error_msg="";

if(isset($_REQUEST['action'])) {
    $email     			=$_REQUEST['email'];
    $pass  				=$_REQUEST['pass'];
    $completename      	=$_REQUEST['completename'];
    $birthdayDay        =$_REQUEST['birthdayDay'];
    $birthdayMonth      =$_REQUEST['birthdayMonth'];
    $birthdayYear       =$_REQUEST['birthdayYear'];
    $locality          	=$_REQUEST['locality'];
    $lat                =$_REQUEST['lat'];
    $lon                =$_REQUEST['lon'];

	if ($_REQUEST['is_men']=="false") {
		$is_men=false;
	} else {
		$is_men=true;
	}
    
    $error_msg="";
    if($email=="") {
        $error_msg.="El email introducido es invalido<br>";
    }
    if($pass=="") {
        $error_msg.="La contraseña introducida es invalido<br>";
    }     
    if($completename=="") {
        $error_msg.="El nombre y apellidos  introducido es invalido<br>";
    }    
    if($birthdayDay=="") {
        $error_msg.="No ha especificado el día de nacimiento<br>";
    }    
    if($birthdayMonth=="") {
        $error_msg.="No ha especificado el mes de nacimiento<br>";
    }
    if($birthdayYear=="") {
        $error_msg.="No ha especificado el año de nacimiento<br>";
    }     
    if($locality=="") {
        $error_msg.="No ha especificado la localidad<br>";
    }       
    

    if($error_msg=="") {
        
        if(isset($_REQUEST['alertsCheckBox']) && $_REQUEST['alertsCheckBox']=="on") {
            //Desea recibir alertas 
            $radio=$_REQUEST['radius_interest'];            
        } else {
            $radio=0;
        }
        $user = $services->updateUser($_SESSION['user']['username'],$completename,$email,
            $pass,$birthdayDay,$birthdayMonth,$birthdayYear,$locality,$lat,$lon,$radio,$is_men);
            
        
    }
    
    
}


$smarty->assign('titulo_pagina', 'Pagina de usuario de '.$_SESSION['user']['username'].' - Runnity.com');
$smarty->assign('nextRaces',$services->getUserRuns($_SESSION['user']['id']));
$smarty->assign('comments',$services->getComments($_SESSION['user']['id'],'user'));
$smarty->assign('records',$services->getAllRecordsForUser($_SESSION['user']['id']));

$smarty->assign('privateData',$services->getUserPrivateData($_SESSION['user']['username']));

$smarty->assign('section', 'usuario');
$smarty->display('userprofile.tpl');




?>