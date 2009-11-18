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
		for($i=1;$i<25;$i++) {
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
	
	function getPendingTasks($page,$perPage) {
		$resul=array();
		$res=array();
		for($i=1;$i<9;$i++) {
			$t=array();
			$t['type'] = $i;
			$t['code'] = "DW541";
			$t['description'] = "Spain";
			$t['what']="Country Download";
			$t['numareas']=2431;
			$t['status'] = "preparingDownload";
			$t['statuspercen'] = 72;
			$t['date'] = "2009/11/".$i." 12:34:00";
			$res[]=$t;
		}
		$resul['results'] = $res;
		$resul['total'] = 50;		
		
		return $resul;
	}
	
	function getTaskDeletions($code,$p) {
		$deleted=array();
		for($i=1;$i<9;$i++) {
			$del=array();
			$del['id'] = $i;
			$del['name'] = "PA-". $i;
			$del['country'] = "United States";
			$deleted[]=$del;
		}
		$resul=array();	
		$resul['results'] = $deleted;
		$resul['total'] = 50;
		return $resul;
	}
	function getTaskNewPas($code,$p) {
		
		$news=array();
		for($i=9;$i<16;$i++) {
			$new=array();
			$new['id'] = $i;
			$new['name'] = "PA-". $i;
			$new['country'] = "United States";
			$news[]=$new;
		}	
		$resul=array();	
		$resul['results'] = $news;
		$resul['total'] = 50;
		return $resul;
	}
	function getTaskUpdates($code,$p) {	
		$resul=array();
		$updates=array();
		for($i=17;$i<21;$i++) {
			$up=array();
			$up['id'] = $i;
			$up['name'] = "PA-". $i;
			$up['country'] = "United States";
			$updates[]=$up;
		}		
		$resul['results'] = $updates;
		$resul['total'] = 50;
		return $resul;
	}
	
	
}
?>