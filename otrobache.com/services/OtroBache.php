<?php
require_once("fusiontableslib.php");
require_once("Twitter.class.php");
require_once("config.php");

class OtroBache {
    function __construct() {        
        $this->table="136993";
        $this->api_key="ABQIAAAAtDJGVn6RztUmxjnX5hMzjRRw3KWZ-x9A2HylNheByWtToULKzxSlnf4JpCGuPalF_xWQj_zXFJuCfw";
        $this->checkToken();
    }
    
    
    public function getLocalityCoords($locality,$country) {
        if(file_exists( 'cache/localities.txt' )) {
            $filename = "cache/localities.txt";
            $fp = fopen($filename, "r");
            $res = fread($fp, filesize($filename));
            $res = unserialize($res);    
            if(isset($res[strtolower($locality)])) {
                return $res[strtolower($locality)];
            }
        } else {
            $res=array();
        }
        $geo = $this->georeferenceLocality($locality,$country);
        $res[strtolower($locality)] = $geo;          
        $fp = fopen('cache/localities.txt', 'w');
        fwrite($fp, serialize($res));
        fclose($fp);  
        return $geo;
        
    }
    
    public function checkToken($forceRecreate=false) {
        if(file_exists( 'cache/token.txt' ) && !$forceRecreate) {
            $filename = "cache/token.txt";
            $fp = fopen($filename, "r");
            $res = fread($fp, filesize($filename));
            $this->fusionTablesToken = unserialize($res);
            return ;
        } else {
            $token = GoogleClientLogin(GMAIL_USER, GMAIL_PASS, "fusiontables");        
            $fp = fopen('cache/token.txt', 'w');
            fwrite($fp, serialize($token));
            fclose($fp);    
            $this->fusionTablesToken = $token;
        }
    }
    

    
    public function georeferenceLocality($locality,$country) {
        $url = 'http://maps.google.com/maps/geo?q='.urlencode($locality . ','.$country).'&output=json&sensor=false&key=' . $this->api_key;
        // make the HTTP request
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_HEADER, 0);        
        ob_start();
        curl_exec ($ch);
        curl_close ($ch);
        $data = ob_get_contents();
        ob_end_clean();      
        $jsondata = json_decode($data,true);
        $res=array();
        $res['bbox'] = $jsondata['Placemark'][0]['ExtendedData']['LatLonBox'];
        $res['center'] = $jsondata['Placemark'][0]['Point']['coordinates'];
        $res['name'] = $jsondata['Placemark'][0]['AddressDetails']['Country']['AdministrativeArea']['SubAdministrativeArea']['Locality']['LocalityName'];
        return $res;
    }
    
    public function reportBacheByAddress($address) {
        $loc = $this->georeferenceLocality($address);
        return $this->reportBache($loc['center'][1],$loc['center'][0],"manual");
    }    
    
    
    //API
    public function reportBache($lat,$lon,$reportedBy) {
        $latf=round($lat,5);
        $lonf=round($lon,5);
                       
        // format this string with the appropriate latitude longitude
        $url = 'http://maps.google.com/maps/geo?q='.$latf.','.$lonf.'&output=json&sensor=true_or_false&key=' . $this->api_key;
        // make the HTTP request
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_HEADER, 0);        
        ob_start();
        curl_exec ($ch);
        curl_close ($ch);
        $data = ob_get_contents();
        ob_end_clean();

        // parse the json response
        $jsondata = json_decode($data,true);

        $address =  str_replace(",","|",$jsondata['Placemark'][0]['address']);
        
        $city=strtolower( $jsondata['Placemark'][0]['AddressDetails']['Country']['AdministrativeArea']['SubAdministrativeArea']['Locality']['LocalityName']);
        
        $zip= $jsondata['Placemark'][0]['AddressDetails']['Country']['AdministrativeArea']['SubAdministrativeArea']['Locality']['PostalCode']['PostalCodeNumber'];
        
        $countryName="";
        $countryName=$jsondata['Placemark'][0]['AddressDetails']['Country']['CountryName'];

        $addressline="";
        $addressline= $jsondata['Placemark'][0]['AddressDetails']['Country']['AdministrativeArea']['SubAdministrativeArea']['Locality']['AddressLine'][0];
        
        if($addressline=="") {
            $addressline= $jsondata['Placemark'][0]['AddressDetails']['Country']['AdministrativeArea']['SubAdministrativeArea']['Locality']['Thoroughfare']['ThoroughfareName'];
        }
        if($addressline=="") {
            $addressline= $jsondata['Placemark'][0]['AddressDetails']['Country']['AdministrativeArea']['SubAdministrativeArea']['Locality']['DependentLocality']['DependentLocalityName'];
        }        
        $addressline=str_replace(",","|",$addressline);
        
        if(SERVER=="production") {
            $timestamp = strtotime("+6 hours");
        } else {
            $timestamp = strtotime("now");
        }
        
        $reportedDate=date("m/d/y H:i:s",$timestamp);
        
        
        $ft = new FusionTable($this->fusionTablesToken); 
        $sql="INSERT INTO ".$this->table." (lat,lon,reported_date,reported_by,address,city,zip,addressline,country) VALUES ($latf,$lonf,'$reportedDate','$reportedBy','$address','$city','$zip','$addressline','$countryName')";
        //return $sql;
        $res= $ft->query($sql);
        if(is_string($res)){
            $this->checkToken(true);
            return $this->reportBache($lat,$lon,$reportedBy);
        }        
        
        //Tweet!!!
		$tweet = new Twitter(TWITTER_USER, TWITTER_PASS);
		$addressf=str_replace("|",",",$address);
		$tweetMessage="Otro bache en $addressf Más en http://otrobache.com #fb";
        $success = $tweet->update($tweetMessage);
		if (!$success) {
			error_log("TWITTER PROBLEM: ".$tweet->error);
		}		
                
        return $address;

    }
    
    public function getNumBaches($locality=null,$country) {        
        $ft = new FusionTable($this->fusionTablesToken); 
        if($locality!=null && $locality!="") {
            $sql="SELECT COUNT() FROM .$this->table WHERE city='$locality' AND country='$country'";
        } else {
            $sql="SELECT COUNT() FROM .$this->table WHERE country='$country'";
        }

        
        $res = $ft->query($sql);        

        if(is_string($res)){
            $this->checkToken(true);
            return $this->getNumBaches($locality,$country);
        }       
        if(count($res)>0) {
            $resnum=number_format($res[0]['count()'],0,",",".");
        } else {
            $resnum=0;
        }     
    
        return $resnum;
    }
    
    public function getLastBaches($locality=null,$country) {
        $ft = new FusionTable($this->fusionTablesToken); 
        if($locality!=null && $locality!="") {
            $sql="SELECT count(),lat,lon,address,addressline,zip,city FROM .$this->table WHERE city='$locality' AND country='$country' GROUP BY lat,lon,address,address,addressline,zip,city  ORDER BY reported_date DESC LIMIT 15";
        } else {
            $sql="SELECT count(),lat,lon,address,addressline,zip,city FROM .$this->table WHERE country='$country' GROUP BY lat,lon,address,address,addressline,zip,city ORDER BY reported_date DESC LIMIT 15";
        }            

        $res = $ft->query($sql);
        if(is_string($res)){
            $this->checkToken(true);
            return $this->getLastBaches($locality,$country);
        }            
        return $res;              
    }
    
    public function getCities($country) {
        $ft = new FusionTable($this->fusionTablesToken); 
        //$sql="SELECT count(),city FROM .$this->table WHERE country='$country' GROUP BY city ORDER BY count() DESC LIMIT 50";
        $sql="SELECT count(),city FROM .$this->table WHERE country='$country' GROUP BY city LIMIT 50";         

        $res = $ft->query($sql);
        if(is_string($res)){
            $this->checkToken(true);
            return $this->getCities();
        }            
        return $res;              
    }    
    
    function visitorLocation(){
        $location = array();
        $location['lat'] = "40.4";
    	$location['lon'] = "-3.6833";
    	$location['city'] = "Madrid";
    	$location['country'] = "Spain";

			if(SERVER=="development") {
				return $location;
			}
        @$link = mysql_connect('db.geekisp.com', 'jatorre_viz', 'otrobache');
        if (!$link) {
        	return $location;
        }



        @$db_selected = mysql_select_db("geoip");
        if (!$db_selected) {
            return $location;
        }

    	$ip = $_SERVER['REMOTE_ADDR'];

        $sql="SELECT city,country_code,latitude,longitude FROM ip_group_city inner join locations on ip_group_city.location=locations.id where ip_start <= INET_ATON('$ip') order by ip_start desc limit 1";

        @$query=mysql_query($sql);
        if (!$query) {
            return $location;
        }

        @$result = mysql_fetch_assoc($query);
        if($result){
            $location['lat'] = $result['latitude'];
        	$location['lon'] =  $result['longitude'];
        	$location['city'] =  $result['city'];
        	$location['country'] =  $result['country_code'];        
        } 

    	return $location;
    } 
    
    /*
    public function deleteAllDB() {
        $this->fusionTablesToken = GoogleClientLogin(GMAIL_USER, GMAIL_PASS, "fusiontables"); 
        $ft = new FusionTable($this->fusionTablesToken); 
        for($i=0;$i<110;$i++) {
            $sql="SELECT ROWID FROM .$this->table LIMIT 1";
            $res = $ft->query($sql);
            $sql="DELETE FROM .$this->table WHERE ROWID='".$res[0]['rowid']."'";
            $res = $ft->query($sql);
        }
        return null;
    }
    */
    
    
    public function updateDB() {
        $this->fusionTablesToken = GoogleClientLogin(GMAIL_USER, GMAIL_PASS, "fusiontables"); 
        $ft = new FusionTable($this->fusionTablesToken); 
        for($i=0;$i<320;$i++) {
            $sql="SELECT ROWID FROM .$this->table ORDER BY country OFFSET ".($i+1)." LIMIT 1";
            $res = $ft->query($sql);
            $sql="UPDATE .$this->table SET country='España' WHERE ROWID='".$res[0]['rowid']."'";
            $res = $ft->query($sql);
        }
        return null;
    }
    
    
    public function executeSql($sql) {
        $this->fusionTablesToken = GoogleClientLogin(GMAIL_USER, GMAIL_PASS, "fusiontables"); 
        $ft = new FusionTable($this->fusionTablesToken);        
        return $ft->query("INSERT INTO 136993 (lat,lon,reported_date,reported_by,address,city,zip,addressline,country) VALUES (40.41962,-3.6889,'04/29/10 12:47:11','web','Plaza de la Independencia| 8| 28014 Madrid| Spain','madrid','28014','Plaza de la Independencia| 8','España')");
    }
       
    
}

?>