<?php
require 'services/MediaServices.php';
$mediaServices = new MediaServices;
session_start();

if ($_REQUEST['method'] == 'uploadPicture') {
	$data=$mediaServices->uploadPicture($_FILES['userfile']['tmp_name'],$_REQUEST['onTable'],$_REQUEST['onId']);
	
	if($data) {
	    echo("<img src=\"".str_replace("_b.jpg","_t.jpg",$data['path'])."\"/>");	
	} else {
	    echo("error");
	}
}

if ($_REQUEST['method'] == 'uploadAvatar') {
	if($mediaServices->uploadAvatar($_FILES['userfile']['tmp_name'])) {
	    echo("success");
	} else {
	    echo("error");
	}
}

?>