<?php

require './libs/Smarty.class.php';
require 'services/GastoPublico.php';

$smarty = new Smarty;
$services = new GastoPublico;

$smarty->assign('organismo',$services->getOrganismoData($_REQUEST['id']));
$smarty->display('organismo.tpl');

?>