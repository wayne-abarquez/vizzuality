<?php

if(isset($_REQUEST['lang'])) {
	$_SESSION['lang']=$_REQUEST['lang'];
} else if(!isset($_SESSION['lang'])) {
	$_SESSION['lang']='cat';
}

if(isset($_REQUEST['db'])) {
	$_SESSION['db']=$_REQUEST['db'];
} else if(!isset($_SESSION['db'])) {
	$_SESSION['db']='cormofitos';
}


/** The name of the database for CeDocBiV */
define('DB_NAME', $_SESSION['db']);

/** MySQL database username */
define('DB_USER', 'root');

/** MySQL database password */
define('DB_PASSWORD', 'runnit');

/** MySQL hostname */
define('DB_HOST', 'localhost');

define('MAPS_API_KEY', 'ABQIAAAAtDJGVn6RztUmxjnX5hMzjRQRy8YepOF23kdRkT302wfDKzL13hSzHs7Y0PSzB-4OSF1KBovKXXo9xQ');

define('SERVER_URL', 'http://79.125.6.201/cedocbiv/temp/');

//Internatilization
require_once("language_".$_SESSION['lang'].".php");

?>