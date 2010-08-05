package com.vizzuality.components
{
	import com.adobe.serialization.json.JSON;
	
	import mx.controls.Image;
	import mx.core.Application;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class FlickrImage extends Image
	{
		
		private var queryString:String;
		private var idTaxon: String;
		
		[Embed(source="com/vizzuality/assets/loader.swf")]
		private var LoadingIcon:Class;
		
		
		public function FlickrImage() {
			
		}
		
		public function set query(value:Object):void {
        	//super.source = new LoadingIcon();
        	super.source = "";
        	if(value!="") {
        		super.source=value;
        	}
        	
   /*      	
            if (value!=null) {
	        	queryString=value.labelField.toString();
	        	idTaxon=value.id.toString();
	        	
	        	if (Application.application.resolvedImages[idTaxon]!=null && Application.application.resolvedImages[idTaxon]!="") {
	        		//entonces la imagen existe
	        		super.source = Application.application.resolvedImages[idTaxon]; 
	        	}else if(Application.application.resolvedImages[idTaxon]=="") {
	        		//imagen no encontrada
	        		super.source = null;
	        	} else {
		            var imageServ:HTTPService = new HTTPService();
		            imageServ.resultFormat = 'text';
		            imageServ.url = "http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=48e37f8de83dcd4366e5f3be69c01c1f&content_type=1&per_page=1&format=json&nojsoncallback=1&text=" 
		            	+ escape(value.labelField as String);
		            imageServ.addEventListener(ResultEvent.RESULT,onImageSearchResult);
		            imageServ.send();       
	        	}
            } */
        }
            
        private function onImageSearchResult(event:ResultEvent):void {
            var rawData:String = String(event.result);
            var jsonObj:Object = JSON.decode(rawData);
            var arr:Array = (jsonObj.photos.photo as Array);
            if (arr.length == 0) {
        		//poner una image de no encontrado
        		super.source = null;
            	Application.application.resolvedImages[idTaxon]="";
        		
            } else {
            	//poner una imagen guay, y cargarla en el diccionario.
            	var url:String="http://farm" + arr[0].farm + ".static.flickr.com/" +  arr[0].server + "/" +  arr[0].id + "_" +  arr[0].secret + "_s.jpg";
            	super.source = url;   
            	Application.application.resolvedImages[idTaxon]=url;
            }                                   
        }          	
	}
}