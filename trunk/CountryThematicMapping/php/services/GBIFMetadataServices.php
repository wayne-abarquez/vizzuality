<?php

require_once('class.polylineEncoder.php');

class GBIFMetadataServices {
	
	function __construct() {
		$this->dbHandle = new PDO('pgsql:host=localhost port=5432 dbname=tm user=postgres password=atlas');
	}
    
    public function login($user,$pass) {

        // create page view database table
        $sql = "SELECT * FROM admin WHERE username='$user' AND password='$pass'";        
        $result = $this->dbHandle->query($sql)->fetchAll(PDO::FETCH_COLUMN, 0);    

        if (count($result)<1) {
            $_SESSION['logged']=false;
            throw new Exception("user not logged in");
        } else {
            $_SESSION['logged']=true;
            return true;
        }
	}
	
	public function getCountries() {
	    $stmt = $this->dbHandle->prepare("select iso2,name,num_providers,num_resources,num_occurrences, encoded_points,encoded_zoom_factor,encoded_levels,encoded_num_levels, ymin(the_geom) as south , xmin(the_geom) as west,xmax(the_geom) as east, ymax(the_geom) as north from countries where num_occurrences>0  ");

         //$this->dbHandle->exec("set standard_conforming_strings=on");
        //$stmt->bindParam(':parent_name', $parentName, PDO::PARAM_STR, 255);
        $stmt->execute();
        $rs= $stmt->fetchAll(PDO::FETCH_ASSOC);	    
        $countries=array();
        $currentCountry=array();
        $currentCountryIso='';
        $polis=array();
        $encoder = new PolylineEncoder();
        foreach($rs as $record) {
            $currentCountry['iso2'] = $record['iso2'];
            $currentCountry['num_providers'] = $record['num_providers'];
            $currentCountry['num_resources'] = $record['num_resources'];
            $currentCountry['num_occurrences'] = $record['num_occurrences'];
            $currentCountry['encoded_points'] = str_replace("\\\\","\\",$record['encoded_points']);
            $currentCountry['encoded_zoom_factor'] = $record['encoded_zoom_factor'];
            $currentCountry['encoded_levels'] = $record['encoded_levels'];
            $currentCountry['encoded_num_levels'] = $record['encoded_num_levels'];
            $currentCountry['south'] = $record['south'];
            $currentCountry['west'] = $record['west'];
            $currentCountry['east'] = $record['east'];
            $currentCountry['north'] = $record['north'];
            $currentCountry['name'] = $record['name'];
            $countries[]=$currentCountry; 
                 
        }
	    return $countries;

	}
	
	public function getProvidersByCountry($isocode) {
	    $stmt = $this->dbHandle->prepare("SELECT * FROM providers WHERE iso_country_code=:isocode");
	    $stmt->bindParam(':isocode', $isocode, PDO::PARAM_STR, 255);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);	    
	}
	
	
	public function logout() {
	    session_destroy();
	}	    
	
	/*public function getAllItems() {
	    if (!$_SESSION['logged']) {
	        throw new Exception("user not logged in");
	    }
	    $sth = $this->dbHandle->prepare("SELECT * FROM item");
        $sth->execute();
        
        return $sth->fetchAll(PDO::FETCH_ASSOC);
	}
	
	public function getItemDetail($id) {
	    $sth = $this->dbHandle->prepare("SELECT * FROM item where id=$id");
        $sth->execute();
        
        return $sth->fetch(PDO::FETCH_ASSOC);
	}
	
	public function getItemList($maxItems) {
	    $sth = $this->dbHandle->prepare("SELECT * FROM item limit $maxItems");
        $sth->execute();
        
        return $sth->fetchAll(PDO::FETCH_ASSOC);
	}	*/	

}
?>