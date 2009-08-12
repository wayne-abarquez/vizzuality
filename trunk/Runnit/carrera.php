<?php

require 'libs/Smarty.class.php';

$smarty = new Smarty;

$smarty->display('header.tpl');
$smarty->display('carrera.tpl');
$smarty->display('footer.tpl');

?>