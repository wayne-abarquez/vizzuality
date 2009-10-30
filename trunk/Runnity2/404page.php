<?php

require 'libs/Smarty.class.php';
require 'services/RunnitServices.php';

$smarty = new Smarty;
$services = new RunnitServices;

$smarty->assign('nextRaces',$services->getNextRuns());
$smarty->assign('section', '404');
$smarty->assign('titulo_pagina', '404 - Pagina no encontrada');
$smarty->display('404.tpl');


?>