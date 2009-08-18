<?php

require 'libs/Smarty.class.php';

$smarty = new Smarty;

$smarty->assign('section', 'carrera');

$smarty->display('header.tpl');
$smarty->display('carrera.tpl');
$smarty->display('footer.tpl');

?>