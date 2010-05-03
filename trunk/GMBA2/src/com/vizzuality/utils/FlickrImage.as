package com.vizzuality.utils
{
	import com.adobe.serialization.json.JSON;
	
	import mx.controls.Image;
	import mx.core.Application;
	import mx.rpc.events.ResultEvent;

	public class FlickrImage extends Image
	{
		private var queryString:String;
		
		[Embed(source="assets/default.jpg")]
		private var img:Class;
		
		public function FlickrImage() {
			
		}
		
		public function set query(value:Object):void {
        	//super.source = "com/vizzuality/assets/default.jpg";
        	super.source=new img();
        	
        	if(value!="") {
        		super.source = value; 
        	}
        	
/*             if (value!=null && value.toString()!="") {
	        	queryString=value.toString();
	        	
	        	if (Application.application.resolvedImages[queryString]!=null && Application.application.resolvedImages[queryString]!="") {
	        		//entonces la imagen existe
	        		super.source = Application.application.resolvedImages[queryString]; 
	        	}else if(Application.application.resolvedImages[queryString]=="") {
	        		//imagen no encontrada
	        		super.source = "com/vizzuality/assets/default.jpg";
	        	} else {
		            var imageServ:HTTPService = new HTTPService();
		            imageServ.resultFormat = 'text';
		            imageServ.url = "http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=48e37f8de83dcd4366e5f3be69c01c1f&content_type=1&per_page=1&format=json&nojsoncallback=1&text=" 
		            	+ escape(value as String);
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
        		super.source = "com/vizzuality/assets/default.jpg";
            	Application.application.resolvedImages[queryString]="";
        		
            } else {
            	var url:String="http://farm" + arr[0].farm + ".static.flickr.com/" +  arr[0].server + "/" +  arr[0].id + "_" +  arr[0].secret + "_s.jpg";
            	super.source = url;   
            	Application.application.resolvedImages[queryString]=url;
            }                                   
        }          	
	}
}