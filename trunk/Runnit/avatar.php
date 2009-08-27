<?php
require 'services/RunnitServices.php';
$services = new RunnitServices;
$targetPicture=$services->basePath."media/avatar/".$_REQUEST['id'].".jpg";
if (!file_exists($targetPicture)) {
    $targetPicture =$services->basePath."media/avatar/0.jpg";
}
header("Content-Type: image/jpeg");
header('Content-Length: '.filesize($targetPicture));
print file_get_contents($targetPicture);

?>