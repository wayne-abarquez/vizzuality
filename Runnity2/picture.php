<?php
require_once($_SERVER['DOCUMENT_ROOT'] ."/runnit-config.php");

$targetPicture=ABSPATH."media/run/".$_REQUEST['id']."/".$_REQUEST['picId']."_".$_REQUEST['type'].".jpg";

header("Content-Type: image/jpeg");
header('Content-Length: '.filesize($targetPicture));
print file_get_contents($targetPicture);

?>