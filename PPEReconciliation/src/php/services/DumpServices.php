<?php

class DumpServices {
	
	function __construct() {
	}
	
	function login($username,$password) {
		$res=array();
		
		if ($username=="") {
			$res['loginresult']=true;
			$res['username']="Craig";
			$res['userid']="65";
		} else {
			$res['loginresult']=false;
		}
		
		return $res;
	}
	
	function getContriesForRegion($regionId,$page,$perPage) {
		$resul=array();
		
		$res=array();
		for($i=0;$i<24;$i++) {
			$c=array();
			$c['id']=$i;
			$c['name']=$regionId."-".$i;
			$c['numareas']=23;
			$res[]=$c;
		}
		$resul['results'] = $res;
		$resul['total'] = 50; 
		return $resul;
	}
	
	function prepareDownload($countries,$pas,$search) {
		error_log($countries);
	}
	
	
}
?>