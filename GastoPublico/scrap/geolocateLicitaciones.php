<?php
require_once('HttpClient.class.php');
require_once('../services/config.php');
require_once('../services/GastoPublico.php');

$url="http://wherein.yahooapis.com/v1/document";

$serv=new GastoPublico();

$client = new HttpClient('wherein.yahooapis.com',80);
$client->setDebug(false);

$sql="SELECT l.id as id,titulo,organismo, poblacion FROM licitacion as l inner join organismo as o on l.organismo_fk=o.id WHERE x(l.the_geom)=0 OR l.the_geom is null";
$res= pg_fetch_all(pg_query($serv->conn, $sql));

foreach($res as $lic) {


    $data=array();
    $data["documentContent"]=$lic['titulo']." ".$lic['organismo']." ".$lic['poblacion']." españa";
    $data["documentType"]="text/plain";
    $data["appid"]="GCKNXhjV34H9qJeXKu2Aw7u0y5o.g5b41tiSJCnBoWYgyrHw5bvsS71bBwtKiw--";
    $client->post("/v1/document",$data);

    $resYahoo = $client->getContent();
    $xml = simplexml_load_string($resYahoo);


        $lat = $xml->document->administrativeScope->centroid->latitude;
        $lon = $xml->document->administrativeScope->centroid->longitude;
    
        $sql="UPDATE licitacion set the_geom = setsrid(makepoint($lon,$lat),4326) WHERE id=".$lic["id"];
        $result=pg_query($serv->conn, $sql); 
        echo($lat." ".$lon."\n");

        usleep(2000000);


}

?>