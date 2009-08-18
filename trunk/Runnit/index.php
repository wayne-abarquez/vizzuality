<?php 

// load Smarty library 
require 'libs/Smarty.class.php';

$smarty = new Smarty; 

$smarty->assign('section', 'home');

/* $smarty->display('header.tpl'); */
$smarty->display('home.tpl');
/* $smarty->display('footer.tpl'); */

?>