package com.vizzuality.maps
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;

	public class CustomTile extends Sprite
	{
		public var loader:Loader;
        private var bm:Bitmap;
        private var bmd:BitmapData;
        public var onScreenBitmapData:BitmapData;
        public var offScreenBitmapData:BitmapData;
        public var tileX:Number;
        public var tileY:Number;
        public var tileZ:Number;
        
		
		
		public function CustomTile()
		{
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler,false,0,true);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaded,false,0,true);		
			
			//this.addEventListener(MouseEvent.MOUSE_MOVE,onMouseOver);	
		}
		
		
		private function ioErrorHandler(event:IOErrorEvent):void {
			event.currentTarget.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);

		}
		
		
		private function loaded(event:Event):void {
			event.currentTarget.removeEventListener(Event.COMPLETE, loaded);
			addChild(loader);
			
		}				
		
	}
}