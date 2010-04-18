<?php

require './libs/Smarty.class.php';
require 'services/GastoPublico.php';

$smarty = new Smarty;
$services = new GastoPublico;

$smarty->assign('obra',$services->getLicitacionDetails($_REQUEST['id']));

$smarty->display('obra.tpl');

?>
