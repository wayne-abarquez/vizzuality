<?php
include('simple_html_dom.php');

$cautonoma_fk=19;

$delay=10000;

$conn = pg_connect ("host=67.23.44.117 dbname=runnit user=runnit password=runnitrunnit555");

define("MAPS_HOST", "maps.google.com");
define("KEY", "abcdefg");
// Initialize delay in geocode speed
$delay = 0;
$base_url = "http://" . MAPS_HOST . "/maps/geo?output=xml" . "&key=" . KEY;

$url="http://www.carreraspopulares.com.es/v5-calendario/V5CC_menu_left.asp?fr_id_deporte=1&fr_id_pais=10&fr_id_comunidad=$cautonoma_fk";
	$html = file_get_dom($url);

//$carreras=array();
$ca=array();
	
	foreach($html->find('tr') as $tr) {
	    foreach($tr->find('td') as $td) {
			if($td->class=="td_KK_6p" or $td->class=="td_KK_new_6p") {
				$tmfecha = trim($td->plaintext);
				$tmp=explode("/",$tmfecha);
				$ca['fecha'] = "2009-".$tmp[1]."-".$tmp[0];
			}
			if($td->class=="td_KK_new" or $td->class=="td_KK") {
				$nombre_raw = trim($td->find('a',0)->plaintext);
				$ca['url'] = "http://www.carreraspopulares.com.es/v5-calendario/". $td->find('a',0)->href;
				$location = trim(str_replace($nombre_raw,"",$td->plaintext));
				$ca['nombre'] = mb_convert_encoding($nombre_raw, "UTF-8", "Windows-1252");				
				$tmp2=explode("(",$location);
				$ca['localidad'] = trim($tmp2[0]);
				$ca['localidad'] = iconv("ISO-8859-1","UTF-8//TRANSLIT",$ca['localidad']);				
				$ca['provincia'] = trim(str_replace(")","",$tmp2[1]));
				$ca['provincia'] = mb_convert_encoding($ca['provincia'], "UTF-8", "Windows-1252");				



///-----------------------------------------------
				
				$request_url = $base_url . "&q=" . urlencode($ca['localidad'].",".$ca['provincia'].",spain");
				$xml = simplexml_load_file($request_url);
				$status = $xml->Response->Status->code;
				if (strcmp($status, "200") == 0) {
					$geocode_pending = false;
					$coordinates = $xml->Response->Placemark->Point->coordinates;
					$coordinatesSplit = split(",", $coordinates);
					$ca['lat'] = $coordinatesSplit[1];
					$ca['lon'] = $coordinatesSplit[0];
					
			    } else if (strcmp($status, "620") == 0) {
			      // sent geocodes too fast
			      $delay += 100000;	
				} else {
			      // failure to geocode
			      $geocode_pending = false;
			      //echo "Address " . $request_url . " failed to geocoded. ";
			      //echo "Received status " . $status . ".\n";
			    }		
				usleep($delay);

///-----------------------------------------------

		//echo($ca['url']);
		$html2 = file_get_dom($ca['url']);
		foreach($html2->find('td[height=250]') as $e)
			$ca['description_not_parsed'] = mb_convert_encoding($e->plaintext, "UTF-8", "Windows-1252");
			
		
		$pos=strpos($ca['description_not_parsed'],"a las ");
		if($pos>0) {
			$ca['fecha'] = $ca['fecha']." ". trim(substr($ca['description_not_parsed'],$pos+6,5));
		} else {
			$pos=strpos($ca['description_not_parsed'],"a partir de las ");
			if($pos>0) {
				$ca['fecha'] = $ca['fecha']." ". trim(substr($ca['description_not_parsed'],$pos +16,5));			
			}			
		}




				$sql="SELECT id from run where name='".pg_escape_string($ca['nombre'])."'";
		        $result = pg_query($conn, $sql);
		        if(pg_num_rows($result)<1) {
					pg_query($conn, createsql($ca));				
				}			
				$ca=array();
			}
		}		
	}



function createsql($ca) {
	global $cautonoma_fk;
	$url=pg_escape_string($ca['url']);
	$nombre=pg_escape_string($ca['nombre']);
	$localidad=pg_escape_string($ca['localidad']);
	$description_not_parsed=pg_escape_string($ca['description_not_parsed']);

	$sql="insert into run(name,event_location,event_date,descripcion_no_parseada,imported_from,start_point,cautonoma_fk) VALUES (";

	if($nombre) {
		$sql.="'$nombre'";
	} else {
		$sql.="null";
	}
	if($localidad) {
		$sql.=",'$localidad'";
	} else {
		$sql.=",null";
	}
	if($ca['fecha']) {
		$sql.=",'".$ca['fecha']."'";
	} else {
		$sql.=",null";
	}
	if($description_not_parsed) {
		$sql.=",'$description_not_parsed'";
	} else {
		$sql.=",null";
	}
	if($ca['url']) {
		$sql.=",'".$ca['url']."'";
	} else {
		$sql.=",null";
	}
	if(isset($ca['lat']) and $ca['lat']!='' and $ca['lat']!=0) {
		$sql.=",GeomFromText('POINT(".$ca['lon']." ".$ca['lat'].")',4326)";
	} else {
		$sql.=",null";
	}
	$sql.=",$cautonoma_fk)";

	return $sql;
}

//print_r($carreras);	
?>