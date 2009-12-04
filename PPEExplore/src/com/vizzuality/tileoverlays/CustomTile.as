package com.vizzuality.tileoverlays
{
	
	import com.google.maps.MapMouseEvent;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;

	public class CustomTile extends Sprite
	{
		public var loader:Loader;
		private var geoserverTileLayer:GeoserverTileLayer;
		private var mapIsDragging:Boolean=false;
		
		
		public function CustomTile(_geoserverTileLayer:GeoserverTileLayer,url:String)
		{
			geoserverTileLayer=_geoserverTileLayer;
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler,false,0,true);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaded,false,0,true);		
			loader.load(new URLRequest(url));
			geoserverTileLayer.numRunningRequest++;
		}
		
		
		private function ioErrorHandler(event:IOErrorEvent):void {
/* 			event.currentTarget.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			event.currentTarget.removeEventListener(Event.COMPLETE, loaded); */
			geoserverTileLayer.numRunningRequest--;
            geoserverTileLayer.possiblyFireEvent();

		}
		
		private function onDragging(event:MapMouseEvent):void {
			mapIsDragging=true;	
		}
		private function onEndDragging(event:MapMouseEvent):void {
			mapIsDragging=false;	
		}
		
		private function onMouseOver(evt:MouseEvent):void {
			if(!mapIsDragging) {
				var color:int = (this.loader.content as Bitmap).bitmapData.getPixel(evt.localX, evt.localY);
				if (color != 0) {
					this.buttonMode=true;
					geoserverTileLayer.isOverFeature=true;
				} else {
					this.buttonMode=false;					
					geoserverTileLayer.isOverFeature=false;
				}
			}
		}
		
		
		private function loaded(event:Event):void { 
/* 			event.currentTarget.removeEventListener(Event.COMPLETE, loaded);
			event.currentTarget.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler); */
			
			
			//this.addEventListener(MouseEvent.MOUSE_MOVE,onMouseOver,false,0,true);	
			//geoserverTileLayer.map.addEventListener(MapMouseEvent.DRAG_START,onDragging,false,0,true);
			//geoserverTileLayer.map.addEventListener(MapMouseEvent.DRAG_END,onEndDragging,false,0,true);			
			
			geoserverTileLayer.numRunningRequest--;
            geoserverTileLayer.possiblyFireEvent();
			
			addChild(loader);
			
			
/* 			//test
			var newbd:BitmapData = new BitmapData(256,256,true, 0x00FFFFFF);
			//newbd.fillRect(new Rectangle(0,0,256,256),Color.BLUE);
			var bm:Bitmap = Bitmap(loader.content);
			var bmd:BitmapData = bm.bitmapData
			
			
			//trace(bmd.getPixel32(0,0));
 			//var iCompareValue:uint = 3360927992;// blue transparent
			 
			 var xpos:uint;
			   var ypos:uint;
			   var countColor:uint = 0;
			   var iPixelValue:uint;
			   for (xpos=0; xpos<256; xpos++) {
			    for (ypos=0; ypos<256; ypos++) {
			     iPixelValue = bmd.getPixel32(xpos,ypos);
			     if (iPixelValue == 0) {
			        //Make it black
			        //newbd.setPixel32(xpos,ypos,0x00FFFFFF);
			        newbd.setPixel32(xpos,ypos,0xF0000000);
			     } else {
			     	//Make it transparent
			     	//newbd.setPixel32(xpos,ypos,0xF0000000);
			     	newbd.setPixel32(xpos,ypos,0x00FFFFFF);
			     }
			    }
			   }		
			var newBitmap:Bitmap = new Bitmap(newbd);
			addChild(newBitmap);	 */
			
			
		}				
		
	}
}