<?php
header("Content-Type: application/xml; charset=UTF-8"); 
require 'libs/Smarty.class.php';
require 'services/RunnitServices.php';

$smarty = new Smarty;
$services = new RunnitServices;

$smarty->assign('results',$services->getRunsList(50));
$smarty->assign('titulo',"Próximas carreras en runnity.com");

$smarty->display('rss.tpl');

?>