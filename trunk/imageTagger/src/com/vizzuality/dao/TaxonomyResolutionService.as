package com.vizzuality.dao
{
	import com.adobe.serialization.json.JSON;
	import com.adobe.webapis.flickr.FlickrService;
	import com.adobe.webapis.flickr.events.*;
	import com.adobe.webapis.flickr.methodgroups.Upload;
	
	import flash.desktop.NativeApplication;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.desktop.*;
	
	import mx.core.Application;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
		
	public class TaxonomyResolutionService
	{
		
		private var name: String;
		private var dir: String;
		
		public function TaxonomyResolutionService() {
		}
		
		
		public function resolveTaxonomy(path:String,scientific:String):void {
			name = scientific;
			dir = path;
			var gbifTaxonomicService: HTTPService = new HTTPService();
			gbifTaxonomicService.method = "get";
			gbifTaxonomicService.resultFormat = "text";
			
			var gbifUrl:String = "http://data.gbif.org/species/classificationSearch?view=json&allowUnconfirmed=false&providerId=2&query="+escape(name);
			gbifTaxonomicService.url=gbifUrl;
			gbifTaxonomicService.addEventListener(ResultEvent.RESULT,onGbifTaxonomicServiceResult);
			gbifTaxonomicService.addEventListener(FaultEvent.FAULT,onGbifTaxonomicServiceFault);
 			gbifTaxonomicService.send();
		}
		
		private function onGbifTaxonomicServiceResult(ev: ResultEvent): void {
 	        var data:String = String(ev.result);
 			var object:Object = JSON.decode(data);
 			var auxArray: Array = new Array();
 			auxArray = object.classificationSearch.classification;
 			jsonData(auxArray);
		}
		
		private function onGbifTaxonomicServiceFault(ev: FaultEvent): void {
		 	var auxArray: Array = new Array();
 			jsonData(auxArray);
		}
		
		private function jsonData(jsonArray: Array):void {
			var count:int = jsonArray.length;
			var taxon: String = "specieslog:status=pending,specieslog:source=organizer,specieslog:scientificName=\""+name+"\"";
						
			if 	(jsonArray!=null) {	
				
				for(var i:int=0;i<count;i++) {
					var str: String;
					str = jsonArray[i].scientificName;
					
					if (str.toLowerCase()!=name.toLowerCase()) {	
						trace(str+": "+ jsonArray[i].rank + "-> "+jsonArray[i].scientificName);
						taxon += ",taxonomy:"+jsonArray[i].rank+"=\""+jsonArray[i].scientificName+"\"";
					} else {
						taxon += ",taxonomy:binomial=\""+name+"\"";
						i=count;
					}
				}			
				
			} 
			sendImageFlickr(taxon);
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
			uploader.upload(imageFile,name,"",tag);
		}
		
		private function onResult(ev: Event):void {
			Application.application.principalView.system.deleteImage(dir);

			var object: Object = ev;
		   	var xml: XML = new XML(object.data);
			
			if (Application.application.tagSequence =="") {
				Application.application.tagSequence += getFlickUploadID(xml);				
			} else {
				Application.application.tagSequence += "," + getFlickUploadID(xml);
			}
			
			
			if (Application.application.uploadingAllPictures) {
				Application.application.principalView.system.getAllImages();
			}
			else {
				Application.application.principalView.system.closeProgressBar();
				DockIcon(NativeApplication.nativeApplication.icon).bounce();
			}
		}
		
		private function onErrorStatus(ev: Event):void {
			Application.application.principalView.system.errorProgressBar();
		}
		
		private function getFlickUploadID(xml: XML):String {
		   	var photoID: String = "";
		   	for each( var id:XML in xml..photoid ) {
				 photoID = id;					
			}
			return photoID;
		}
 
	}
	
}