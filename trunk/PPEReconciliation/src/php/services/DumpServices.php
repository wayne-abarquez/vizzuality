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
			$res['pendingTasks']="1";
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
	
	function getOceans() {
		$res=array();
			$c=array();
			$c['id']=1;
			$c['name']="Pacific";
			$c['numareas']=23;
			$res[]=$c;
			$c=array();
			$c['id']=2;
			$c['name']="Atlantic";
			$c['numareas']=23;
			$res[]=$c;		
			$c=array();
			$c['id']=3;
			$c['name']="Mediterranean";
			$c['numareas']=23;
			$res[]=$c;				
		return $res;
	}	
	
	function prepareDownload($countries,$pas,$search) {
		error_log($countries);
	}
	
	function getPendingTasks($page,$perPage) {
		$resul=array();
		$res=array();

			$t=array();
			$t['type'] = 1;
			$t['code'] = "DW541";
			$t['description'] = "Spain";
			$t['what']="Country Download";
			$t['numareas']=2431;
			$t['status'] = "preparingDownload";
			$t['statuspercen'] = 0;
			$t['date'] = "2009/11/10 12:34:00";
			$res[]=$t;
			$t=array();
			$t['type'] = 1;
			$t['code'] = "DW542";
			$t['description'] = "Germany";
			$t['what']="Country Download";
			$t['numareas']=15;
			$t['status'] = "waitingForDownload";
			$t['statuspercen'] = 0;
			$t['date'] = "2009/11/10 12:34:00";
			$res[]=$t;
			$t=array();
			$t['type'] = 1;
			$t['code'] = "DW543";
			$t['description'] = "France";
			$t['what']="Country Download";
			$t['numareas']=878787;
			$t['status'] = "waitingForUpload";
			$t['statuspercen'] = 0;
			$t['date'] = "2009/11/10 12:34:00";
			$res[]=$t;
			$t=array();
			$t['type'] = 1;
			$t['code'] = "DW5423";
			$t['description'] = "asdasdasd";
			$t['what']="Country Download";
			$t['numareas']=2431;
			$t['status'] = "errorInData";
			$t['statuspercen'] = 0;
			$t['date'] = "2009/11/10 12:34:00";
			$res[]=$t;			
			$t=array();
			$t['type'] = 1;
			$t['code'] = "DW545";
			$t['description'] = "asdasdasd";
			$t['what']="Country Download";
			$t['numareas']=2431;
			$t['status'] = "uploadProcessing";
			$t['statuspercen'] = 0;
			$t['date'] = "2009/11/10 12:34:00";
			$res[]=$t;
			$t=array();
			$t['type'] = 1;
			$t['code'] = "DW546";
			$t['description'] = "Holland";
			$t['what']="Country Download";
			$t['numareas']=2431;
			$t['status'] = "reviewStarted";
			$t['statuspercen'] = 0;
			$t['date'] = "2009/11/10 12:34:00";
			$res[]=$t;
			$t=array();
			$t['type'] = 1;
			$t['code'] = "DW547";
			$t['description'] = "UK";
			$t['what']="Country Download";
			$t['numareas']=2431;
			$t['status'] = "reviewProcessing";
			$t['statuspercen'] = 0;
			$t['date'] = "2009/11/10 12:34:00";
			$res[]=$t;	
			$t=array();
			$t['type'] = 1;
			$t['code'] = "DW548";
			$t['description'] = "US";
			$t['what']="Country Download";
			$t['numareas']=2431;
			$t['status'] = "taskFinished";
			$t['statuspercen'] = 0;
			$t['date'] = "2009/11/10 12:34:00";
			$res[]=$t;																				

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
			$new['status'] = "";
			$deleted[]=$del;
		}
		$resul=array();	
		$resul['results'] = $deleted;
		$resul['total'] = 50;
		return $resul;
	}
	function getTaskNewPas($code,$p) {
		//return array();
		$news=array();
		for($i=9;$i<16;$i++) {
			$new=array();
			$new['id'] = $i;
			$new['name'] = "PA-". $i;
			$new['country'] = "United States";
			$new['status'] = "";
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
			$new['status'] = "";
			$updates[]=$up;
		}		
		$resul['results'] = $updates;
		$resul['total'] = 50;
		return $resul;
	}
	
	function commitChanges($taskCode,$deleted,$added,$removed) {
		
		error_log(print_r($deleted,true));
		error_log(print_r($added,true));
		error_log(print_r($removed,true));
		
		return "great!";
	}
	
	function getPaAttributesComparision($taskCode,$paId) {
		
		
		$originalPa=array();
		
		//mandatory to stay with this naame
		$originalPa['id']="213";
		$originalPa['country']="Spain";
		$originalPa['name']="Donana";
		$originalPa['geom']= "[[[[130.74986,-25.16335],[130.74999,-25.26666],[130.75002,-25.26666],[130.83337,-25.26665],[130.92921,-25.26668],[130.92924,-25.26857],[131.00841,-25.26841],[131.00837,-25.26667],[131.08337,-25.26667],[131.1667,-25.26666],[131.25002,-25.26665],[131.33338,-25.26666],[131.37059,-25.26666],[131.37058,-25.33332],[131.37059,-25.41667],[131.33336,-25.41667],[131.25003,-25.41667],[131.16669,-25.41667],[131.08337,-25.41665],[131.00003,-25.41665],[130.91668,-25.41665],[130.83337,-25.41667],[130.75004,-25.41665],[130.66668,-25.41666],[130.66671,-25.33333],[130.66669,-25.08167],[130.75002,-25.12334],[130.74986,-25.16335]]]]";
		
		//Flexible
		$originalPa['Local name']="asdasd";
		$originalPa['WDPA code']="asd";
		$originalPa['Total area']="213";
		$originalPa['Total area marine']="213123";
		$originalPa['Status date']="213132";
		$originalPa['Valid from']="123132";
		$originalPa['Countries']="123312";
		$originalPa['Designation']="123321";
		$originalPa['IUCN Category']="II";
		$originalPa['Legal status']="qweqwe";
		$originalPa['Legally reclassified']="asdasdasd";
		$originalPa['Legally reduced']="fghfgh";
		$originalPa['Legally extended']="xcvxcv";
		$originalPa['Citation']="fredfs sd f";
		$originalPa['Author']="sdf fff";


		//mandatory to stay with this naame
		$newPa=array();
		$newPa['id']="213";
		$newPa['country']="Spain";
		$newPa['name']="Donana";
		$newPa['geom']= "[[[[130.74986,-25.16335],[130.74999,-25.26666],[130.75002,-25.26666],[130.83337,-25.26665],[130.92921,-25.26668],[130.92924,-25.26857],[131.00841,-25.26841],[131.00837,-25.26667],[131.08337,-25.26667],[131.1667,-25.26666],[131.25002,-25.26665],[131.33338,-25.26666],[131.37059,-25.26666],[131.37058,-25.33332],[131.37059,-25.41667],[131.33336,-25.41667],[131.25003,-25.41667],[131.16669,-25.41667],[131.08337,-25.41665],[131.00003,-25.41665],[130.91668,-25.41665],[130.83337,-25.41667],[130.75004,-25.41665],[130.66668,-25.41666],[130.66671,-25.33333],[130.66669,-25.08167],[130.75002,-25.12334],[130.74986,-25.16335]]]]";		

		//Flexible
		$newPa['Local name']="new local name";
		$newPa['Sergio polla']="pos eso";
		$newPa['WDPA code']="";
		$newPa['Simon']="the best";
		$newPa['Craig']="the looser";
		$newPa['My new attrib']="nuevos datos";
		$newPa['Total area']="";
		$newPa['Total area marine']="SF";
		$newPa['Status date']="213132";
		$newPa['Valid from']="123132";
		$newPa['Countries']="123312";
		$newPa['Designation']="123321";
		$newPa['IUCN Category']="II";
		$newPa['Legal status']="qweqwe";
		$newPa['Legally reclassified']="asdasdasd";
		$newPa['Legally reduced']="fghfgh";
		$newPa['Legally extended']="xcvxcv";
		$newPa['Citation']="fredfs sd f";
		$newPa['Author']="sdf fff";
		
		$res=array();
		$res['originalPa']=$originalPa;
		$res['newPa']=$newPa;
		return $res;
	}
	
	function cancelTask($taskId) {
		
		return null;
	}
	
	
}
?>