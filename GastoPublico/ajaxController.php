<?php
require 'services/GastoPublico.php';
$services = new GastoPublico;
session_start();

	if ($_REQUEST['method'] == 'vote_up') {
		$result = $services->vote('up',$_REQUEST['licitacion']);
		if($result) {
			echo("OK");
		} else {
			echo("INVALID");
		}
	}

	if ($_REQUEST['method'] == 'vote_down') {
		$result = $services->vote('down',$_REQUEST['licitacion']);
		if($result) {
			echo("OK");
		} else {
			echo("INVALID");
		}
	}
	
	if ($_REQUEST['method'] == 'new_comment') {
		$result = $services-> postComment('0',$_REQUEST['name'],$_REQUEST['email'],$_REQUEST['comment'],$_REQUEST['web'],$_REQUEST['licitacion_id'],'');
		if($result) {
			echo("OK");
		} else {
			echo("INVALID");
		}
	}

?>