<?php

require 'libs/Smarty.class.php';

$smarty = new Smarty;

$smarty->assign('section', 'searchresults');
$smarty->display('searchresults.tpl');

?>