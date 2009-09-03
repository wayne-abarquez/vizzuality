<?php

require "libs/imagetransforms.php";
require_once("libs/phpFlickr.php");
$basePath = "/Users/jatorre/workspace/runnit/";
$targetPicture=$basePath."media/run/".$_REQUEST['id'].".jpg";
$defaultPicture=$basePath."media/run/generic/1_big.jpg";

$photo_id=$_REQUEST['photo_id'];
$id=$_REQUEST['id'];

if (file_exists($targetPicture)) {
    header("Content-Type: image/jpeg");
    header('Content-Length: '.filesize($targetPicture));
    print file_get_contents($targetPicture);
    die();
}

$f = new phpFlickr("8e4f99b9bb3c602984421a253d71f322");
$photo = $f->photos_getInfo($photo_id);



if($photo) {
    $pic = file_get_contents("http://farm" . $photo['farm'] .".static.flickr.com/" . $photo['server'] ."/" . $photo['id'] ."_" . $photo['secret'] ."_b.jpg");

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