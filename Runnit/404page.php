<?php

require 'libs/Smarty.class.php';

$smarty = new Smarty;

$smarty->assign('section', 'about');

$smarty->assign('titulo_pagina', '404 - Pagina no encontrada');

$smarty->display('404.tpl');

?>