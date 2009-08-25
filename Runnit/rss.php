<?php
header("Content-Type: application/xml; charset=UTF-8"); 
require 'libs/Smarty.class.php';
require 'services/RunnitServices.php';

$smarty = new Smarty;
$services = new RunnitServices;

$smarty->assign('runs',$services->getRunsList(50));

$smarty->display('rss.tpl');

?>