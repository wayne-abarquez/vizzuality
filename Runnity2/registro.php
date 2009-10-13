<?php

session_start();


//http://localhost/registro?email_register=&password_register=&username_register=&name_register=&sexo=true&birthdayDay=13&birthdayMonth=10&birthdayYear=2001&localidad=&action=register


if($_REQUEST['action']=='register') {
    $error_msg="";
    if($_REQUEST['email_register']=="") {
        $error_msg.="El email introducido es invalido<br>";
    }
    if($_REQUEST['password_register']=="") {
        $error_msg.="La contraseña introducida es invalido<br>";
    }    
    if($_REQUEST['username_register']=="") {
        $error_msg.="El nombre de usuario introducido es invalido<br>";
    }    
    if($_REQUEST['name_register']=="") {
        $error_msg.="El nombre y apellidos  introducido es invalido<br>";
    }    
    if($_REQUEST['sexo']=="") {
        $error_msg.="No ha especificado si es hombre o mujer<br>";
    }    
    if($_REQUEST['birthdayDay']=="") {
        $error_msg.="No ha especificado el día de nacimiento<br>";
    }    
    if($_REQUEST['birthdayMonth']=="") {
        $error_msg.="No ha especificado el mes de nacimiento<br>";
    }
    if($_REQUEST['birthdayYear']=="") {
        $error_msg.="No ha especificado el año de nacimiento<br>";
    }     
    if($_REQUEST['localidad']=="") {
        $error_msg.="No ha especificado la localidad<br>";
    }       
    
}


require 'libs/Smarty.class.php';
require 'services/RunnitServices.php';

$smarty = new Smarty;
$services = new RunnitServices;

$smarty->assign('section', 'registro');

$smarty->display('registro.tpl');
?>