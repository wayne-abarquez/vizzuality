<?php
require('libs/Smarty.class.php');

$smarty = new Smarty;



//$smarty->force_compile = true;
$smarty->debugging = false;
$smarty->caching = true;
$smarty->cache_lifetime = 120;

$smarty->assign("title","AFG");
$smarty->assign("page","Explore");

$smarty->display('explore.tpl');
?>
