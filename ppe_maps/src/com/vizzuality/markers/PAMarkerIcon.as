package com.vizzuality.markers{
	
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	public class PAMarkerIcon extends Sprite {	
		
		private var imageLoader:Loader = new Loader();
		private var imageMask:Sprite = new Sprite();
		
        public function PAMarkerIcon(imageUrl:String) {
        	this.buttonMode = true;
			this.useHandCursor = true;
			this.mouseChildren = false;

			imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, displayImg);
			
			var fileRequest:URLRequest = new URLRequest(imageUrl);
			imageLoader.load(fileRequest);

            var background:Shape = new Shape();
            background.graphics.beginFill(0xFFFFFF,1);
            background.graphics.drawCircle(15,8,28);
            background.graphics.endFill();
            addChild(background);
            
            var image:Shape = new Shape();
            image.graphics.beginFill(0x000000,0.6);
            image.graphics.drawCircle(15,8,25);
            image.graphics.endFill();
            addChild(image);
                
        }
  		
  		private function displayImg(e:Event):void{
  			
  			imageMask.graphics.beginFill(0x330000,1);
  			imageMask.graphics.drawCircle(15,8,25);
  			imageMask.graphics.endFill();
  			
  			imageLoader.x = -10;
  			imageLoader.y = -16;
  			addChild(imageMask);
  			imageLoader.mask = imageMask; 
  			addChildAt(imageLoader,2);
  		}
  		
     }
      
 }
