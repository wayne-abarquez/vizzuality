<?php

require 'libs/Smarty.class.php';

$smarty = new Smarty;

$smarty->assign('section', 'carrera');
$smarty->display('carrera.tpl');

?>