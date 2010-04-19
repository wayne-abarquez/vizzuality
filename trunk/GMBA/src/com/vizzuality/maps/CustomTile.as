package com.vizzuality.maps
{
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;

	public class CustomTile extends Sprite
	{
		public var loader:Loader;
		private var maskRectagle:Sprite;
		
		public function CustomTile()
		{
			maskRectagle = new Sprite();
			maskRectagle.graphics.beginFill(0x000000);
			maskRectagle.graphics.drawRect(0,0,256,256);
			maskRectagle.graphics.endFill();
			this.addChild(maskRectagle);
			
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler,false,0,true);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaded,false,0,true);
			
			
			//this.addEventListener(MouseEvent.MOUSE_MOVE,onMouseOver);	
		}
		
		
		private function ioErrorHandler(event:IOErrorEvent):void {
			event.currentTarget.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);

		}
		
		
		private function loaded(event:Event):void {
			this.removeChild(maskRectagle);
			event.currentTarget.removeEventListener(Event.COMPLETE, loaded);
			addChild(loader);
			
		}				
		
	}
}