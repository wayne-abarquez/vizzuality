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
    $email     			=$_REQUEST['inputMail'];
    $pass  				=$_REQUEST['inputPassword'];
    $completename      	=$_REQUEST['inputName'];
    $birthdayDay        =$_REQUEST['birthdayDay'];
    $birthdayMonth      =$_REQUEST['birthdayMonth'];
    $birthdayYear       =$_REQUEST['birthdayYear'];
    $locality          	=$_REQUEST['inputLocalizacion'];
    $lon                =$_REQUEST['lat'];
    $lat                =$_REQUEST['lon'];

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
            $radio=$_REQUEST['inputRadio'];            
        } else {
            $radio=0;
        }
        $user = $services->updateUser($_SESSION['user']['username'],$completename,$email,
            $pass,$birthdayDay,$birthdayMonth,$birthdayYear,$locality,$lat,$lon,$radio,$is_men);        
    }

	//update records
	for ($i = 1; $i <= 9; $i++) {
		if($_REQUEST['rec_hh_'.$i]!="" and $_REQUEST['rec_mm_'.$i]!="" and $_REQUEST['rec_ss_'.$i]!="" and $_REQUEST['rec_dd_'.$i]!="") {
			$time_taken = $_REQUEST['rec_hh_'.$i] .":".$_REQUEST['rec_mm_'.$i] .":".$_REQUEST['rec_ss_'.$i].".".$_REQUEST['rec_dd_'.$i];
		    $sql="select update_user_record(".$_SESSION['user']['id'].",$i,'$time_taken')";			
			$result= pg_query($services->conn, $sql);			
		}

	}    
}


$smarty->assign('titulo_pagina', 'Pagina de usuario de '.$_SESSION['user']['username'].' - Runnity.com');
$smarty->assign('nextRaces',$services->getUserRuns($_SESSION['user']['id']));
$smarty->assign('comments',$services->getComments($_SESSION['user']['id'],'user'));
$smarty->assign('records',$services->getAllRecordsForUser($_SESSION['user']['id']));
$smarty->assign('friends',$services->getUserFriends($_SESSION['user']['id']));

$smarty->assign('privateData',$services->getUserPrivateData($_SESSION['user']['username']));

$smarty->assign('section', 'usuario');
$smarty->display('userprofile.tpl');




?>