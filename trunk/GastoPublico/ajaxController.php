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

?>