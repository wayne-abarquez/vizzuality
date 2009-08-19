<?php 

// load Smarty library 
require 'libs/Smarty.class.php';

$smarty = new Smarty; 

$smarty->assign('section', 'usuario');
$smarty->display('user.tpl');

?>