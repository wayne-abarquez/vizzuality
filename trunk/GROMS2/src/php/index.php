<?php

require 'libs/Smarty.class.php';
require 'services/GROMSServices.php';

$smarty = new Smarty;
$services = new GROMSServices;


//$data =$services->getItemList(10);
//$smarty->assign('data', $data);
$smarty->display('index.tpl');

?>