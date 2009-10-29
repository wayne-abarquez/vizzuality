<?php
require_once($_SERVER['DOCUMENT_ROOT'] ."/runnit-config.php");
require_once($_SERVER['DOCUMENT_ROOT'] ."/libs/class.phpmailer.php");
require_once($_SERVER['DOCUMENT_ROOT'] ."/libs/class.smtp.php");
require_once($_SERVER['DOCUMENT_ROOT'] ."/libs/Smarty.class.php");
require_once($_SERVER['DOCUMENT_ROOT'] ."/libs/class.imagetransform.php");

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
	    
	    $res = @mkdir(ABSPATH .'media/'.$onTable.'/' . $onId, 0755);
	    
	    
	    $imgSize=getimagesize($tempPath);
	    
	    
	    //RESIZE
	    $imgTrans = new imageTransform();
	    $imgTrans->sourceFile = $tempPath;
	    $imgTrans->targetFile = ABSPATH .'media/'.$onTable.'/' . $onId .'/'. $picId."_t.jpg";	    
	    
	    
	    
	    //mas ancha que alta
	    if($imgSize[0]>$imgSize[1]) {
	    	$imgTrans->resizeToHeight = 67;
	    		    	
	    }
	    //mas alta que ancha
	    if($imgSize[0]<$imgSize[1]) {
	    	$imgTrans->resizeToWidth = 66;
	    }	  
	    
	    //==
	    if($imgSize[0]==$imgSize[1]) {
	    	$imgTrans->resizeToWidth = 66;
	    	$imgTrans->resizeToHeight = 67;
	    }	
	    if (!$imgTrans->resize()) {
			$result=pg_query($this->conn, "DELETE FROM picture WHERE id=$picId");
	        throw new Exception("Error processing the thumbnail");
	    }	    
	    
	    //CROP
	    $imgTrans2 = new imageTransform();
	    $imgTrans2->sourceFile = ABSPATH .'media/'.$onTable.'/' . $onId .'/'. $picId."_t.jpg";	  
	    $imgTrans2->targetFile = ABSPATH .'media/'.$onTable.'/' . $onId .'/'. $picId."_t.jpg";	    
	    $res=true;
	    $imgSize2=getimagesize(ABSPATH .'media/'.$onTable.'/' . $onId .'/'. $picId."_t.jpg");
	    
	    //mas ancha que alta
	    if($imgSize[0]>$imgSize[1]) {	    		    	
	    	$t= floor(($imgSize2[0] - 66)/2);
	    	$res = $imgTrans2->crop($t,0,(66+$t),67);
	    		    	
	    }
	    //mas alta que ancha
	    if($imgSize[0]<$imgSize[1]) {   	
	    	$t= floor(($imgSize2[1] - 67)/2);
	    	$res = $imgTrans2->crop(0,$t,66,(67+$t));
	    }	  
	   		
	    if (!$res) {
			$result=pg_query($this->conn, "DELETE FROM picture WHERE id=$picId");
	        throw new Exception("Error processing the thumbnail");
	    }
	   	    
	    
	    $bigFilePath=ABSPATH .'media/'.$onTable.'/' . $onId .'/'. $picId."_b.jpg";
	    $bigFileUrlPath='/media/'.$onTable.'/' . $onId .'/'. $picId."_b.jpg";
	    $imgTrans = new imageTransform();
	    $imgTrans->sourceFile = $tempPath;
	    $imgTrans->targetFile = $bigFilePath;
	    $imgTrans->resizeIfSmaller=false;
		$imgTrans->resizeToWidth = 599;
		$imgTrans->maintainAspectRatio = true;        
	    if (!$imgTrans->resize()) {
			$result=pg_query($this->conn, "DELETE FROM picture WHERE id=$picId");
	        throw new Exception("Error processing the thumbnail");
	    }
	    
	    $size = getimagesize($bigFilePath);
	    
	    //everything went fine. The update the db
	    $sql="UPDATE picture SET width=".$size[0].",height=".$size[1].",path='$bigFileUrlPath' WHERE id=$picId";
	    $result=pg_query($this->conn, $sql);
	
		$data=array();
		$data['width']=$size[0];
		$data['height']=$size[1];
		$data['path']=$bigFileUrlPath;	
		
		$activity_description="Nuevas fotos";

        if($onTable=="run") {
            $sql="UPDATE activity SET run3_fk = run2_fk, run3_description=run2_description,run2_fk = run1_fk, run2_description=run1_description, run1_fk=$onId, run1_description='".$activity_description."'";
            $result= pg_query($this->conn, $sql);            
        }
	
	    return $data;
	    
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
	    
	    $sql="SELECT id from picture WHERE on_table='avatar' AND user_fk=$onId";
	    $res=pg_fetch_assoc(pg_query($this->conn, $sql));
	    if($res) {
	        $picId = $res['id'];
	    } else {
    	    $sql= "INSERT INTO picture(user_fk,on_table,on_id) VALUES ($onId,'$onTable',$onId)";
    		$result=pg_query($this->conn, $sql);       
    	    //get last ID
    	    $sql = "SELECT currval('picture_id_seq') AS last_value";
    	    $res=pg_fetch_assoc(pg_query($this->conn, $sql));
    	    $picId = $res['last_value'];	        
	    }	
	    
	   	$res = @mkdir(ABSPATH .'media/'.$onTable.'/' . $onId, 0755);

	    
	   	$imgSize=getimagesize($tempPath);
	    
	    
	    //RESIZE para avatar pequeño
	    $imgTrans = new imageTransform();
	    $imgTrans->sourceFile = $tempPath;
	    $imgTrans->targetFile = ABSPATH .'media/'.$onTable.'/' . $onId .'/'. $onId."_s.jpg";	    
	    
	    
	    
	    //mas ancha que alta
	    if($imgSize[0]>$imgSize[1]) {
	    	$imgTrans->resizeToHeight = 67;
	    		    	
	    }
	    //mas alta que ancha
	    if($imgSize[0]<$imgSize[1]) {
	    	$imgTrans->resizeToWidth = 66;
	    }	  
	    
	    //==
	    if($imgSize[0]==$imgSize[1]) {
	    	$imgTrans->resizeToWidth = 66;
	    	$imgTrans->resizeToHeight = 67;
	    }	
	    if (!$imgTrans->resize()) {
			$result=pg_query($this->conn, "DELETE FROM picture WHERE id=$picId");
	        throw new Exception("Error processing the thumbnail");
	    }	    
	    
	    //CROP
	    $imgTrans2 = new imageTransform();
	    $imgTrans2->sourceFile = ABSPATH .'media/'.$onTable.'/' . $onId .'/'. $onId."_s.jpg";	  
	    $imgTrans2->targetFile = ABSPATH .'media/'.$onTable.'/' . $onId .'/'. $onId."_s.jpg";	    
	    $res=true;
	    $imgSize2=getimagesize(ABSPATH .'media/'.$onTable.'/' . $onId .'/'. $onId."_s.jpg");
	    
	    //mas ancha que alta
	    if($imgSize[0]>$imgSize[1]) {	    		    	
	    	$t= floor(($imgSize2[0] - 66)/2);
	    	$res = $imgTrans2->crop($t,0,(66+$t),67);
	    		    	
	    }
	    //mas alta que ancha
	    if($imgSize[0]<$imgSize[1]) {   	
	    	$t= floor(($imgSize2[1] - 67)/2);
	    	$res = $imgTrans2->crop(0,$t,66,(67+$t));
	    }	  
	   		
	    if (!$res) {
			$result=pg_query($this->conn, "DELETE FROM picture WHERE id=$picId");
	        throw new Exception("Error processing the thumbnail");
	    }
	            
	    $imgThumbPath='/media/'.$onTable.'/' . $onId .'/'. $onId."_s.jpg";

	    
/*
	    $imgTrans = new imageTransform();
	    $imgTrans->sourceFile = $tempPath;
        @$res = mkdir(ABSPATH .'media/'.$onTable.'/' . $onId, 0755);
        $imgThumb=ABSPATH .'media/'.$onTable.'/' . $onId .'/'. $onId."_t.jpg";
        $imgThumbPath='/media/'.$onTable.'/' . $onId .'/'. $onId."_t.jpg";
	    $imgTrans->targetFile = $imgThumb;
		$imgTrans->resizeToWidth = 194;
		$imgTrans->resizeToHeight = 194;
		$imgTrans->maintainAspectRatio = false;
	    
	    
	    $res=$imgTrans->resize(); 
	    if (!$res) {
			$result=pg_query($this->conn, "DELETE FROM picture WHERE id=$picId");
	        return false;
	    }
*/

		$imgSize=getimagesize($tempPath);
	    
	    
	    //RESIZE para avatar pequeño
	    $imgTrans = new imageTransform();
	    $imgTrans->sourceFile = $tempPath;
	    $imgTrans->targetFile = ABSPATH .'media/'.$onTable.'/' . $onId .'/'. $onId."_t.jpg";	    
	    
	    
	    
	    //mas ancha que alta
	    if($imgSize[0]>$imgSize[1]) {
	    	$imgTrans->resizeToHeight = 194;
	    		    	
	    }
	    //mas alta que ancha
	    if($imgSize[0]<$imgSize[1]) {
	    	$imgTrans->resizeToWidth = 194;
	    }	  
	    
	    //==
	    if($imgSize[0]==$imgSize[1]) {
	    	$imgTrans->resizeToWidth = 194;
	    	$imgTrans->resizeToHeight = 194;
	    }	
	    if (!$imgTrans->resize()) {
			$result=pg_query($this->conn, "DELETE FROM picture WHERE id=$picId");
	        throw new Exception("Error processing the thumbnail");
	    }	    
	    
	    //CROP
	    $imgTrans2 = new imageTransform();
	    $imgTrans2->sourceFile = ABSPATH .'media/'.$onTable.'/' . $onId .'/'. $onId."_t.jpg";	  
	    $imgTrans2->targetFile = ABSPATH .'media/'.$onTable.'/' . $onId .'/'. $onId."_t.jpg";	    
	    $res=true;
	    $imgSize2=getimagesize(ABSPATH .'media/'.$onTable.'/' . $onId .'/'. $onId."_t.jpg");
	    
	    //mas ancha que alta
	    if($imgSize[0]>$imgSize[1]) {	    		    	
	    	$t= floor(($imgSize2[0] - 194)/2);
	    	$res = $imgTrans2->crop($t,0,(194+$t),194);
	    		    	
	    }
	    //mas alta que ancha
	    if($imgSize[0]<$imgSize[1]) {   	
	    	$t= floor(($imgSize2[1] - 194)/2);
	    	$res = $imgTrans2->crop(0,$t,194,(194+$t));
	    }	  
	   		
	    if (!$res) {
			$result=pg_query($this->conn, "DELETE FROM picture WHERE id=$picId");
	        throw new Exception("Error processing the thumbnail");
	    }
	            
	    $imgThumbPath='/media/'.$onTable.'/' . $onId .'/'. $onId."_t.jpg";
	    
	    $bigFilePath=ABSPATH .'media/'.$onTable.'/' . $onId .'/'. $onId."_b.jpg";
	    
	    $imgTrans = new imageTransform();
	    $imgTrans->sourceFile = $tempPath;
	    $imgTrans->targetFile = $bigFilePath;
		$imgTrans->resizeToWidth = 650;
		$imgTrans->resizeIfSmaller=false;
		$imgTrans->maintainAspectRatio = true;        
	    if (!$imgTrans->resize()) {
			$result=pg_query($this->conn, "DELETE FROM picture WHERE id=$picId");
	        throw new Exception("Error processing the thumbnail");
	    }
	    
	    $size = getimagesize($bigFilePath);
	    
	    //everything went fine. The update the db
	    $sql="UPDATE picture SET width=".$size[0].",height=".$size[1].",path='$imgThumbPath' WHERE id=$picId";
	    $result=pg_query($this->conn, $sql);
	
	    return true;
	}	
	
	function getUserImgPath($userId) {
	    $sql = "SELECT path FROM picture WHERE on_id=$userId AND on_table='avatar'";
	    $res=pg_fetch_assoc(pg_query($this->conn, $sql));
	    if($res) {
	        return $res['path'];
	    } else {
	        return "/media/avatar/2.jpg";
	    }
	}
	
	function getObjectPictures($table,$id) {
	    $table=pg_escape_string($table);
	    $sql="SELECT p.id,path,width,height,on_id,u.username FROM picture as p inner join users as u on p.user_fk=u.id WHERE on_id=$id AND on_table='$table' ORDER BY p.created_when DESC";
	    return pg_fetch_all(pg_query($this->conn, $sql));
	}
	
	function getUserPictures($userId) {
	    $sql="SELECT p.id,path,width,height,on_id,u.username, u.id as user_id FROM picture as p inner join users as u on p.user_fk=u.id WHERE user_fk=$userId and on_table<>'avatar' ORDER BY p.created_when DESC";
	    return pg_fetch_all(pg_query($this->conn, $sql));
	}	
	
	function getPictureDetails($id) {
		$sql="
		   SELECT p.id,path,width,height,on_id as belongs_to_fk,on_table as belongs_to_table,u.username,u.id as user_fk, 
			CASE WHEN on_table='run' THEN
				(SELECT name from run as ru WHERE ru.id=on_id)
			ELSE '' END	as belongs_to_name
			FROM picture as p inner join users as u on p.user_fk=u.id WHERE p.id=$id";
						
		$res=pg_fetch_assoc(pg_query($this->conn, $sql));
		return $res;
		
	}
	
	function removePicture($id) {
	    $sql="DELETE FROM picture WHERE id=$id";
	    $result=pg_query($this->conn, $sql);
	}
	
}
?>