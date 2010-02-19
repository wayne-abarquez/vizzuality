<?php
ini_set("memory_limit","1024M");


$gridsize=8640;

$gd = imagecreatetruecolor($gridsize, $gridsize/2);
$red = imagecolorallocate($gd, 255, 0, 0);


$color = 'FABA00';
$colors[] = imagecolorallocate($gd, hexdec('0x' . $color{0} . $color{1}), hexdec('0x' . $color{2} . $color{3}), hexdec('0x' . $color{4} . $color{5}));

$color = 'FAB000';
$colors[] = imagecolorallocate($gd, hexdec('0x' . $color{0} . $color{1}), hexdec('0x' . $color{2} . $color{3}), hexdec('0x' . $color{4} . $color{5}));

$color = 'FD8D00';
$colors[] = imagecolorallocate($gd, hexdec('0x' . $color{0} . $color{1}), hexdec('0x' . $color{2} . $color{3}), hexdec('0x' . $color{4} . $color{5}));

$color = 'F97A00';
$colors[] = imagecolorallocate($gd, hexdec('0x' . $color{0} . $color{1}), hexdec('0x' . $color{2} . $color{3}), hexdec('0x' . $color{4} . $color{5}));

$color = 'FC5D0E';
$colors[] = imagecolorallocate($gd, hexdec('0x' . $color{0} . $color{1}), hexdec('0x' . $color{2} . $color{3}), hexdec('0x' . $color{4} . $color{5}));

$color = 'FD3F16';
$colors[] = imagecolorallocate($gd, hexdec('0x' . $color{0} . $color{1}), hexdec('0x' . $color{2} . $color{3}), hexdec('0x' . $color{4} . $color{5}));

$color = 'FC3117';
$colors[] = imagecolorallocate($gd, hexdec('0x' . $color{0} . $color{1}), hexdec('0x' . $color{2} . $color{3}), hexdec('0x' . $color{4} . $color{5}));

$color = 'FE211D';
$colors[] = imagecolorallocate($gd, hexdec('0x' . $color{0} . $color{1}), hexdec('0x' . $color{2} . $color{3}), hexdec('0x' . $color{4} . $color{5}));

$color = 'FE091F';
$colors[] = imagecolorallocate($gd, hexdec('0x' . $color{0} . $color{1}), hexdec('0x' . $color{2} . $color{3}), hexdec('0x' . $color{4} . $color{5}));







$db = mysql_connect('localhost','root','root') or die("Database error");
mysql_select_db('gmba', $db);
//$sql = "select *,floor(cell_id/8640) as grid_y, (cell_id%8640) as grid_x from gmba";
//$sql = "select sum(count) as count,floor(cell_id/8640) as grid_y, (cell_id%8640) as grid_x from density_trimmed group by cell_id";
//$sql = "select grid_y,grid_x,count from temp_map";
//$sql="select elevation,relief,vegcode,floor(cell_id/8640) as grid_y, (cell_id%8640) as grid_x from gmba";
$sql = "select num_species as count,floor(cell_id/8640) as grid_y, mod_cell_id as grid_x from species_richnes";



$result = mysql_query($sql);
if (!$result) {
    echo "Could not successfully run query ($sql) from DB: " . mysql_error();
    exit;
}
if (mysql_num_rows($result) == 0) {
    echo "No rows found, nothing to print so am exiting";
    exit;
}

while ($row = mysql_fetch_assoc($result)) {
    
    $color=$colors[0];
    if ($row["count"]>10) {
        $color=$colors[1];
    }  if ($row["count"]>20) {
        $color=$colors[2];
    }  if ($row["count"]>50) {
        $color=$colors[3];
    }  if ($row["count"]>100) {
        $color=$colors[4];
    }  if ($row["count"]>1000) {
        $color=$colors[5];
    }  if ($row["count"]>3000) {
        $color=$colors[6];
    }  if ($row["count"]>4000) {
        $color=$colors[7];
    }  if ($row["count"]>7000) {
        $color=$colors[8];
    } 
    

    
    //$composedColor = imagecolorallocate($gd, getAltitudeColor($row["elevation"]), getReliefColor($row["relief"]), getVegcodeColor($row["vegcode"]));
    imagesetpixel($gd, $row["grid_x"],$row["grid_y"], $color);
    
    
    
    
    
}

$gdrotated = image_flip(rotateImage($gd, 180),"horiz");

imagepng($gdrotated,"/mnt/ppe.tileprocessing/gbifrichness.png");



function getAltitudeColor($val) {
    return (int) floor(($val*255)/7889);
}

function getReliefColor($val) {
    return (int) floor(($val*255)/3397);
}

function getVegcodeColor($val) {
    return (int) $val;
}





function rotateImage($img, $rotation) {
  $width = imagesx($img);
  $height = imagesy($img);
  switch($rotation) {
    case 90: $newimg= @imagecreatetruecolor($height , $width );break;
    case 180: $newimg= @imagecreatetruecolor($width , $height );break;
    case 270: $newimg= @imagecreatetruecolor($height , $width );break;
    case 0: return $img;break;
    case 360: return $img;break;
  }
  if($newimg) { 
    for($i = 0;$i < $width ; $i++) { 
      for($j = 0;$j < $height ; $j++) {
        $reference = imagecolorat($img,$i,$j);
        switch($rotation) {
          case 90: if(!@imagesetpixel($newimg, ($height - 1) - $j, $i, $reference )){return false;}break;
          case 180: if(!@imagesetpixel($newimg, $width - $i, ($height - 1) - $j, $reference )){return false;}break;
          case 270: if(!@imagesetpixel($newimg, $j, $width - $i, $reference )){return false;}break;
        }
      } 
    } return $newimg; 
  } 
  return false;
}


function image_flip($img, $type=''){
    $width  = imagesx($img);
    $height = imagesy($img);
    $dest   = imagecreatetruecolor($width, $height);
    switch($type){
        case '':
            return $img;
        break;
        case 'vert':
            for($i=0;$i<$height;$i++){
                imagecopy($dest, $img, 0, ($height - $i - 1), 0, $i, $width, 1);
            }
        break;
        case 'horiz':
            for($i=0;$i<$width;$i++){
                imagecopy($dest, $img, ($width - $i - 1), 0, $i, 0, 1, $height);
            }
        break;
        case 'both':
            for($i=0;$i<$width;$i++){
                imagecopy($dest, $img, ($width - $i - 1), 0, $i, 0, 1, $height);
            
            }
            $buffer = imagecreatetruecolor($width, 1);
            for($i=0;$i<($height/2);$i++){
                imagecopy($buffer, $dest, 0, 0, 0, ($height - $i -1), $width, 1);
                imagecopy($dest, $dest, 0, ($height - $i - 1), 0, $i, $width, 1);
                imagecopy($dest, $buffer, 0, $i, 0, 0, $width, 1);
            }
            imagedestroy($buffer);
        break;
    }
    return $dest;
}


?>