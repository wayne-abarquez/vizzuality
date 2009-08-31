<?php

require "libs/imagetransforms.php";
$basePath = "/Users/jatorre/workspace/runnit/";
$targetPicture=$basePath."media/run/".$_REQUEST['id'].".jpg";
$defaultPicture=$basePath."media/run/generic/1_big.jpg";

$minx=$_REQUEST['lon']-0.001;
$maxx=$_REQUEST['lon']+0.001;
$miny=$_REQUEST['lat']-0.001;
$maxy=$_REQUEST['lat']+0.001;
$id=$_REQUEST['id'];

if (file_exists($targetPicture)) {
    header("Content-Type: image/jpeg");
    header('Content-Length: '.filesize($targetPicture));
    print file_get_contents($targetPicture);
    die();
}

$url="http://www.panoramio.com/map/get_panoramas.php?order=popularity&set=public&from=0&to=1&minx=$minx&miny=$miny&maxx=$maxx&maxy=$maxy&size=medium";

$res=json_decode(file_get_contents($url));



if(isset($res->photos[0])) {
    $pic = file_get_contents($res->photos[0]->photo_file_url);
    file_put_contents($targetPicture, $pic);

    $imageTransform->crop($targetPicture, 618, 238, $targetPicture);
    header("Content-Type: image/jpeg");
    header('Content-Length: '.filesize($targetPicture));
    print file_get_contents($targetPicture);    
} else {
    header("Content-Type: image/jpeg");
    header('Content-Length: '.filesize($defaultPicture));    
    print file_get_contents($defaultPicture);     
}



?>