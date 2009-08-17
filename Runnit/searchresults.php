<?php

require 'libs/Smarty.class.php';

$smarty = new Smarty;

$smarty->display('header.tpl');
$smarty->display('searchresults.tpl');
$smarty->display('footer.tpl');

?>