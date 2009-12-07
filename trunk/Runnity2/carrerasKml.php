<?php

session_start();

require 'libs/Smarty.class.php';
require 'services/RunnitServices.php';

$smarty = new Smarty;
$services = new RunnitServices;
$smarty->assign('runs',$services->getAllRuns(30,0));

header ("Content-Type: application/vnd.google-earth.kml+xml");

$smarty->display('carreras.kml');

?>