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
define('DB_PASSWORD', '');

/** MySQL hostname */
define('DB_HOST', 'localhost');

define('MAPS_API_KEY', 'ABQIAAAAtDJGVn6RztUmxjnX5hMzjRStOuMBmHmR5ElafcCO2SePBXcFUxR-22Bxm_LIdksrEJtJh-M7LqJycw');

define('SERVER_URL', 'http://herbaribcn.ub.es/');

//Internatilization
require_once("language_".$_SESSION['lang'].".php");

?>