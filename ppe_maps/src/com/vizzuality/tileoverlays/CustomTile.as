package com.vizzuality.tileoverlays
{
	
	import com.vizzuality.maps.MapEventDispatcher;
	
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
        private var isOverArea:Boolean=false;
		
		
		public function CustomTile()
		{
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler,false,0,true);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaded,false,0,true);		
			
			this.addEventListener(MouseEvent.MOUSE_MOVE,onMouseOver,false,0,true);	
		}
		
		
		private function ioErrorHandler(event:IOErrorEvent):void {
			event.currentTarget.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);

		}
		
		private function onMouseOver(evt:MouseEvent):void {
			bm = this.loader.content as Bitmap;
			bmd = new BitmapData(256, 256);
			bmd.draw(bm.bitmapData);
			var color:int = bmd.getPixel(evt.localX, evt.localY);
			if (color != 0xFFFFFF) {
				if(!isOverArea) {
					this.buttonMode=true;
					MapEventDispatcher.overAreaEvent(evt.localX,evt.localY);
					isOverArea=true;
				}
			} else {
				if(isOverArea) {
					MapEventDispatcher.overAreaOutEvent();
					this.buttonMode=false;
					isOverArea=false;			
				}
			}
		}
		
		
		private function loaded(event:Event):void {
			event.currentTarget.removeEventListener(Event.COMPLETE, loaded);
			addChild(loader);
			
		}				
		
	}
}