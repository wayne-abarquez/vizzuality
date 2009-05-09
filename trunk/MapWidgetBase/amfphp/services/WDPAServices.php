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
        
        $url="http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/wdpa_all_WGS84/MapServer/1/query?text=&geometry=&geometryType=esriGeometryPoint&inSR=4326&spatialRel=esriSpatialRelIntersects&where=site_id%3D$siteid&returnGeometry=true&outSR=&outFields=Site_ID%2CEnglish_Name%2CCountry%2CDocumentedTotalArea%2CStatus&f=json";
    
        $data = file_get_contents($url);
        $json = json_decode($data,true);
        
        if(count($json['features']<1)) {
 $url="http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/wdpa_all_WGS84/MapServer/0/query?text=&geometry=&geometryType=esriGeometryPoint&inSR=4326&spatialRel=esriSpatialRelIntersects&where=site_id%3D$siteid&returnGeometry=true&outSR=&outFields=Site_ID%2CEnglish_Name%2CCountry%2CDocumentedTotalArea%2CStatus&f=json";           
 
         $data = file_get_contents($url);
         $json = json_decode($data,true);
        }
        
        //return $url;   
        
        $result=array();
        $result['id']=$json['features'][0]['attributes']['Site_ID'];
        $result['name']=$json['features'][0]['attributes']['English_Name'];
        $result['country']="Spain";
        $result['has']=$json['features'][0]['attributes']['Shape_Area'];
        $result['status']=$json['features'][0]['attributes']['Status'];
        $result['countryIsoCode']="ES";
        $result['geometry']=$json['features'][0]['geometry'];
        $result['geomType']=$json['geometryType'];
        
        
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
        $result['numAreas']=750;
        $result['iso']=$iso;
        $result['name']="Spain";
        $result['coveragePercentage']=34;
        $result['numberCoral']=100;
        $result['numMangrove']=0;
        $result['numSeagrass']=4;
        $result['north']=43.7917251586914;
        $result['south']=27.6388168334961;
        $result['east']=4.31538963317871;
        $result['west']=-18.169641494751;
        
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
        $result['international']=750;
        $result['national']=110000;
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
	
	public function getAreasByLatLng($url) {

        //$envelope=urlencode($envelope);
        //$mapextent=urlencode($mapextent);
        //$imagedisplay=urlencode($imagedisplay);
	    //$url="http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/wdpa_all_WGS84/MapServer/identify?geometryType=esriGeometryEnvelope&geometry=". $envelope ."&tolerance=0&mapExtent=". $mapextent ."&imageDisplay=".$imagedisplay."&returnGeometry=true&f=json";

       // $url = "http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv1_IdentifyResults/MapServer/0/query?geometryType=esriGeometryEnvelope&spatialRel=esriSpatialRelIntersects&where=Site_ID%3D".$a['siteid']."&returnGeometry=true&f=json&outfields=Site_ID,English_Name,Local_Name";
        
        $data = file_get_contents($url);
        $json = json_decode($data,true); 
        
        $numres=count($json['results']);
        
        $result=array();
        if($numres==0) {
            $result['numres']=0;
            return $result;
        }
        if($numres==1) {
            $result['numres']=1;
            
            $result['siteid']= $json['results'][0]['attributes']['Site ID'];
            return $result;            
        }
        
        if($numres<=10) {
            $result['numres']=$numres;
            $result['results']=array();
            
            /*foreach ($json['results'] as $_pa) {
                $pa=array();
                $pa['siteId']=$_pa['attributes']['Site ID'];
                $pa['name']=$_pa['attributes']['English Name'];
                $pa['siteType']=$_pa['attributes']['Site Type'];
                $pa['east']=$_pa['geometry']['rings'][0][0][1];
                $pa['west']=$_pa['geometry']['rings'][0][0][0];
                $pa['north']=$_pa['geometry']['rings'][0][0][1];
                $pa['south']=$_pa['geometry']['rings'][0][0][0];                
                $result['results'][]=$pa;
            }*/
            $result['results']=$json['results'];
            return $result;            
        }  

        if($numres>10) {
              $result['numres']=$numres;
              return $result;            
          }              
        
	}
	
	public function getAreasByPoint($lat,$lon) {
	    
	}

}
?>