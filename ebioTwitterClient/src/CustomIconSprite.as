package {
	
	import flash.display.Sprite;
	
	import mx.events.FlexEvent;

	public class CustomIconSprite extends Sprite {
		  
		  [Embed('marker.png')] private var marker:Class;
		  
		  
		  public function CustomIconSprite(name:String="") {
		  	if (name=="") {
			  	addChild(new marker());		  		
		  	} else {
		  		var image: FlickrImage = new FlickrImage();
		  		image.query = name;
		  		image.width = 30;
		  		image.height = 30;
		  		image.addEventListener(FlexEvent.DATA_CHANGE,changeImage);
		  		//addChild(image);
		  	}		  	
		  	cacheAsBitmap = true;
		  } 
		  
		  public function changeImage(ev:FlexEvent):void {
		  	trace("jam");
		  	//addChild(
		  	//cacheAsBitmap = true;
		  }
	}
}