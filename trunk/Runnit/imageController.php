<?php
require 'services/RunnitServices.php';
$mediaServices = new MediaServices;

session_start();

if ($_REQUEST['method'] == 'uploadPicture') {
	if($mediaServices->uploadPicture($_FILES['userfile']['tmp_name'],$_REQUEST['onTable'],$_REQUEST['onId'])) {
	    echo("success");
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