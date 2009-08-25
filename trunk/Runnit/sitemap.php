<?php

require 'libs/Smarty.class.php';
require 'services/RunnitServices.php';

$smarty = new Smarty;
$services = new RunnitServices;

$smarty->assign('runs',$services->getRunsList());

$smarty->display('sitemap.tpl');

?>