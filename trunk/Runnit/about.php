<?php

session_start();

require 'libs/Smarty.class.php';
require 'services/RunnitServices.php';

$smarty = new Smarty;
$services = new RunnitServices;

$smarty->assign('section', 'about');

$smarty->assign('titulo_pagina', 'Sobre nosotros - Runnity.com');

$smarty->display('about.tpl');

?>