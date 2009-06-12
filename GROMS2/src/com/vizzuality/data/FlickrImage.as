package com.vizzuality.data
{
	import com.adobe.serialization.json.JSON;
	
	import mx.controls.Image;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class FlickrImage extends Image
	{

	    
	    public function set query(value:Object):void {
            var imageServ:HTTPService = new HTTPService();
            imageServ.resultFormat = 'text';
            imageServ.url = "http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=48e37f8de83dcd4366e5f3be69c01c1f&content_type=1&per_page=4&format=json&nojsoncallback=1&text=" 
            	+ escape(value as String);
            imageServ.addEventListener(ResultEvent.RESULT,onImageSearchResult);
            imageServ.send();       
        }
	    
	    
	    public var numImageInResult:Number=0;
	    
		private function onImageSearchResult(event:ResultEvent):void {
			try {
				var rawData:String = String(event.result);
				var jsonObj:Object = JSON.decode(rawData);
				var arr:Array = (jsonObj.photos.photo as Array);	
		
				var url:String="http://farm" + arr[numImageInResult].farm + ".static.flickr.com/" +  arr[numImageInResult].server + "/" +  arr[numImageInResult].id + "_" +  arr[numImageInResult].secret + "_s.jpg";
            	super.source = url; 
			 } catch(e:Error) {
				
			} 
						
		}	    
		
	}
}