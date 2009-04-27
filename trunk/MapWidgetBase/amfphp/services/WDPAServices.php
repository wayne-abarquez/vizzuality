<?php

class WDPAServices {
	/*
        getFeaturedArea():{name,id,description}
        getWorldStats():{totalAreas,international,national,coveragePercentage}
        getCountryList():[{name,isocode,numAreas}]
        getCountryStatsByISO(isocode):{numAreas,coveragePercentage,numberCoral,numMangrove,numSeagrass}
        searchAreasByName(search):[{name,siteId,has}]
        getPaData(id):{name,country,has... all information possible}	
	**/
	function __construct() {
	}

    public function getPaData($siteid) {
        $result=array();
        $result['id']=5;
        $result['name']="Yosemite";
        $result['country']="Spain";
        $result['countryIsoCode']="ES";
        $result['has']=138000;
        $result['north']=62.23;
        $result['south']=60.23;
        $result['east']=34.233;
        $result['west']=35.23;
        
        return $result;
	}
	
	public function getPaList($isocode='') {
	    $result=array();
	    $result['index']="";
	    $result['data']=array();
	    for($i=0;$i<30000;$i++) {
	        $result['data'][]="lala"+$i;
	        $result['index']+="lala<"+$i+">";
	    }
	    return $result;
	}


	public function searchAreasByName($search) {
	    $result=array();
	    $c=array();
	    $c['name']="Spain";
	    $c['siteId']=975;
	    $c['has']=2323;
	    $c['countryName']="Spain";
	    $c['countryIsoCode']="ES";	    	    
	    $result[]=$c;
	    $result[]=$c;
	    $result[]=$c;
	    $result[]=$c;
	    $result[]=$c;
	    $result[]=$c;
	    
	    return $result;
	}
    
    public function getCountryStatsByISO($iso) {
        $result=array();
        $result['numAreas']=130000;
        $result['iso']=$iso;
        $result['name']="Spain";
        $result['coveragePercentage']=34;
        $result['numberCoral']=138000;
        $result['numMangrove']=74;
        $result['numSeagrass']=345;
        $result['north']=70.23;
        $result['south']=60.23;
        $result['east']=34.233;
        $result['west']=39.23;
        
        return $result;
    }
    
    public function getFeaturedArea() {
        $featurearea=array();
        $featurearea['id']=975;
        $featurearea['name']="Yosemite";
        $featurearea['countryIsoCode']="US";
        $featurearea['countryName']="United States";
        $featurearea['description']="Yosemite is a nice place...";
        return $featurearea;
	}

    public function getWorldStats() {
        $result=array();
        $result['totalAreas']=130000;
        $result['international']=200;
        $result['national']=138000;
        $result['coveragePercentage']=74;
        $result['marine']=345;
        $result['terrestrial']=345345;
        
        return $result;
	}
	
	public function getCountryList() {
	    $result=array();
	    $c=array();
	    $c['name']="Spain";
	    $c['isocode']="ES";
	    $c['numAreas']=2323;
	    $result[]=$c;
	    $result[]=$c;
	    $result[]=$c;
	    $result[]=$c;
	    $result[]=$c;
	    $result[]=$c;
	    
	    return $result;
	}

}
?>