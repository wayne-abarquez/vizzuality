<?php
require_once("../runnit-config.php");
include('simple_html_dom.php');

$provinceslist= array(
	'andalucia'=>1,
	'aragon'=>2,
	'asturias'=>3,
	'cantabria'=>4,
	'cmancha'=>5,
	'cleon'=>6,
	'cataluna'=>7,
	'madrid'=>9,
	'cvalencia'=>10,
	'extremadura'=>11,
	'galicia'=>12,
	'ibaleares'=>13,
	'icanarias'=>14,
	'larioja'=>15,
	'navarra'=>16,
	'pvasco'=>17,
	'murcia'=>19
	);

$delay=10000;

$conn = pg_connect ("host=".DB_HOST." dbname=".DB_NAME." user=".DB_USER." password=".DB_PASSWORD);

define("MAPS_HOST", "maps.google.com");
define("KEY", "abcdefg");
// Initialize delay in geocode speed
$delay = 0;
$base_url = "http://" . MAPS_HOST . "/maps/geo?output=xml" . "&key=" . KEY;


foreach ($provinceslist as $key => $value) {
	$cautonoma_fk=$value;
	$cautonoma_name=$key;	




	$url="http://www.runners.es/Calendario/default.jsp?comunidad=".$cautonoma_name;
		$html = file_get_dom($url);

	//$carreras=array();
	$ca=array();

		foreach($html->find('span.Noticias') as $td) {
			//echo(utf8_encode($td->find('a',0)->href));
			$ca['nombre']=utf8_encode($td->find('a',0)->plaintext);
			$ca['url']=utf8_encode($td->find('a',0)->href);
			$ca['email']=utf8_encode(trim($td->find('a',1)->plaintext));
			//echo(trim(substr($td->plaintext,0,10))."\n");
			$tmp=explode("/",trim(substr($td->plaintext,0,10)));
			$ca['fecha'] = "2010-".$tmp[1]."-".$tmp[0];
			$ca['url'] = "http://www.runners.es/Calendario/". $ca['url'];
			$ca['description_not_parsed']=utf8_encode($td->plaintext);

			$localidad=utf8_encode(trim(str_replace(substr($td->plaintext,0,10),"",$td->plaintext)));
			$localidad=trim(str_replace($ca['nombre'],"",$localidad));
			$localidad=trim(str_replace($ca['email'],"",$localidad));
			$localidad=trim(str_replace("&nbsp;","",$localidad));

			$lala=explode("\n",$localidad);
			@$ca['localidad'] = trim($lala[0]);
			@$ca['provincia'] = str_replace(")","",str_replace("(","",trim($lala[1])));
			@$ca['tlf'] = trim($lala[2]);

			//$ca['data'] = array();

			$sql="SELECT id from run where imported_from='".$ca['url']."'";
	        $result = pg_query($conn, $sql);		
			if(pg_num_rows($result)>0) {
				echo("ALREADY IMPORTED: ".$ca['nombre'] ."\n");
			} else {
				//echo($ca['url']);
				$html2 = file_get_dom($ca['url']);
				$data=array();
				foreach($html2->find('tr[bgcolor=#F3E674]') as $td2) {
					$key=trim(str_replace("&nbsp;","",utf8_encode($td2->find('td',0)->plaintext)));
					$value=trim(str_replace("&nbsp;","",utf8_encode($td2->find('td',2)->plaintext)));
					$data[$key]=$value;
					//echo($td2->find('td',0)->plaintext ."    :    ". $td2->find('td',2)->plaintext);
				}
				@$ca['localidad']=$data['Localidad'];
				@$ca['provincia']=$data['Provincia'];
				$tmp=explode("/",$data['Fecha']);
				$ca['fecha'] = "2010-".$tmp[1]."-".$tmp[0];	
				if($data['Hora salida']!="") {
					$ca['fecha'].=" ".$data['Hora salida'];	
				}
				$t=(strlen(str_replace("\n","",str_replace(" ","",str_replace("\t","",$data['Lugar y de salida y meta'])))));
				if($t>20) {
					$ca['salida_llegada_text']=$data['Lugar y de salida y meta'];
				}		
				@$ca['distance_text']=$data['Distancia'];
				@$ca['category']=$data['Categorías'];
				@$ca['tlf_informacion']=$data['Teléfono'];
				@$ca['inscription_website']=$data['Web'];
				@$ca['description']=$data['Otros datos'];
				@$ca['inscription_email']=$data['Email'];
				@$ca['awards']=$data['Premios'];

				//buscar la provincia
				$sql="SELECT id from province where lower(name)=lower('".pg_escape_string($ca['provincia'])."')";
				//echo($sql);
		        $result = pg_query($conn, $sql);		
				if(pg_num_rows($result)>0) {
					$res=pg_fetch_assoc($result);			
					$ca['province_id']=$res['id'];
				} else {
					$ca['province_id']="";
				}

				$request_url = $base_url . "&q=" . urlencode($ca['localidad'].",".$ca['provincia'].",spain");
				$request_response = utf8_encode(file_get_contents($request_url));
        	    if(!$xml = simplexml_load_string($request_response)) {
        	        $geocode_pending = false;
        	    } else {
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
        	    }				
				//echo(createsql($ca)."\n");

				$sql="SELECT id from run where name='".pg_escape_string($ca['nombre'])."'";
		        $result = pg_query($conn, $sql);
		        if(pg_num_rows($result)<1) {
					//echo("hey!");
					echo("IMPORT: ".$ca['nombre'] ."\n");
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
	
	$distance_text=pg_escape_string($ca['distance_text']);
	$category=pg_escape_string($ca['category']);
	$tlf_informacion=pg_escape_string($ca['tlf_informacion']);
	$inscription_website=pg_escape_string($ca['inscription_website']);
	$description=pg_escape_string($ca['description']);
	$inscription_email=pg_escape_string($ca['inscription_email']);
	$awards=pg_escape_string($ca['awards']);
	$province_id=$ca['province_id'];

	$sql="insert into run(name,event_location,event_date,descripcion_no_parseada,imported_from,start_point,cautonoma_fk,distance_text,category,tlf_informacion,inscription_website,description,inscription_email,awards,province_fk) VALUES (";
	

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
	$sql.=",$cautonoma_fk";
	
	if($distance_text) {
		$sql.=",'$distance_text'";
	} else {
		$sql.=",null";
	}
	if($category) {
		$sql.=",'$category'";
	} else {
		$sql.=",null";
	}
	if($tlf_informacion) {
		$sql.=",'$tlf_informacion'";
	} else {
		$sql.=",null";
	}
	if($inscription_website) {
		$sql.=",'$inscription_website'";
	} else {
		$sql.=",null";
	}			
	if($description) {
		$sql.=",'$description'";
	} else {
		$sql.=",null";
	}			
	if($inscription_email) {
		$sql.=",'$inscription_email'";
	} else {
		$sql.=",null";
	}	
	if($awards) {
		$sql.=",'$awards'";
	} else {
		$sql.=",null";
	}
	if($province_id!="") {
		$sql.=",$province_id)";
	} else {
		$sql.=",null)";
	}
	
	//province_fk	

	return $sql;
}

//print_r($carreras);	
?>