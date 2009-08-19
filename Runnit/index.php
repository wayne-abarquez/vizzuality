<?php 

// load Smarty library 
require 'libs/Smarty.class.php';

$smarty = new Smarty; 

$smarty->assign('section', 'home');
$smarty->display('home.tpl');

?>