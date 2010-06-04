<?php
require('libs/Smarty.class.php');

$smarty = new Smarty;



//$smarty->force_compile = true;
$smarty->debugging = false;
$smarty->caching = true;
$smarty->cache_lifetime = 120;

$smarty->assign("title","The definitive Antarctic Field Guide");
$smarty->assign("page","Guide");

$smarty->display('guide.tpl');
?>
