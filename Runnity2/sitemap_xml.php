<?php

function encodeUrlParam ( $string )
{
  $string = trim($string);
    
  if ( ctype_digit($string) )
  {
    return $string;
  }
  else 
  {      
    // replace accented chars
    $accents = '/&([A-Za-z]{1,2})(grave|acute|circ|cedil|uml|lig);/';
    $string_encoded = htmlentities($string,ENT_NOQUOTES,'UTF-8');

    $string = preg_replace($accents,'$1',$string_encoded);
      
    // clean out the rest
    $replace = array('([\40])','([^a-zA-Z0-9-])','(-{2,})');
    $with = array('-','','-');
    $string = preg_replace($replace,$with,$string); 
  } 

  return strtolower($string);
}



header ("content-type: text/xml");
echo("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
echo("<urlset xmlns=\"http://www.sitemaps.org/schemas/sitemap/0.9\">");
echo("<url><loc>http://runnity.com</loc></url>");
echo("<url><loc>http://runnity.com/buscar</loc></url>");
echo("<url><loc>http://runnity.com/blog</loc></url>");
echo("<url><loc>http://runnity.com/sobre</loc></url>");
require 'services/RunnitServices.php';
$services = new RunnitServices;
foreach($services->getAllRunsSitemap() as $run) {
    echo("<url><loc>http://runnity.com/run/".$run['id']."/".encodeUrlParam($run['name'])."</loc></url>");
}

foreach($services->getAllUsersSitemap() as $user) {
    echo("<url><loc>http://runnity.com/user/".$user['username']."</loc></url>");
}

foreach($services->getAllImagesSitemap() as $img) {
    echo("<url><loc>http://runnity.com/picture/".$img['id']."/run</loc></url>");
}

echo("</urlset>");
?>