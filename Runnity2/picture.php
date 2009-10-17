<?php
require_once($_SERVER['DOCUMENT_ROOT'] ."/runnit-config.php");

$targetPicture=ABSPATH."media/run/".$_REQUEST['onId']."/".$_REQUEST['picId']."_b.jpg";
if (!file_exists($targetPicture)) {
	$targetPicture=str_replace("_b.jpg","_t.jpg",$targetPicture)."\"/>");	
}
header("Content-Type: image/jpeg");
header('Content-Length: '.filesize($targetPicture));
print file_get_contents($targetPicture);

?>