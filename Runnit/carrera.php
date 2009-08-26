<?php

require 'libs/Smarty.class.php';
require 'services/RunnitServices.php';

$smarty = new Smarty;
$services = new RunnitServices;

$smarty->assign('section', 'carrera');

$data=$services->getRunDetails($_REQUEST['id']);
$data['description'] = nl2br($data['description']);
$smarty->assign('titulo_pagina', $data['name'] . ' - Runnity.com');

$smarty->assign('data',$data);
$smarty->assign('runners',$services->getLastUsersInscribedToRuns($_REQUEST['id']));
$smarty->assign('comments',$services->getComments($_REQUEST['id'],'run'));
$smarty->assign('nextRaces',$services->getRunsCloseToAnother($_REQUEST['id']));


$smarty->display('carrera.tpl');

?>