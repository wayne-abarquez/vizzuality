<?php
require_once($_SERVER['DOCUMENT_ROOT'] ."/runnit-config.php");

$targetPicture=ABSPATH."media/avatar/".$_REQUEST['onId']."/".$_REQUEST['picId']."_".$_REQUEST['type'].".jpg";
if (!file_exists($targetPicture)) {
	str_replace("_b.jpg","_t.jpg",$targetPicture));	
}
header("Content-Type: image/jpeg");
header('Content-Length: '.filesize($targetPicture));
print file_get_contents($targetPicture);

?>