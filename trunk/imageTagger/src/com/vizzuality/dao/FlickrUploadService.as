package com.vizzuality.dao
{
	import com.adobe.webapis.flickr.*;
	import com.adobe.webapis.flickr.events.*;
	import com.adobe.webapis.flickr.methodgroups.Upload;
	
	import flash.desktop.*;
	import flash.events.DataEvent;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.Application;
	
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
			
			if (imageData[0].kingdom != null) {
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
			}
			tag += ",taxonomy:binomial=\""+taxon+"\"";
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
		
		
		private function onResult(ev: DataEvent):void {
			var xml: XML = new XML(ev.data);
			var photoID: String = "";
		   	for each( var id:XML in xml..photoid ) {
				 photoID = id;					
			}
			trace(photoID);
			setImageLocation(photoID,"file://" + escape(ev.currentTarget.nativePath.toString()));
		}
		
		
		private function onErrorStatus(ev: IOErrorEvent):void {
			Alert.show("Error at uploading image to Flickr, please try again later or check your Internet connection","Error");
		}
		
		
		private function setImageLocation(photoID:String,path:String):void {
			
			var dao: DataAccessObject = new DataAccessObject();
			var sqlSentence: String = "SELECT lat,lon,zoom FROM photos WHERE path = '"+path+"'";
			dao.openConnection(sqlSentence);
			imageData = dao.dbResult;

    		if (imageData[0].lat != null) {
	    		var flickr: FlickrService = new FlickrService(Application.application.flickrAdminKey);
	    		flickr.secret = Application.application.flickrSecretKey;
	    		flickr.token  = Application.application.token;
	    		flickr.permission = AuthPerm.WRITE;
	    		
	    		flickr.addEventListener(FlickrResultEvent.SET_LOCATION_RESULT,onFlickrSetLocationResult);
	    		flickr.photos.setLocation(photoID,imageData[0].lat,imageData[0].lon,imageData[0].zoom);		
    		}	
    		Application.application.principalView.system.deleteImage(path,1);
    		//use flag if uploading multiple images
    		if (Application.application.uploadingAllPictures) {
    			Application.application.principalView.system.getAllImages();
    		}
			DockIcon(NativeApplication.nativeApplication.icon).bounce();
		}	
		
		private function onFlickrSetLocationResult(ev: FlickrResultEvent):void {
			
		}	
	}
}