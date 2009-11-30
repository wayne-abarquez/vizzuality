<?php 

session_start();

require 'libs/Smarty.class.php';
require 'services/Services.php';

$smarty = new Smarty; 
$services = new Services;



$smarty->assign('Numregistros',$services->GetNumberRegister());
$smarty->assign('NumRegistrosImagen',$services->GetNumberRegisterWithImage());
$smarty->assign('NumRegistrosGeoreferenciados',$services->GetNumberRegisterGeoreferenciados());

$smarty->assign('section', 'webbiocaseHome');
$smarty->display('home.tpl');

?>