package com.vizzuality.view.map.overlays
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	
	import gs.TweenMax;

	public class CustomTile extends Sprite
	{
		public var loader:Loader;
        private var bm:Bitmap;
        private var bmd:BitmapData;
        private var colorizeColor:Number;
		
		
		public function CustomTile(colorizeColor:Number=NaN)
		{
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler,false,0,true);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaded,false,0,true);		
			
			this.colorizeColor=colorizeColor;
			//this.addEventListener(MouseEvent.MOUSE_MOVE,onMouseOver);	
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
				this.buttonMode=true;
				//MapController.gi().enableClick();
				
			} else {
				this.buttonMode=false;
				//MapController.gi().disableClick();
				
			}
		}
		
		
		private function loaded(event:Event):void {
			event.currentTarget.removeEventListener(Event.COMPLETE, loaded);
			
			if(!isNaN(colorizeColor)){
				TweenMax.to(loader, 0, {colorMatrixFilter:{colorize:colorizeColor, amount:1}});
			}
			
			
			addChild(loader);
			
		}				
		
	}
}