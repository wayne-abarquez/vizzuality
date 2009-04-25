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

}
?>