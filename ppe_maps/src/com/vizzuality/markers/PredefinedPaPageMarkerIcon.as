package com.vizzuality.markers {
	
	
	import com.google.maps.Color;
	import com.vizzuality.utils.StringUtils;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class PredefinedPaPageMarkerIcon extends Sprite {	

		private var imageLoader:Loader = new Loader();
		private var imageMask:Sprite = new Sprite();
		private var imageMaskOver:Sprite = new Sprite();
		private var paData:Object;
		
		
		
  		[Embed(source="/assets/backgroundMarker.png")]
		public var overImage:Class;
		
		[Embed(source="/assets/bigMarker.png")]
		public var big:Class;
		
		
        public function PredefinedPaPageMarkerIcon(url:String) {

			super();    
			this.buttonMode = true;
			this.useHandCursor = true;
			this.mouseChildren = false;
			

			imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, displayImg);
			
			var fileRequest:URLRequest = new URLRequest(url);
			imageLoader.load(fileRequest);
			
			var background:Bitmap;
			var triangleShape:Shape = new Shape();
		 	
			var shadow: Shape = new Shape();
			var triangleShadow: Shape = new Shape();
			
			background = new big();
			addChild(background);
			

        }

  		private function displayImg(e:Event):void{
   			imageMask.graphics.beginFill(0x330000,1);
   			imageMask.graphics.drawRect(2,2,49,49);
  			imageMask.graphics.endFill();

			imageLoader.width = 50; imageLoader.height = 50; 
            imageLoader.x = 8;
			imageLoader.y = 8;
			imageMask.x = 8;
			imageMask.y = 8;

  			addChild(imageMask);
  			imageLoader.mask = imageMask; 
  			addChild(imageLoader); 
  		}
      }
 }