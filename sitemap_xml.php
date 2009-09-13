<?php
header ("content-type: text/xml");
echo("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
echo("<urlset xmlns=\"http://www.sitemaps.org/schemas/sitemap/0.9\">");
echo("<url><loc>http://runnity.com</loc></url>");
echo("<url><loc>http://runnity.com/buscar</loc></url>");
echo("<url><loc>http://runnity.com/blog</loc></url>");
echo("<url><loc>http://runnity.com/sobre</loc></url>");
require 'services/RunnitServices.php';
$services = new RunnitServices;
foreach($services->getRunsList() as $run) {
    echo("<url><loc>http://runnity.com/run/".$run['id']."/".str_replace(" ","/",$run['name'])."</loc></url>");
}

echo("</urlset>");
?>