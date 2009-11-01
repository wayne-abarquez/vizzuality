<?php

require_once($_SERVER['DOCUMENT_ROOT'] ."/runnit-config.php");
require_once($_SERVER['DOCUMENT_ROOT'] ."/libs/Smarty.class.php");

$smarty = new Smarty;

$smarty->assign('section', '404');
$smarty->assign('titulo_pagina', '404 - Página no encontrada');
$smarty->display('404.tpl');


?>