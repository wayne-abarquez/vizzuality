<?php
/* Author: jatorre@vizzuality.com
 *
 * Copy pictures in the EOL Flickr group to Fusion Tables.
 *
 */

require_once("phpFlickr.php");
require_once("fusiontableslib.php");

define('GMAIL_USER', 'username');
define('GMAIL_PASS', 'pass');
define('FUSION_TABLE_TARGET', '225340');
$fusionTablesToken="";


//Flickr Service
$flickrService = new phpFlickr("xxx");
//Fusion Tables Service
$fusionTablesService = new FusionTable($fusionTablesToken); 

checkToken();


//privacy_filter=1&accuracy=13&safe_search=1&content_type=1&machine_tags=+taxonomy%3Abinomial%3D&group_id=806927%40N20&has_geo=1
$pics = $flickrService->photos_search(array(
	"privacy_filter"=>"1",
	"accuracy"=>"1",
	"safe_search"=>"1",
	"content_type"=>"1",
	"machine_tags"=>"taxonomy:binomial=",
	"group_id"=>"806927@N20",
	"has_geo"=>"1"				
	));

foreach ($pics['photo'] as $photo) {
	
	$picDetails = $flickrService->photos_getInfo($photo['id']);
	$scientificName="Not found";
	foreach($picDetails["tags"]["tag"] as $tag) {
		if(strpos($tag["raw"],"taxonomy:binomial")!==false) {
			$scientificName = str_replace("taxonomy:binomial=","",$tag["raw"]);
		}
	}
	
	$lat = $picDetails["location"]["latitude"];
	$lon = $picDetails["location"]["longitude"];
	
	if($scientificName!="Not found") {
		$sql="INSERT INTO ".FUSION_TABLE_TARGET." (scientificName,decimalLatitude,decimalLongitude) VALUES ('$scientificName',$lat,$lon)";
		$res= $fusionTablesService->query($sql);
		echo($res);
		die();
		echo($sql."<br><br>");
	    /*echo "<a href='http://www.flickr.com/photos/" . $photo['owner'] . "/" . $photo['id'] . "/'>";
	    echo $photo['title'];
	    echo "</a>"; */
	}
}



function checkToken($forceRecreate=false) {
	global $fusionTablesToken;
	
    if(file_exists( 'cache/token.txt' ) && !$forceRecreate) {
        $filename = "cache/token.txt";
        $fp = fopen($filename, "r");
        $res = fread($fp, filesize($filename));
        $fusionTablesToken = unserialize($res);
        return ;
    } else {
        $token = GoogleClientLogin(GMAIL_USER, GMAIL_PASS, "fusiontables");        
        $fp = fopen('cache/token.txt', 'w');
        fwrite($fp, serialize($token));
        fclose($fp);    
        $fusionTablesToken = $token;
    }
}


?>
