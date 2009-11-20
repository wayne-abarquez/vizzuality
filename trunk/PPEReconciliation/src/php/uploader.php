<?php

$file_temp = $_FILES['file']['tmp_name'];
$file_name = $_FILES['file']['name'];

$file_path = $_SERVER['DOCUMENT_ROOT']."/uploads";

//complete upload 
$filestatus = move_uploaded_file($file_temp,$file_path."/".$file_name);

if(!$filestatus) {
$success = "false";
array_push($errors,"Upload failed. Please try again.");
}

?>