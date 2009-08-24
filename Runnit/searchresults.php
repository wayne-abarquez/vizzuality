<?php

require 'libs/Smarty.class.php';
require 'services/RunnitServices.php';

$smarty = new Smarty;
$services = new RunnitServices;


$smarty->assign('section', 'searchresults');
$smarty->assign('count', 120);
$smarty->assign('nextRaces',$services->getNextRuns());

$smarty->display('searchresults.tpl');
?>