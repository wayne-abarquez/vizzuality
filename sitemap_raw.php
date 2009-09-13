<?php

require 'services/RunnitServices.php';
$services = new RunnitServices;
foreach($services->getRunsList() as $run) {
    echo("http://runnity.com/run/".$run['id']."/".str_replace(" ","/",$run['name'])."\n");
}
?>