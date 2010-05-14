<?php
require('libs/Smarty.class.php');

$smarty = new Smarty;



//$smarty->force_compile = true;
$smarty->debugging = false;
$smarty->caching = true;
$smarty->cache_lifetime = 120;

$smarty->assign("title","AFG");
$smarty->assign("page","Species");

$smarty->display('species.tpl');
?>
