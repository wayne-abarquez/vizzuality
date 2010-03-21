<?php
require_once("../lib/fusiontableslib.php");
require_once("config.php");

class OtroBache {
    function __construct() {
        $this->fusionTablesToken = GoogleClientLogin(GMAIL_USER, GMAIL_PASS, "fusiontables"); 
        
        $this->table="136993";
        $this->api_key="ABQIAAAAtDJGVn6RztUmxjnX5hMzjRRw3KWZ-x9A2HylNheByWtToULKzxSlnf4JpCGuPalF_xWQj_zXFJuCfw";
    }
    
    
    //API
    public function reportBache($lat,$lon,$reportedBy,$scale,$pedestrian,$address) {
               
        // format this string with the appropriate latitude longitude
        $url = 'http://maps.google.com/maps/geo?q='.$lat.','.$lon.'&output=json&sensor=true_or_false&key=' . $this->api_key;
        // make the HTTP request
        $data = @file_get_contents($url);
        // parse the json response
        $jsondata = json_decode($data,true);
        $address =  $jsondata['Placemark'][0]['address'];
        $today = getdate();
        $reportedDate=$today['mon']."/".$today['mday']."/".$today['year'];
        
        $ft = new FusionTable($this->fusionTablesToken); 
        $sql="INSERT INTO ".$this->table." (lat,lon,reported_date,reported_by,scale,pedestrian,address) VALUES ($lat,$lon,'$reportedDate','$reportedBy',$scale,$pedestrian,'$address')";
        //return $sql;
        return $ft->query($sql);

    }
    
    
}

?>