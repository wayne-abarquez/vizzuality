<?php
require_once($_SERVER['DOCUMENT_ROOT'] ."/runnit-config.php");

$targetPicture=ABSPATH."media/avatar/".$_REQUEST['id']."/". $_REQUEST['id'] ."_s.jpg";
if (!file_exists($targetPicture)) {
    $targetPicture =ABSPATH."media/avatar/0.jpg";
}
header("Content-Type: image/jpeg");
header('Content-Length: '.filesize($targetPicture));
print file_get_contents($targetPicture);

?>