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
	
	function getContriesForRegion($regionId) {
		$res=array();
		
		for($i=0;$i<18;$i++) {
			$c=array();
			$c['id']=$i;
			$c['name']="Spain".$i;
			$res[]=$c;
		}
		return $res;
	}
	
	
}
?>