<?php
require_once("fusiontableslib.php");
require_once("config.php");

class OtroBache {
    function __construct() {        
        $this->table="136993";
        $this->api_key="ABQIAAAAtDJGVn6RztUmxjnX5hMzjRRw3KWZ-x9A2HylNheByWtToULKzxSlnf4JpCGuPalF_xWQj_zXFJuCfw";
    }
    
    
    //API
    public function reportBache($lat,$lon,$reportedBy,$scale,$pedestrian,$address) {
        $this->fusionTablesToken = GoogleClientLogin(GMAIL_USER, GMAIL_PASS, "fusiontables"); 
               
        // format this string with the appropriate latitude longitude
        $url = 'http://maps.google.com/maps/geo?q='.$lat.','.$lon.'&output=json&sensor=true_or_false&key=' . $this->api_key;
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
        $reportedDate=date("m/d/y h:i:s A");
        
        $ft = new FusionTable($this->fusionTablesToken); 
        $sql="INSERT INTO ".$this->table." (lat,lon,reported_date,reported_by,scale,pedestrian,address) VALUES ($lat,$lon,'$reportedDate','$reportedBy',$scale,$pedestrian,'$address')";
        //return $sql;
        $newId= $ft->query($sql);
        
        //remove cache
        try {
            unlink('cache/getNumBaches.txt');
            unlink('cache/getLastBaches.txt');      
        }catch (Exception $e) {}
        try {
            unlink('../cache/getNumBaches.txt');
            unlink('../cache/getLastBaches.txt');        
        }catch (Exception $e) {}
                
        return $address;

    }
    
    public function getNumBaches() {        
        //cache
        if(!file_exists( 'cache/getNumBaches.txt' )) {
            $this->fusionTablesToken = GoogleClientLogin(GMAIL_USER, GMAIL_PASS, "fusiontables"); 
            $ft = new FusionTable($this->fusionTablesToken); 
            $sql="SELECT COUNT() FROM .$this->table";
            $res = $ft->query($sql);        
            $resnum=number_format($res[0]['count()'],0,",",".");
            $fp = fopen('cache/getNumBaches.txt', 'w');
            fwrite($fp, $resnum);
            fclose($fp);
        } else {
            $filename = "cache/getNumBaches.txt";
            $fp = fopen($filename, "r");
            $resnum = fread($fp, filesize($filename));
            fclose($fp);
        }       
        
        return $resnum;
    }
    
    public function getLastBaches() {
        if(!file_exists( 'cache/getLastBaches.txt' ) || 1==1) {
            $this->fusionTablesToken = GoogleClientLogin(GMAIL_USER, GMAIL_PASS, "fusiontables"); 
            $ft = new FusionTable($this->fusionTablesToken); 
            $sql="SELECT lat,lon,address,reported_date,reported_by,address FROM .$this->table ORDER BY reported_date DESC";
            $res = $ft->query($sql);    
            $fp = fopen('cache/getLastBaches.txt', 'w');
            fwrite($fp, serialize($res));
            fclose($fp);
        } else {
            $filename = "cache/getLastBaches.txt";
            $fp = fopen($filename, "r");
            $res = fread($fp, filesize($filename));
            $res = unserialize($res);
            fclose($fp);
        }       
        
        return $res;              
    }
    
    
}

?>