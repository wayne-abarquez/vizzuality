<?php

$pieces = explode("_", $_REQUEST['tile']);

$x=$pieces[0];
$y=$pieces[1];
$z=$pieces[2];
$taxon=$pieces[3];

//$savefile = $_REQUEST['x'] . "_" . $_REQUEST['y'] . "_". $_REQUEST['z'] . "_". $_REQUEST['taxon'] . ".png";

//$fcon = file_get_contents("http://gbiftilecache.appspot.com/checkTile?tileID=".$savefile);

//if($fcon == "false") {

//if (file_exists("cache/".$savefile)) {
//	ob_clean();
//   flush();
//	header('Content-type: image/png');
//	readfile("cache/".$savefile);
//	exit();
//}


require('GoogleMapUtility.php');
require('../config.php');

ob_start(); // capture the output


$im = imagecreate(GoogleMapUtility::TILE_SIZE, GoogleMapUtility::TILE_SIZE);


//#1FE106, #3AC606, #55AB06, #719006, #8C7506, #A75A06, #C33F06, #DF2405, #FD0605
$colors=array();

$color = 'FABA00';
$colors[] = imagecolorallocate($im, hexdec('0x' . $color{0} . $color{1}), hexdec('0x' . $color{2} . $color{3}), hexdec('0x' . $color{4} . $color{5}));

$color = 'FAB000';
$colors[] = imagecolorallocate($im, hexdec('0x' . $color{0} . $color{1}), hexdec('0x' . $color{2} . $color{3}), hexdec('0x' . $color{4} . $color{5}));

$color = 'FD8D00';
$colors[] = imagecolorallocate($im, hexdec('0x' . $color{0} . $color{1}), hexdec('0x' . $color{2} . $color{3}), hexdec('0x' . $color{4} . $color{5}));

$color = 'F97A00';
$colors[] = imagecolorallocate($im, hexdec('0x' . $color{0} . $color{1}), hexdec('0x' . $color{2} . $color{3}), hexdec('0x' . $color{4} . $color{5}));

$color = 'FC5D0E';
$colors[] = imagecolorallocate($im, hexdec('0x' . $color{0} . $color{1}), hexdec('0x' . $color{2} . $color{3}), hexdec('0x' . $color{4} . $color{5}));

$color = 'FD3F16';
$colors[] = imagecolorallocate($im, hexdec('0x' . $color{0} . $color{1}), hexdec('0x' . $color{2} . $color{3}), hexdec('0x' . $color{4} . $color{5}));

$color = 'FC3117';
$colors[] = imagecolorallocate($im, hexdec('0x' . $color{0} . $color{1}), hexdec('0x' . $color{2} . $color{3}), hexdec('0x' . $color{4} . $color{5}));

$color = 'FE211D';
$colors[] = imagecolorallocate($im, hexdec('0x' . $color{0} . $color{1}), hexdec('0x' . $color{2} . $color{3}), hexdec('0x' . $color{4} . $color{5}));

$color = 'FE091F';
$colors[] = imagecolorallocate($im, hexdec('0x' . $color{0} . $color{1}), hexdec('0x' . $color{2} . $color{3}), hexdec('0x' . $color{4} . $color{5}));

$blank = imagecolorallocate( $im, 0, 0, 0 );


imagefilledrectangle( $im, 0, 0, GoogleMapUtility::TILE_SIZE, GoogleMapUtility::TILE_SIZE, $blank );



mysql_select_db('eol', $link) or die('Could not select database.');
$sql="SELECT x,y,num_occ from tile_".$z."_taxon where tile_orig_x=".$x." and tile_orig_y=".$y." and taxon_id=".$taxon;
//error_log($sql);
$result = mysql_query($sql);

while ($row = mysql_fetch_array($result, MYSQL_ASSOC)) {
    
    $cell=GoogleMapUtility::getTileRect($row["x"],$row["y"],($z+6));
    //error_log(print_r($cell,true));
    $pll = GoogleMapUtility::toZoomedPixelCoords($cell->y, $cell->x, $z);
    $pur = GoogleMapUtility::toZoomedPixelCoords($cell->y+$cell->height, $cell->x+$cell->width, $z);
    
    $pllx = $pll->x - (GoogleMapUtility::TILE_SIZE * $x);
    $plly = $pll->y - (GoogleMapUtility::TILE_SIZE * $y);    
    $purx = $pur->x - (GoogleMapUtility::TILE_SIZE * $x);
    $pury = $pur->y - (GoogleMapUtility::TILE_SIZE * $y);    
    
    $color=$colors[0];
    if ($row["num_occ"]>10) {
        $color=$colors[1];
    }  if ($row["num_occ"]>20) {
        $color=$colors[2];
    }  if ($row["num_occ"]>50) {
        $color=$colors[3];
    }  if ($row["num_occ"]>100) {
        $color=$colors[4];
    }  if ($row["num_occ"]>1000) {
        $color=$colors[5];
    }  if ($row["num_occ"]>3000) {
        $color=$colors[6];
    }  if ($row["num_occ"]>8000) {
        $color=$colors[7];
    }  if ($row["num_occ"]>15000) {
        $color=$colors[8];
    }                                                     
    
    imagefilledrectangle( $im, $pllx, $plly, $purx, $pury, $color );    

}
mysql_free_result($result);


imagecolortransparent($im, $blank);
imagepng($im);
imagedestroy($im);


header('Content-type: image/png');

$imagedata = ob_get_flush();


//if (!is_dir("cache/$set")) mkdir("cache/$set");
//file_put_contents("cache/$savefile", $imagedata);

?>