<?php
require_once(dirname(__FILE__) ."/../config.php");

class Services {
	
	function __construct() {
		$this->conn = mysql_connect(DB_HOST, DB_USER, DB_PASSWORD);
		mysql_select_db($_SESSION['db'], $this->conn);
		if ($this->conn){
			//error_log("conexion ok");
		}else{
			//error_log("conexion mal");
		}
	}
	
	public function getAllGenus() {
		$sql = "select distinct Genus from BIOCASE_IDENTIFIC where highertaxon is not null order by Genus";
		$query = mysql_query($sql, $this->conn);	
		$result=array();
		while ($row = mysql_fetch_assoc($query)){
			$result[]=ucfirst($row['Genus']);
		}
		return $result;
	}
	
	public function getAllFamilies() {
		$sql = "select distinct highertaxon from BIOCASE_IDENTIFIC where highertaxon is not null order by highertaxon";
		$query = mysql_query($sql, $this->conn);	
		$result=array();
		while ($row = mysql_fetch_assoc($query)){
			$result[]=ucfirst(strtolower($row['highertaxon']));
		}
		return $result;
	}
	
	public function getAllCountries() {
		$sql = "SELECT distinct countryname FROM BIOCASE_UNITS WHERE countryname is not null";
		$query = mysql_query($sql, $this->conn);	
		$result=array();
		while ($row = mysql_fetch_assoc($query)){
			$result[]=ucfirst(strtolower($row['countryname']));
		}
		return $result;
	}	
	
	//sheetResults
	public function getAllUnitDetailsByUnitID($UnitID) {
		$sql = "SELECT * FROM BIOCASE_UNITS B left join utmcoords C on B.UTMText=C.utm where UnitID=$UnitID";
		$query = mysql_query($sql, $this->conn);	
		$row = mysql_fetch_assoc($query);
		return $row;
	}
	
	public function getUnitCoordinateDetailsByUnitID($UnitID) {
		$sql = "SELECT B.UnitID,BiotopeText,LocalityText,UTMText,LatitudeDecimal,LongitudeDecimal,coords,NameAuthorYearString FROM BIOCASE_UNITS B left join BIOCASE_IDENTIFIC I on B.UnitID=I.UnitID left join utmcoords C on B.UTMText=C.utm WHERE B.UnitID=$UnitID AND PreferedFlag=true";
		$query = mysql_query($sql, $this->conn);	
		$row = mysql_fetch_assoc($query);
		return $row;
	}	
	
	public function getAllIdentificByUnitID($UnitID) {
		$sql = "SELECT * FROM BIOCASE_IDENTIFIC where UnitID=$UnitID order by PreferedFlag DESC, LabelFlag DESC";
		$query = mysql_query($sql, $this->conn);	
		$result=array();
		while ($row = mysql_fetch_assoc($query)){
			$result[]=$row;
		}
		return $result;
	}
	
	public function getAllImagesByUnitID($UnitID) {
		$sql = "SELECT ImageURI FROM BIOCASE_IMAGES where UnitID=$UnitID"; 
		$query = mysql_query($sql, $this->conn);	
		$result=array();
		while ($row = mysql_fetch_assoc($query)){
			$result[]=$row;
		}
		return $result;
	}
	
	public function getAllAgentsByUnitID($UnitID) {
		$sql = "SELECT * FROM BIOCASE_GATHERING_AGENTS where UnitID=$UnitID";
		$query = mysql_query($sql, $this->conn);	
		$row = mysql_fetch_assoc($query);
		return $row;
	}
	
	public function getAllAreasByUnitID($UnitID) {
		$sql = "SELECT * FROM BIOCASE_UNIT_REGION where UnitID=$UnitID";
		$query = mysql_query($sql, $this->conn);	
		$result=array();
		while ($row = mysql_fetch_assoc($query)){
			$result[]=$row;
		}
		return $result;
	}
	
	//TaxonResults
	public function getAllPliegosByTaxon($nameauthoryearstring) {
	
		
		
		
		if( mb_check_encoding($nameauthoryearstring,'UTF-8')!=true) {
			$nameauthoryearstring = utf8_encode($nameauthoryearstring);
		}
		
		$accents = '/&([A-Za-z]{1,2})(grave|acute|circ|cedil|uml|lig);/';
		$string_encoded = htmlentities($nameauthoryearstring,ENT_NOQUOTES,'UTF-8');
		$nameauthoryearstring = html_entity_decode(preg_replace($accents,'$1',$string_encoded));
		

		function sql_safe($string){
        	$output = stripslashes($string);
        	$output = str_replace('"','\"',$output);
        	$output = str_replace("'","\'",$output);
			$output = str_replace("*","%",$output);
        	return $output;
		}
		$filter="";
		$_SESSION['filter']="";
		
		
		
		$sql = "SELECT u.UnitID, u.LatitudeDecimal, u.LongitudeDecimal, C.coords, localitytext, count(imageURI) as num_images ,(SELECT GatheringAgentsText FROM BIOCASE_GATHERING_AGENTS where UnitID=u.UnitID) as AgentText ,nameauthoryearstring, highertaxon from BIOCASE_UNITS u left join BIOCASE_IDENTIFIC i on u.UnitID = i.UnitID left join utmcoords C on u.UTMText=C.utm left join BIOCASE_IMAGES Im on u.UnitID=Im.UnitID where ";
		
		if ($nameauthoryearstring) 	{ $filter = $filter . " i.nameauthoryearstring like '". sql_safe($nameauthoryearstring) ."'"; }
	    $sql= $sql . $filter;
		$sql= $sql . " group by UnitID  order by u.UnitID";
		$query = mysql_query($sql, $this->conn);	
		
		$res=array();
		$result=array();
		$scientificname="";
		$family="";
		while ($row = mysql_fetch_assoc($query)){
			$result[]=$row;
			$scientificname=$row['nameauthoryearstring'];
			$family=$row['highertaxon'];
		}
		$res['datos']=$result;
		$res['scientificname']=$scientificname;
		$res['family']=$family;
		
		//echo $sql;
		//die();

		return $res;
	}
	
	public function getUnitCoordinateDetailsByTaxon($nameauthoryearstring) {
		$sql = "SELECT B.UnitID,BiotopeText,LocalityText,UTMText,LatitudeDecimal,LongitudeDecimal,coords,NameAuthorYearString FROM BIOCASE_UNITS B left join BIOCASE_IDENTIFIC I on B.UnitID=I.UnitID left join utmcoords C on B.UTMText=C.utm WHERE I.nameauthoryearstring='$nameauthoryearstring' AND PreferedFlag=true AND (coords is not null or LatitudeDecimal is not null)";
		$query = mysql_query($sql, $this->conn);	
		$result=array();
		while ($row = mysql_fetch_assoc($query)){
			$result[]=$row;
		}
		return $result;
	}

	
	//index
	public function getTotalRecords() {
		$query = "SELECT count(UnitID) as total FROM BIOCASE_UNITS";
		$result = mysql_query($query, $this->conn);		
		$row = mysql_fetch_assoc($result);
		return $row['total'];
	}
	
	public function getTotalRecordsWithImage() {
		$query = "SELECT count(UnitID) as total FROM BIOCASE_UNITS where has_images = True";
		$result = mysql_query($query, $this->conn);		
		$row = mysql_fetch_assoc($result);
		return $row['total'];
	}
	
	public function getTotalGeoreferenceRecords() {
		$query = "SELECT count(UnitID) as total FROM BIOCASE_UNITS where UTMText is not null";
		$result = mysql_query($query, $this->conn);		
		$row = mysql_fetch_assoc($result);
		return $row['total'];
	}
	
	//queryForm
	public function getLastUpdate() {
		$query = "SELECT source_update as lastupdate FROM BIOCASE_METADATA";
		$result = mysql_query($query, $this->conn);		
		$row = mysql_fetch_assoc($result);
		return $row['lastupdate'];
	}
	

	
	public function searchSheets ($nameauthoryearstring,$highertaxon,$genus,$localitytext, $countryname,$utmformula, $agenttext, $UnitID, $datetext, $datesearchtype,$offset) {
		
		function sql_safe($string){
        	$output = stripslashes($string);
        	$output = str_replace('"','\"',$output);
        	$output = str_replace("'","\'",$output);
			$output = str_replace("*","%",$output);
        	return $output;
		}

		//Prepare SQL statement from the query page

		//selects
		$sql="SELECT nameauthoryearstring, highertaxon,count(u.UnitID) as num_sheets, count(imageURI) as num_images,count(LENGTH(UTMText)>0 OR LENGTH(LatitudeDecimal)>0 ) as num_georef from BIOCASE_UNITS u left join BIOCASE_IDENTIFIC i on u.UnitID = i.UnitID left join BIOCASE_IMAGES Im on u.UnitID=Im.UnitID left join utmcoords C on u.UTMText=C.utm";


		//create the filter part
		$sql=$sql." where i.preferedflag=true and nameauthoryearstring !=''";
		$filter="";
		$_SESSION['filter']="";
		//filtro

        if ($nameauthoryearstring) 	{ $filter = $filter . " and i.nameauthoryearstring like '". sql_safe($nameauthoryearstring) ."%'"; }
        if ($highertaxon) 			{ $filter = $filter . " and i.highertaxon like '". sql_safe($highertaxon) ."'"; }
        if ($genus) 			    { $filter = $filter . " and i.genus like '". sql_safe($genus) ."'"; }
        if ($localitytext)		 	{ $filter = $filter . " and localitytext like '". sql_safe($localitytext) ."'"; }
        if ($countryname) 			{ $filter = $filter . " and countryname like '". sql_safe($countryname) ."'"; }
        if ($utmformula) 			{ $filter = $filter . " and UTMText like '". sql_safe($utmformula) ."%'"; }
        if ($agenttext) 			{ $filter = $filter . " and u.unitid in (select UnitID from BIOCASE_GATHERING_AGENTS where GatheringAgentsText like '". sql_safe($agenttext) ."%')" ; }
        if ($UnitID) 				{ $filter = $filter . " and u.UnitID = ". sql_safe($UnitID) ."" ; }

        if ($datetext) {
        	if  ($datesearchtype=="greaterthan") {
        		$filter = $filter . " and u.ISODateTimeBegin < '". sql_safe($datetext) ."'"; 
        	} elseif($datesearchtype=="lessthan") {
        		$filter = $filter . " and u.ISODateTimeBegin > '". sql_safe($datetext) ."'"; 
        	} elseif($datesearchtype=="equal") {
        		$filter = $filter . " and u.ISODateTimeBegin like '". sql_safe($datetext) ."'"; 
        	}
        }

    	//set the filter and set the session for the after page
    	$sql= $sql . $filter;
    	
    	//group by
    	$sql= $sql . " group by nameauthoryearstring, highertaxon";

    	$rs_specimen = array();
    	$res=array();

			
	
    	$sqlcount="select count(*) as num_records from ($sql)  tot";	
    	//Limit and offset for Mysql!
    	$result = mysql_query($sqlcount, $this->conn);
    	$numrec = mysql_fetch_assoc($result);
    	if($numrec['num_records']>0) {		
    		$res['count'] = $numrec['num_records'];
        } else {
            $res['count'] =0;  
            $res['hascoords'] =false;  
    		$res['datos']=array();
    		return $res;
        }		

    	if($offset=="") {
    		$offset=0;
    	}
    	$sql.=" order by nameauthoryearstring ASC limit 10 offset $offset";
        
        //$hasCoords=false;
    	$result = mysql_query($sql, $this->conn);		
    	while ($row = mysql_fetch_assoc($result)){
            /*if($row['coords']!="" || $row['LatitudeDecimal']!="") {
                $hasCoords=true;
            } */   	    
    		$rs_specimen[] = $row; 
    	}
    	//$res['hascoords'] =$hasCoords;
    	$res['datos']=$rs_specimen;
    	
	
    	return $res;
    }
	
	public function searchTaxon ($nameauthoryearstring,$highertaxon,$genus,$offset) {
		
		function sql_safe($string){
        	$output = stripslashes($string);
        	$output = str_replace('"','\"',$output);
        	$output = str_replace("'","\'",$output);
			$output = str_replace("*","%",$output);
        	return $output;
		}

		//Prepare SQL statement from the query page

		//selects
		$sql="SELECT u.UnitID, nameauthoryearstring, highertaxon,count(u.UnitID) as num_sheets, GROUP_CONCAT(DISTINCT localitytext SEPARATOR ', ') as locality, GROUP_CONCAT(DISTINCT CountryName SEPARATOR ', ') as country, max(AltitudeUpperValue) as altitudUpper, min(AltitudeLowerValue) as altitudLower from BIOCASE_UNITS u left join BIOCASE_IDENTIFIC i on u.UnitID = i.UnitID";

		//create the filter part
		$sql=$sql." where i.preferedflag=true";
		$filter="";
		$_SESSION['filter']="";
		//filtro

if ($nameauthoryearstring) 	{ $filter = $filter . " and i.nameauthoryearstring like '". sql_safe($nameauthoryearstring) ."'"; }
if ($highertaxon) 			{ $filter = $filter . " and i.highertaxon like '". sql_safe($highertaxon) ."'"; }
if ($genus) 			    { $filter = $filter . " and i.genus like '". sql_safe($genus) ."'"; }

	//set the filter and set the session for the after page
	$sql= $sql . $filter;
	
	$sql.=" group by nameauthoryearstring, highertaxon";

	$rs_specimen = array();
	$res=array();

	//Limit and offset for Mysql!
	$sqlcount="select count(*) as num_records from ($sql)  tot";	
	//Limit and offset for Mysql!
	$result = mysql_query($sqlcount, $this->conn);
	$numrec = mysql_fetch_assoc($result);
	if($numrec['num_records']>0) {		
		$res['count'] = $numrec['num_records'];
    } else {
        $res['count'] =0;  
		$res['datos']=array();
		return $res;
    }	
		
	if($offset=="") {
		$offset=0;
	}
	$sql.=" order by nameauthoryearstring ASC limit 10 offset $offset";

	$result = mysql_query($sql, $this->conn);		
	while ($row = mysql_fetch_assoc($result)){
		$rs_specimen[] = $row; 
	}	
	$res['datos']=$rs_specimen;	
		
	return $res;
}	        
    
	
}

?>
