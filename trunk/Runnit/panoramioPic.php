<?php
include($_SERVER['DOCUMENT_ROOT'] ."/runnit-config.php");
require "libs/imageTransforms.php";
require_once("libs/phpFlickr.php");
$basePath = ABSPATH;
$targetPicture=$basePath."media/run/".$_REQUEST['id'].".jpg";
$defaultPicture=$basePath."media/run/generic/1_big.jpg";


$id=$_REQUEST['id'];

if (file_exists($targetPicture)) {
    header("Content-Type: image/jpeg");
    header('Content-Length: '.filesize($targetPicture));
    print file_get_contents($targetPicture);
    die();
}
if(isset($_REQUEST['photo_id'])) {
    $photo_id=$_REQUEST['photo_id'];
} else {
    $photo_id="8e4f99b9bb3c602984421a253d71f322";
}
$f = new phpFlickr($photo_id);
$photo = $f->photos_getInfo($photo_id);



if($photo) {
    $pic = file_get_contents("http://farm" . $photo['farm'] .".static.flickr.com/" . $photo['server'] ."/" . $photo['id'] ."_" . $photo['secret'] ."_b.jpg");

    file_put_contents($targetPicture, $pic);

    $imageTransform->crop($targetPicture, 618, 238, $targetPicture);
    header("Content-Type: image/jpeg");
    header('Content-Length: '.filesize($targetPicture));

	$string = "por ". $photo['owner']['username'];                                              
	$font  = 3;
	$width  = ImageFontWidth($font)* strlen($string) ;
	$height = ImageFontHeight($font) ;
	$im = ImageCreateFromjpeg($targetPicture); 
	$x=imagesx($im)-$width ;
	$y=imagesy($im)-$height;
	$background_color = imagecolorallocate ($im, 255, 255, 255); //white background
	$text_color = imagecolorallocate ($im, 255, 255,255);//black text
	imagestring ($im, $font, $x, $y,  $string, $text_color);

	imagejpeg ($im,$targetPicture);

    print file_get_contents($targetPicture);    
} else {
    header("Content-Type: image/jpeg");
    header('Content-Length: '.filesize($defaultPicture));    
    print file_get_contents($defaultPicture);     
}



?>