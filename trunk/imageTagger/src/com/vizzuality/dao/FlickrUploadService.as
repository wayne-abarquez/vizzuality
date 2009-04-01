package com.vizzuality.dao
{
	import com.adobe.crypto.MD5;
	import com.adobe.webapis.flickr.*;
	import com.adobe.webapis.flickr.events.*;
	import com.adobe.webapis.flickr.methodgroups.Upload;
	
	import flash.desktop.*;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	
	import mx.collections.ArrayCollection;
	import mx.core.Application;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	public class FlickrUploadService
	{
		
		private var imageData : ArrayCollection;
		private var taxon : String;
		private var dir : String;
		
		
		public function FlickrUploadService() {
			
		}
		
		
		public function resolveTagsFlickr(path:String,name:String):void {
			var tag : String = "";
			taxon = name;
			dir = path;
			var dao: DataAccessObject = new DataAccessObject();
			var sqlSentence: String = "SELECT kingdom,phylum,clas,orde,family,genus,binomial FROM photos WHERE path = '"+path+"'";
			dao.openConnection(sqlSentence);
			imageData = dao.dbResult;
			
			tag = "specieslog:status=pending,specieslog:source=organizer,specieslog:scientificName=\""+taxon+"\"";
			
		    var numRows:int = imageData.length;
			for (var i:int = 0; i < numRows; i++) {
		        for (var columnName:String in imageData[i]) {
		        	if (imageData[i][columnName].toString()!="") {
		        		if (columnName=="orde") {
		        			tag += ",taxonomy:order=\"" + imageData[i][columnName] + "\"";	
		        		} else {
		        			if (columnName=="clas"){
		        				tag += ",taxonomy:class=\"" + imageData[i][columnName] + "\"";	
		        			} else {		        				
					            tag += ",taxonomy:" + columnName + "=\"" + imageData[i][columnName] + "\"";		        		
		        			}
		        		}
		        	} 
		        }
			}
			tag += ",taxonomy:binomial=\""+taxon+"\"";
			trace(tag);
			sendImageFlickr(tag);
		}


		private function sendImageFlickr(tag: String):void {	
			var imageFile:File= new File();
			imageFile.url=dir;
			imageFile.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA,onResult);
			imageFile.addEventListener(IOErrorEvent.NETWORK_ERROR,onErrorStatus);
			imageFile.addEventListener(IOErrorEvent.IO_ERROR,onErrorStatus);
			var service:FlickrService = new FlickrService(Application.application.flickrAdminKey);
			service.secret = Application.application.flickrSecretKey;
			service.token = Application.application.token;
			var uploader:Upload = new Upload(service);
			uploader.upload(imageFile,taxon,"",tag);
		}
		
		
		private function onResult(ev: Event):void {
			var object : Object = ev;
			var xml: XML = new XML(object.data);
			var photoID: String = "";
		   	for each( var id:XML in xml..photoid ) {
				 photoID = id;					
			}
			
			setImageLocation(photoID,"file://" + escape(ev.currentTarget.nativePath.toString()));
			//Application.application.principalView.system.deleteImage(ev.currentTarget.nativePath.toString(),0);
			//DockIcon(NativeApplication.nativeApplication.icon).bounce();
		}
		
		
		private function onErrorStatus(ev: Event):void {
			trace("Uploading Flickr Error");
		}
		
		
		private function setImageLocation(photoID:String,path:String):void {
			//api_sig
			var dao: DataAccessObject = new DataAccessObject();
			var sqlSentence: String = "SELECT lat,lon,zoom FROM photos WHERE path = '"+path+"'";
			dao.openConnection(sqlSentence);
			imageData = dao.dbResult;
			
			var sig : String = Application.application.flickrSecretKey + "api_key" + Application.application.flickrAdminKey + "auth_token"+ 
				Application.application.token  +"lat" + imageData[0].zoom + "lon" + imageData[0].lon + "methodflickr.photos.geo.setLocationphoto_id" + photoID;
				//+ "accuracy" + imageData[0].zoom
    	/* 	var urlService: String = "http://api.flickr.com/services/rest/?method=flickr.photos.geo.setLocation&api_key=" + Application.application.flickrAdminKey + "&photo_id=" + photoID +
    			 "&lat=" + imageData[0].lat + "&lon=" + imageData[0].lon + "&accuracy=" + imageData[0].zoom + "&auth_token=" + Application.application.token + "&api_sig=" + MD5.hash(sig); */
    		
    		var params:Object = new Object();
    		//params.accuracy=imageData[0].zoom;
    		params.method="flickr.photos.geo.setLocation";
    		params.api_key=Application.application.flickrAdminKey
    		params.photo_id=photoID;
    		params.lat=imageData[0].lat;
    		params.lon=imageData[0].lon;
    		params.auth_token=Application.application.token;
    		params.api_sig=MD5.hash(sig);
    		trace(params);
    		
    			 
    		geoFlickrService(params);
		}
		
		private function geoFlickrService(params:Object):void {
			var service:HTTPService = new HTTPService();
			service.url = "http://api.flickr.com/services/rest/";
			service.method = "POST";
			service.addEventListener(FaultEvent.FAULT,onGeoFlickrServiceFault);
			service.addEventListener(ResultEvent.RESULT,onGeoFlickrServiceResult);		
			service.send(params);
		}
		
		private function onGeoFlickrServiceFault(ev: FaultEvent):void {
		}
		
		private function onGeoFlickrServiceResult(ev: ResultEvent):void {
			trace("miracle");
		}
		
	}
}