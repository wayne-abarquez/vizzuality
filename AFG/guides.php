<?php
require('libs/Smarty.class.php');

$smarty = new Smarty;



//$smarty->force_compile = true;
$smarty->debugging = false;
$smarty->caching = true;
$smarty->cache_lifetime = 120;

$smarty->assign("title","Most popular Antartic Field Guides");
$smarty->assign("page","");

$smarty->display('guides.tpl');
?>
