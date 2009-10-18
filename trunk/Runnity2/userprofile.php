<?php 

session_start();

if (!isset($_SESSION['logged'])) {
	echo("No puedes acceder a esta pagina sin haberte logeado");
	die();
}

$error_msg="";

if(isset($_REQUEST['action'])) {
    $email     			=$_REQUEST['email'];
    $pass  				=$_REQUEST['pass'];
    $completename      	=$_REQUEST['completename'];
    $is_men             =$_REQUEST['is_men'];
    $birthdayDay        =$_REQUEST['birthdayDay'];
    $birthdayMonth      =$_REQUEST['birthdayMonth'];
    $birthdayYear       =$_REQUEST['birthdayYear'];
    $locality          	=$_REQUEST['locality'];
    $lat                =$_REQUEST['lat'];
    $lon                =$_REQUEST['lon'];
    
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
    if($is_men=="") {
        $error_msg.="No ha especificado si es hombre o mujer<br>";
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
        
        
        if(isset($_REQUEST['quiero']) && $_REQUEST['quiero']=="true") {
            //Desea recibir alertas 
            $radio="200";            
        } else {
            $radio=null;
        }
        $user = $services->registerUser($username_register,$name_register,$email_register,
            $password_register,$birthdayDay,$birthdayMonth,$birthdayYear,$localidad,$lat,$lon,$radio);
            
            
            
        //it is a success
        header( 'Location: /registro_success' ) ;   
        exit(); 
        
    }
    
    
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
$smarty->assign('comments',$services->getComments($_SESSION['user']['id'],'user'));
$smarty->assign('records',$services->getAllRecordsForUser($_SESSION['user']['id']));

$smarty->assign('privateData',$services->getUserPrivateData($_SESSION['user']['username']));

$smarty->assign('section', 'usuario');
$smarty->display('userprofile.tpl');

?>