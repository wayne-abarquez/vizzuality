package
{
	import com.adobe.serialization.json.JSON;
	
	import mx.core.UIComponent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class FlickrImage extends UIComponent
	{

		public function FlickrImage() {
			
		}
		
		public function set query(value:Object):void {
            var imageServ:HTTPService = new HTTPService();
            imageServ.resultFormat = 'text';
            imageServ.url = "http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=48e37f8de83dcd4366e5f3be69c01c1f&content_type=1&per_page=1&format=json&nojsoncallback=1&text=" 
            	+ escape(value as String);
            imageServ.addEventListener(ResultEvent.RESULT,onImageSearchResult);
            imageServ.send();       
        }
            
        private function onImageSearchResult(event:ResultEvent):void {
            var rawData:String = String(event.result);
            var jsonObj:Object = JSON.decode(rawData);
            var arr:Array = (jsonObj.photos.photo as Array);
        	var ev: FlickrImageEvent = new FlickrImageEvent(FlickrImageEvent.IMAGE_URL);
        	var taxon: String;
        	var start: int;
        	var str: String = event.target.url;

        	
        	start=str.indexOf("&text=");
			taxon=str.substring(start+6,str.length);
			taxon=taxon.replace("%20"," ");	
        	
            if (arr.length == 0) {
        		//poner una image de no encontrado
            	ev.url = null;
            	ev.name = taxon;
            	dispatchEvent(ev);       		
            } else {
            	//poner una imagen guay, y cargarla en el diccionario.
            	var url:String="http://farm" + arr[0].farm + ".static.flickr.com/" +  arr[0].server + "/" +  arr[0].id + "_" +  arr[0].secret + "_s.jpg";
            	ev.url = url;
            	ev.name = taxon;
            	dispatchEvent(ev); 
            }                                   
        }          	
	}
}