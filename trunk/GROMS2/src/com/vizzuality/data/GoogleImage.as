package com.vizzuality.data
{
	import com.adobe.serialization.json.JSON;
	
	import mx.controls.Image;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class GoogleImage extends Image
	{
		
		public function GoogleImage()
		{
			super();
		}
		
		[Bindable("sourceChanged")]	
	    /**
	     *  @private
	     */
	    public function set query(value:Object):void
	    {
			var imageServ:HTTPService = new HTTPService();
	 		imageServ.resultFormat = 'text';
	 		imageServ.url = 'http://ajax.googleapis.com/ajax/services/search/images?v=1.0';
	 		imageServ.addEventListener(ResultEvent.RESULT,onImageSearchResult);
	 		imageServ.request.q = value.toString();
	 		imageServ.send();
	    }
	    
	    public var numImageInResult:Number=0;
	    
		private function onImageSearchResult(event:ResultEvent):void {
			try {
				var rawData:String = String(event.result);
				var jsonObj:Object = JSON.decode(rawData);
				var arr:Array = (jsonObj.responseData.results as Array);	
				super.source = arr[numImageInResult].tbUrl;
			} catch(e:Error) {
				
			}
						
		}	    
		
	}
}