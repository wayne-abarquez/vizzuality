<?php 

ini_set("memory_limit","2048M");

$gwcurl=$argv[1];
$minZoom=$argv[2];
$maxZoom=$argv[3];
$savepath=$argv[4];


//LOOP OVER THE ZOOM LEVELS TO PROCESS (example 0-6)
for ($zoom = $minZoom; $zoom <= $maxZoom; $zoom++) {		
		
		$tilesAtThisZoom= pow(4,$zoom);
		$tilesInSide = sqrt($tilesAtThisZoom);
		
        //LOOP OVER ALL TILES WITHIN A ZOOM LEVEL (in zoom 1: 4)
		for($curX=0;$curX<$tilesInSide;$curX++) {
			for($curY=0;$curY<$tilesInSide;$curY++) {
			    $replace=array("|Z|","|X|","|Y|");
			    $replace_to=array($zoom,$curX,$curY);
			    $url = str_replace($replace,$replace_to,$gwcurl);
			    $data=file_get_contents($url);
			    if(strlen($data)<10) {
                	continue;
                }
			    $savefile=$zoom."_".$curX."_".$curY.".png";
			    file_put_contents($savepath.$savefile, $data);
			}			
		}
	
}





?>