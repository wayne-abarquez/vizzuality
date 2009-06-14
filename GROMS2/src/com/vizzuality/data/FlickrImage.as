package com.vizzuality.data
{
	import com.adobe.serialization.json.JSON;
	import com.vizzuality.view.map.modules.ImagePopup;
	
	import flash.events.MouseEvent;
	
	import mx.controls.Button;
	import mx.controls.Image;
	import mx.core.Application;
	import mx.managers.PopUpManager;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class FlickrImage extends Image
	{
		
		private var url:String='';
		private var title:String='';
		private var ownerId:String='';
		private var ownerName:String='';
		private var imageId:String='';
		
		public function FlickrImage():void {
			this.addEventListener(MouseEvent.CLICK,onClick);
			this.useHandCursor=true;
			this.buttonMode=true;
			this.mouseChildren=false;
		}		

	    
	    public function set query(value:Object):void {
            if (value!=null) {
	            var imageServ:HTTPService = new HTTPService();
	            imageServ.resultFormat = 'text';
	            imageServ.url = "http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=48e37f8de83dcd4366e5f3be69c01c1f&content_type=1&extras=owner_name&per_page=4&format=json&nojsoncallback=1&text=" 
	            	+ escape(value as String);
	            imageServ.addEventListener(ResultEvent.RESULT,onImageSearchResult);
	            imageServ.send();                   
            } else {
            	super.source=null;
            }
        }
	    
	    private function onClick(event:MouseEvent):void {
	    	if (url!='') {
	    		
	    		var tw:ImagePopup=new ImagePopup();
	    		//tw.title=title;
	    		tw.imageSource=url.replace("_s.jpg",".jpg");
	    		tw.copyrightText = "Picture from "+ ownerName + ", at Flickr."
	    		tw.imageUrl="http://www.flickr.com/photos/"+ownerId+"/"+imageId;
	    		
/* 	    		var btClose:Button = new Button();
	    		btClose.setStyle("right",5);
	    		btClose.setStyle("top",5);
	    		btClose.setStyle("styleName","btnDelete");
	    		btClose.addEventListener(MouseEvent.CLICK,function(event:MouseEvent):void {
	    			PopUpManager.removePopUp(tw);
	    		});
	    		tw.addChild(btClose); */
	    		
	    		
	    		
	    		PopUpManager.addPopUp(tw,Application.application.mapCanvas.mapHeader.terrainButton,true);
	    		PopUpManager.centerPopUp(tw);
	    		
	    		
	    	}
	    }
	    
	    
	    public var numImageInResult:Number=0;
	    
		private function onImageSearchResult(event:ResultEvent):void {
			try {

				var rawData:String = String(event.result);
				var jsonObj:Object = JSON.decode(rawData);
				var arr:Array = (jsonObj.photos.photo as Array);	
		
				title=arr[numImageInResult].title;
				ownerId=arr[numImageInResult].owner;
				ownerName=arr[numImageInResult].ownername;
				imageId=arr[numImageInResult].id;
				url="http://farm" + arr[numImageInResult].farm + ".static.flickr.com/" +  arr[numImageInResult].server + "/" +  arr[numImageInResult].id + "_" +  arr[numImageInResult].secret + "_s.jpg";
            	super.source = url; 
			 } catch(e:Error) {
				
			} 
						
		}	    
		
	}
}