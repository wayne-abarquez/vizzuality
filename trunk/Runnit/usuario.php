<?php 

// load Smarty library 
require 'libs/Smarty.class.php';

$smarty = new Smarty; 

$smarty->assign('section', 'usuario');

/* $smarty->display('header.tpl'); */
$smarty->display('user.tpl');
/* $smarty->display('footer.tpl'); */

?>