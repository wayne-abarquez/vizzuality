package com.vizzuality.dao
{
	import com.adobe.serialization.json.JSON;
	import com.adobe.webapis.flickr.events.*;
	import com.vizzuality.event.ResultJsonEvent;
	
	import flash.desktop.*;
	
	import mx.collections.ArrayCollection;
	import mx.core.UIComponent;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
		
	public class TaxonomyResolutionService extends UIComponent
	{
		public var result:ArrayCollection;
		private var animal: String;
		
		
		public function TaxonomyResolutionService() {
		}
		
		
		public function resolveTaxonomy(scientific:String):void {
			animal = scientific;
			var gbifTaxonomicService: HTTPService = new HTTPService();
			gbifTaxonomicService.method = "get";
			gbifTaxonomicService.resultFormat = "text";
			
			var gbifUrl:String = "http://data.gbif.org/species/classificationSearch?view=json&allowUnconfirmed=false&providerId=2&query="+escape(animal);
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
			var taxonomyArray: Array= new Array({kingdom:"null",phylum:"null",clas:"null",orde:"null",family:"null",genus:"null",species:"null"});
						
			if 	(jsonArray!=null) {	
				for(var i:int=0;i<count;i++) {
					var str: String;
					str = jsonArray[i].scientificName;
					
					if (str.toLowerCase()!=animal.toLowerCase()) {	
						trace(jsonArray[i].rank + "-> "+jsonArray[i].scientificName);
						//taxon += ",taxonomy:"+jsonArray[i].rank+"=\""+jsonArray[i].scientificName+"\"";
						switch(i) {
						    case 0:
						        taxonomyArray[0].kingdom = jsonArray[i].scientificName;
						        break;
						    case 1:
						        taxonomyArray[0].phylum = jsonArray[i].scientificName;
						        break;
						    case 2:
						        taxonomyArray[0].clas = jsonArray[i].scientificName;
						        break;
						    case 3:
						        taxonomyArray[0].orde = jsonArray[i].scientificName;
						        break;
						    case 4:
						        taxonomyArray[0].family = jsonArray[i].scientificName;
						        break;
						    case 5:
						        taxonomyArray[0].genus = jsonArray[i].scientificName;
						        break;
						    default:
						        taxonomyArray[0].species = jsonArray[i].scientificName;
						        break;
						}
						//taxonomyArray[i] = jsonArray[i].scientificName;
					} else {
						//taxon += ",taxonomy:binomial=\""+name+"\"";
						i=count;
					}
				}			
				
			} 
			var out:ResultJsonEvent = new ResultJsonEvent(ResultJsonEvent.JSON_RESULT);
			out.jsonData = taxonomyArray;
	        dispatchEvent(out);
			//taxonomyArray;
			
		}
		
		/* private function sendImageFlickr(tag: String):void {	
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
			var object: Object = ev;
			Application.application.principalView.system.deleteImage(ev.currentTarget.nativePath.toString(),0);

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
				//Application.application.principalView.system.closeProgressBar();
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
		} */
 
	}
	
}