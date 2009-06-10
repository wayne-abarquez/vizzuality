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
	    $stmt = $this->dbHandle->prepare("select iso2,name,num_providers,num_resources,num_occurrences, encoded_points,encoded_zoom_factor,encoded_levels,encoded_num_levels, south , west,east, north from countries where num_occurrences>0 order by num_occurrences DESC  ");

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
	
	
	public function getAllCountriesForEdit() {
	    $stmt = $this->dbHandle->prepare("select iso2,name,num_providers,num_resources,num_occurrences,south , west,east, north from countries order by iso2");
	    $stmt->execute();
	    return $stmt->fetchAll(PDO::FETCH_ASSOC);
	}
	
	public function getAllProvidersForEdit() {
	    $stmt = $this->dbHandle->prepare("select resource_count,occurrence_count,iso_country_code,provider_name,providr_url,provider_city , lat,lon, provider_id from providers order by provider_id");
	    $stmt->execute();
	    return $stmt->fetchAll(PDO::FETCH_ASSOC);
	}	
	
	public function updateCountry($iso2,$num_providers,$num_resources,$num_occurrences,$south,$east,$north,$name) {
	    if (!$_SESSION['logged']) {
	        throw new Exception("user not logged in");	   
	    } 
        $sql="UPDATE countries SET num_providers=?,num_resources=?,num_occurrences=?,south=?,east=?,north=?,name=? WHERE iso2=?";
        $stmt = $this->dbHandle->prepare($sql);
        $stmt->execute(array($num_providers,$num_resources,$num_occurrences,$south,$east,$north,$name,$iso2));
        return;
	}

	public function updateProvider($resource_count,$occurrence_count,$iso_country_code,$provider_name,$providr_url,$provider_city,$lat,$lon,$provider_id) {
	    if (!$_SESSION['logged']) {
	        throw new Exception("user not logged in");	    
	    }
        $sql="UPDATE providers SET resource_count=?,occurrence_count=?,iso_country_code=?,provider_name=?,providr_url=?,provider_city=?,lat=?,lon=? WHERE provider_id=?";
        $stmt = $this->dbHandle->prepare($sql);
        $stmt->execute(array($resource_count,$occurrence_count,$iso_country_code,$provider_name,$providr_url,$provider_city,$lat,$lon,$provider_id));
	    return;
	}
	
	public function updateField($table,$field,$newValue,$id) {
	    if (!$_SESSION['logged']) {
	        throw new Exception("user not logged in");	    
	    }
	    if(!is_numeric($newValue)){
	        $newValue="'".$newValue."'";
	    }
	    if($table=="providers") {
	        $sql="UPDATE providers SET ".$field."=".$newValue." WHERE provider_id=".$id;
	    } elseif($table=="countries") {
	        $sql="UPDATE countries SET ".$field."=".$newValue." WHERE iso2='".$id."'";
	    } else {
	        throw new Exception("unkown table");
	    }
        return $this->dbHandle->exec($sql);
        
        

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