<?php

require 'libs/Smarty.class.php';
require 'services/RunnitServices.php';

session_start();

$smarty = new Smarty;
$services = new RunnitServices;

//http://localhost/registro?email_register=&password_register=&username_register=&name_register=&sexo=true&birthdayDay=13&birthdayMonth=10&birthdayYear=2001&localidad=&action=Registrarse


if(isset($_REQUEST['action'])) {
    $error_msg="";
    $email_register     =$_REQUEST['email_register'];
    $password_register  =$_REQUEST['password_register'];
    $username_register  =$_REQUEST['username_register'];
    $name_register      =$_REQUEST['name_register'];
    $sexo               =$_REQUEST['sexo'];
    $birthdayDay        =$_REQUEST['birthdayDay'];
    $birthdayMonth      =$_REQUEST['birthdayMonth'];
    $birthdayYear       =$_REQUEST['birthdayYear'];
    $localidad          =$_REQUEST['localidad'];
    $lat                =$_REQUEST['lat'];
    $lon                =$_REQUEST['lon'];
    
    $error_msg="";
    if($email_register=="") {
        $error_msg.="El email introducido es invalido<br>";
    }
    if($password_register=="") {
        $error_msg.="La contraseña introducida es invalido<br>";
    }    
    if($username_register=="") {
        $error_msg.="El nombre de usuario introducido es invalido<br>";
    }    
    if($name_register=="") {
        $error_msg.="El nombre y apellidos  introducido es invalido<br>";
    }    
    if($sexo=="") {
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
    if($localidad=="") {
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
$error_msg="";



$smarty->assign('section', 'registro');
$smarty->assign('php_errors', $error_msg);

$smarty->display('registro.tpl');
?>