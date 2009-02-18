<?php
require('GoogleMapUtility.php');

/*
$rect = GoogleMapUtility::getTileRect(
        $x = $_REQUEST['x'], // x
        $y = $_REQUEST['y'], // y
        $zoom = $_REQUEST['z'] // zoom 
);
*/



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


$link = mysql_connect('localhost:3307', 'root', 'root');
mysql_select_db('eol', $link) or die('Could not select database.');
$sql="SELECT x,y,num_occ from tile_".$_REQUEST['z']."_taxon where tile_orig_x=".$_REQUEST['x']." and tile_orig_y=".$_REQUEST['y']." and taxon_id=".$_REQUEST['taxon'];
error_log($sql);
$result = mysql_query($sql);

while ($row = mysql_fetch_array($result, MYSQL_ASSOC)) {
    
    $cell=GoogleMapUtility::getTileRect($row["x"],$row["y"],($_REQUEST['z']+4));
    error_log(print_r($cell,true));
    $pll = GoogleMapUtility::toZoomedPixelCoords($cell->y, $cell->x, $_REQUEST['z']);
    $pur = GoogleMapUtility::toZoomedPixelCoords($cell->y+$cell->height, $cell->x+$cell->width, $_REQUEST['z']);
    
    $pllx = $pll->x - (GoogleMapUtility::TILE_SIZE * $_REQUEST['x']);
    $plly = $pll->y - (GoogleMapUtility::TILE_SIZE * $_REQUEST['y']);    
    $purx = $pur->x - (GoogleMapUtility::TILE_SIZE * $_REQUEST['x']);
    $pury = $pur->y - (GoogleMapUtility::TILE_SIZE * $_REQUEST['y']);    
    
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


?>