<?php
require_once($_SERVER['DOCUMENT_ROOT'] ."/runnit-config.php");
require_once($_SERVER['DOCUMENT_ROOT'] ."/libs/class.phpmailer.php");
require_once($_SERVER['DOCUMENT_ROOT'] ."/libs/class.smtp.php");
require_once($_SERVER['DOCUMENT_ROOT'] ."/libs/Smarty.class.php");
require_once($_SERVER['DOCUMENT_ROOT'] ."/libs/class.imagetransform.php");

session_start();

class MediaServices {
	
	function __construct() {
	    $this->conn = pg_connect ("host=".DB_HOST." dbname=".DB_NAME." user=".DB_USER." password=".DB_PASSWORD);
	
		$this->emailPassword=EMAILPASSWORD;
		$this->basePath=ABSPATH;
	}
	
	function uploadPicture($tempPath,$onTable,$onId) {
	    if (!$_SESSION['logged']) {
	        throw new Exception("user not logged in");
	    }
	    
	    if(!file_exists($tempPath)) {
	        throw new Exception("image sent does not exist on server?");
	    }
	    
	    //generate the DB record
	    $sql= "INSERT INTO picture(user_fk,on_table,on_id) VALUES (".$_SESSION['user']['id'].",'$onTable',$onId)";
		$result=pg_query($this->conn, $sql);       
	    //get last ID
	    $sql = "SELECT currval('picture_id_seq') AS last_value";
	    $res=pg_fetch_assoc(pg_query($this->conn, $sql));
	    $picId = $res['last_value'];
	    
	    
	    $imgTrans = new imageTransform();
	    $imgTrans->sourceFile = $tempPath;
	    $imgTrans->targetFile = ABSPATH .'media/'.$onTable.'/' . $onId .'/'. $picId."_t.jpg";
		$imgTrans->resizeToWidth = 100;
		$imgTrans->resizeToHeight = 75;
		$imgTrans->maintainAspectRatio = false;
	    
	    if (!$imgTrans->resize()) {
			$result=pg_query($this->conn, "DELETE FROM picture WHERE id=$picId");
	        throw new Exception("Error processing the thumbnail");
	    }
	    
	    $bigFilePath=ABSPATH .'media/'.$onTable.'/' . $onId .'/'. $picId."_b.jpg";
	    $imgTrans = new imageTransform();
	    $imgTrans->sourceFile = $tempPath;
	    $imgTrans->targetFile = $bigFilePath;
	    $imgTrans->resizeIfSmaller=false;
		$imgTrans->resizeToWidth = 1024;
		$imgTrans->maintainAspectRatio = true;        
	    if (!$imgTrans->resize()) {
			$result=pg_query($this->conn, "DELETE FROM picture WHERE id=$picId");
	        throw new Exception("Error processing the thumbnail");
	    }
	    
	    $size = getimagesize($bigFilePath);
	    
	    //everything went fine. The update the db
	    $sql="UPDATE picture SET width=".$size[0].",height=".$size[1].",path='$bigFilePath' WHERE id=$picId";
	    $result=pg_query($this->conn, $sql);
	    
	}
	
	function uploadAvatar($tempPath) {
	    if (!$_SESSION['logged']) {
	        throw new Exception("user not logged in");
	    }
	    
	    if(!file_exists($tempPath)) {
	        throw new Exception("image sent does not exist on server?");
	    }
	    
	    
	    $onTable="avatar";
	    $onId =$_SESSION['user']['id'];
	    //generate the DB record
	    $sql= "INSERT INTO picture(user_fk,on_table,on_id) VALUES ($onId,$onTable,$onId)";
		$result=pg_query($this->conn, $sql);       
	    //get last ID
	    $sql = "SELECT currval('picture_id_seq') AS last_value";
	    $res=pg_fetch_assoc(pg_query($this->conn, $sql));
	    $picId = $res['last_value'];
	    
	    
	    $imgTrans = new imageTransform();
	    $imgTrans->sourceFile = $tempPath;
	    $imgTrans->targetFile = ABSPATH .'media/'.$onTable.'/' . $onId .'/'. $picId."_t.jpg";
		$imgTrans->resizeToWidth = 96;
		$imgTrans->resizeToHeight = 67;
		$imgTrans->maintainAspectRatio = false;
	    
	    if (!$imgTrans->resize()) {
			$result=pg_query($this->conn, "DELETE FROM picture WHERE id=$picId");
	        throw new Exception("Error processing the thumbnail");
	    }
	    
	    $bigFilePath=ABSPATH .'media/'.$onTable.'/' . $onId .'/'. $picId."_b.jpg";
	    $imgTrans = new imageTransform();
	    $imgTrans->sourceFile = $tempPath;
	    $imgTrans->targetFile = $bigFilePath;
		$imgTrans->resizeToWidth = 1024;
		$imgTrans->resizeIfSmaller=false;
		$imgTrans->maintainAspectRatio = true;        
	    if (!$imgTrans->resize()) {
			$result=pg_query($this->conn, "DELETE FROM picture WHERE id=$picId");
	        throw new Exception("Error processing the thumbnail");
	    }
	    
	    $size = getimagesize($bigFilePath);
	    
	    //everything went fine. The update the db
	    $sql="UPDATE picture SET width=".$size[0].",height=".$size[1].",path='$bigFilePath' WHERE id=$picId";
	    $result=pg_query($this->conn, $sql);
	    
	}	
	
	
}
?>