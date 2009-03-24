<?php

class WdpaServices {
    /**
	* Query by bounding box and get basic information on the PAs
	* inside.
	*	Returns a List of objects with id,name.
	*/
	public function getPasByBBox($east,$west,$south,$north) {
      
		$sql="select site_id as id, local_name as name from polygon where the_geom&& bbox";

		$fooData = array();
		$fooData[]="887";
		return $fooData;
	}
	
    /**
	* Get all possible metadata for a certain PA by ID.
	* The id is the GUID of the PA.
	* Returns an object with all the metadata.
	*/
	public function getPaMetadata($paId) {
		$sql="select * from polygon where site_id=$paId";
	
		return "Hi";
	}
	
    /**
	* Get the different fields metadata needed
	* for creating the search functionality on the map widget.
	* Returns an object with all the different fields.
	*/
	public function getSearchFieldsMetadata() {

		//$conn = new PDO("mssql:wcmc-gis-01;dbname=wdpa", "testuser", "testpassword");
		
		
		///$conn = new PDO("odbc:Driver={SQL Server Native Client 10.0};Server=wcmc-gis-01;Database=wdpa;Uid=wdpa_admin;
		
	  try {	
	    $hostname = "wcmc-gis-01";            //host
	    $dbname = "wdpa";            //db name
	    $username = "wdpa_admin";            // username like 'sa'
	    $pw = "wdpa_admin";                // password for the user

	    //$dbh = new PDO ("mssql:host=$hostname;dbname=$dbname","$username","$pw");
		$dbhandle = mssql_connect($hostname, $username, $pw);
		
		$selected = mssql_select_db($dbname, $dbhandle);

		} catch (PDOException $e) {
	    return("Failed to get DB handle: " . $e->getMessage() . "\n");
	  }
		
		return "hey";
	}	
	
    /**
	* Get all PA names and IDs to create a SAYT interface on the mapping widget
	*/	
	public function getPaNames() {
		
	}
	
	
}
?>