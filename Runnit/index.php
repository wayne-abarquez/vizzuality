<?php 

require 'libs/Smarty.class.php';
require 'services/RunnitServices.php';

$smarty = new Smarty; 
$services = new RunnitServices;


$smarty->assign('highlightedRun',$services->getHighlightedRun());
$smarty->assign('nextRaces',$services->getNextRuns());
$smarty->assign('runners',$services->getLastUsersInscribedToRuns());




$smarty->display('home.tpl');

?>