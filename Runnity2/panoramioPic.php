<?php
include($_SERVER['DOCUMENT_ROOT'] ."/runnit-config.php");
require "libs/imageTransforms.php";
require_once("libs/phpFlickr.php");
$basePath = ABSPATH;
$targetPicture=$basePath."media/run/".$_REQUEST['id']."_big.jpg";
$defaultPicture=$basePath."media/run/generic/1_big.jpg";


$id=$_REQUEST['id'];


if (file_exists($targetPicture)) {
    header("Content-Type: image/jpeg");
    header('Content-Length: '.filesize($targetPicture));
    header('Expires: Thu, 15 Apr 2015 20:00:00 GMT');  
    print file_get_contents($targetPicture);
    die();
}

if(isset($_REQUEST['photo_id'])) {
    $photo_id=$_REQUEST['photo_id'];
} else {
    $photo_id="3228648671";
}
$f = new phpFlickr("8e4f99b9bb3c602984421a253d71f322");
$photo = $f->photos_getInfo($photo_id);


if($photo) {
    $pic = file_get_contents("http://farm" . $photo['farm'] .".static.flickr.com/" . $photo['server'] ."/" . $photo['id'] ."_" . $photo['secret'] ."_b.jpg");

    file_put_contents($targetPicture, $pic);

    if(filesize($targetPicture)<4000) {
        header("Content-Type: image/jpeg");
        header('Content-Length: '.filesize($defaultPicture));    
        header('Expires: Thu, 15 Apr 2015 20:00:00 GMT');
        print file_get_contents($defaultPicture);
        unlink($targetPicture);
        die();        
    }

    $imageTransform->crop($targetPicture, 618, 238, $targetPicture);
    header("Content-Type: image/jpeg");
    header('Content-Length: '.filesize($targetPicture));
    header('Expires: Thu, 15 Apr 2015 20:00:00 GMT');

/*
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
*/	

    print file_get_contents($targetPicture);    
} else {
    header("Content-Type: image/jpeg");
    header('Content-Length: '.filesize($defaultPicture));    
    header('Expires: Thu, 15 Apr 2015 20:00:00 GMT');
    print file_get_contents($defaultPicture);     
}



?>