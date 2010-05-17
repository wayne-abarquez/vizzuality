<?php

session_start();

require 'libs/Smarty.class.php';
require 'services/RunnitServices.php';
require 'services/MediaServices.php';

$smarty = new Smarty;
$services = new RunnitServices;
$mediaServices = new MediaServices;


$data=$services->getRunDetails($_REQUEST['id']);
if(!isset($data['name'])) {
	header("HTTP/1.0 404 Not Found"); 
	$smarty->assign('section', '404');
	$smarty->assign('titulo_pagina', '404 - Pagina no encontrada');
	$smarty->display('404.tpl');	
	die();
}

$smarty->assign('section', 'carrera');


$smarty->assign('titulo_pagina', $data['name'] . ' - Runnity.com');
$meta_keywords=$data['name'] . ',' . $data['event_location'] . ',' . 'running,popular,carrera popular,carrera, atletismo,correr,runner,fotos,comentarios';
$meta_keywords=ereg_replace('"',",",$meta_keywords); //reemplaza las comillas dobles por un espacio en blanco
$meta_keywords=ereg_replace(',,',",",$meta_keywords); //reemplaza dos comas por una
$meta_keywords=htmlentities($meta_keywords);
$smarty->assign('meta_keywords',$meta_keywords);

if($data['description']) {
	$metaDescription=myTruncate(($data['event_location'] . ',' . $data['description']),66);
	$smarty->assign('meta_description',$metaDescription );
}else{
	$smarty->assign('meta_description', 'Información, fotos y comentarios sobre ' . $data['name'] . ',' . $data['event_location'] . ',' .$data['event_date']);
}

$data['description'] = nl2br($data['description']);

$smarty->assign('data',$data);

//generate the embadable code
$smartyEmbed = new Smarty;
$smartyEmbed->assign('data',$data);
$embedableCode = $smartyEmbed->fetch('widgetEmbedableCode.tpl');

$embedableCode = trim( preg_replace( '/\s+/', ' ', $embedableCode ) );  
$embedableCode = htmlspecialchars($embedableCode);
$smarty->assign('embedableCode',$embedableCode);

//--------

$smarty->assign('runners',$services->getLastUsersInscribedToRuns($_REQUEST['id']));
$smarty->assign('comments',$services->getComments($_REQUEST['id'],'run'));

$smarty->assign('similarTypeRaces',$services->getRunsSimilarDistance($_REQUEST['id'],$data['distance_meters'],$data['start_point_lat'],$data['start_point_lon']));
$smarty->assign('runsInSameDates',$services->getRunsInSimilarDates($_REQUEST['id'],$data['start_point_lat'],$data['start_point_lon']));

$smarty->assign('pictures',$mediaServices->getObjectPictures('run',$_REQUEST['id']));

$smarty->display('carrera.tpl');

function myTruncate($string, $limit, $break=".", $pad="...")
{
	$string=ereg_replace(chr(10)," ",$string);
	$string=ereg_replace(chr(13)," ",$string);
	$string=htmlentities($string);
  // return with no change if string is shorter than $limit
  if(strlen($string) <= $limit) return $string;

  // is $break present between $limit and the end of the string?
  if(false !== ($breakpoint = strpos($string, $break, $limit))) {
    if($breakpoint < strlen($string) - 1) {
      $string = substr($string, 0, $breakpoint) . $pad;
    }
  }
    
  return $string;
}

?>