<?php 

session_start();

// load Smarty library 
require 'libs/Smarty.class.php';
require 'services/RunnitServices.php';
require 'services/MediaServices.php';


//http://localhost:8888/image.php?id=152&source=carrera

$smarty = new Smarty; 
$services = new RunnitServices;
$mediaServices = new MediaServices;


$data=$mediaServices->getPictureDetails($_REQUEST['id']);
if(!$data) {
    header( 'Location: /404page.php' ) ; 
}

@if(($_SESSION['user']['id']==$data['user_fk']) and (isset($_REQUEST['action'])) and ($_REQUEST['action'] == "delete")) {
    //delete picture
    $mediaServices->removePicture($_REQUEST['id']);
    header( 'Location: /perfil/'.$_SESSION['user']['username'] ) ; 
    die();
}



$smarty->assign('pictureDetails',$data);

if ($_REQUEST['source']=="run") {
	$smarty->assign('source', "run");
	//voger mas imagenes de la misma carrera
	$fotosSet=$mediaServices->getObjectPictures('run',$data['belongs_to_fk']);
	$smarty->assign('pictures',$fotosSet);
	
} else {
	
	$smarty->assign('source', "user");
	//coger images del usaurio
	$fotosSet=$mediaServices->getUserPictures($data['user_fk']);
	$smarty->assign('pictures',$fotosSet);
}

$nextFotoId=0;
$previousFotoId=0;
$fotoPosition=1;
$total=count($fotosSet);

foreach ($fotosSet as $img) {
	if ($img['id']==$_REQUEST['id']) {
		if (($fotoPosition+1) > $total) {
			$nextFotoId=0;
		} else {
			$nextFotoId=$fotosSet[$fotoPosition]['id'];
		}	
		
		if (($fotoPosition-1) < 1) {
			$previousFotoId=0;
		} else {
			$previousFotoId=$fotosSet[$fotoPosition-2]['id'];
		}
		
		break;
		
	}	
	$fotoPosition++;
}

$canEdit=false;
@if($_SESSION['user']['id']==$data['user_fk']) {
    $canEdit=true;
}
$smarty->assign('canEdit', $canEdit);


$smarty->assign('previousFotoId', $previousFotoId);
$smarty->assign('nextFotoId', $nextFotoId);
$smarty->assign('totalFotos', $total);
$smarty->assign('fotoPosition', $fotoPosition);

$smarty->assign('titulo_pagina', 'Detalle de imagen - Runnity.com');
$smarty->assign('comments',$services->getComments($_REQUEST['id'],'picture'));


$smarty->assign('section', 'imagen');
$smarty->display('image.tpl');

?>