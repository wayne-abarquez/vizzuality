<?php
	session_start();
	error_log("entrando a up_page.php");
	
	if(isset($_FILES['userfile']['tmp_name'])) {

		require "libs/class.imagetransform.php";
		$imgTrans = new imageTransform();
		$imgTrans->sourceFile = $_FILES['userfile']['tmp_name'];
		$imgTrans->targetFile = $services->basePath .'media/avatar/' . $_SESSION['user']['id'].".jpg";
		$imgTrans->resizeToWidth = 96;
		//$imgTrans->resizeToHeight = 67;
	    if (!$imgTrans->resize()) {
			echo "error";
	    } else {
			echo "success";
		}	
	}	
?>