package com.vizzuality.maps
{
	import com.google.maps.Copyright;
	import com.google.maps.CopyrightCollection;
	import com.google.maps.LatLng;
	import com.google.maps.LatLngBounds;
	import com.google.maps.PaneId;
	import com.google.maps.TileLayerBase;
	import com.google.maps.overlays.Marker;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	
	import mx.controls.HSlider;
	import mx.core.Application;
	import mx.events.SliderEvent;

	public class RasterLayer extends TileLayerBase
	{
        private var customTile:CustomTile;	
        private var rasterUrl:String;	
        private var slider:HSlider;
    	public var tileArr:Array;
        private var zoomLevel:Number;
		
		public function RasterLayer(_rasterUrl:String,loadedTiles:Array,_slider:HSlider=null) {
			
			slider=_slider;	
			rasterUrl=_rasterUrl;	
            var copyrightCollection:CopyrightCollection = new CopyrightCollection();
            copyrightCollection.addCopyright(new Copyright("ennefox", new LatLngBounds(new LatLng(-180, 90), new LatLng(180, -90)), 21,"ennefox"));            
            
      		tileArr=loadedTiles;
      		//slider.addEventListener(SliderEvent.CHANGE,applyThreshold); //wire the change event of the slider to the applyThreshold method
            
            super(copyrightCollection, 0, 23,0.7);
		}
		
		public override function loadTile(tile:Point, zoom:Number):DisplayObject {
            if (!isNaN(tile.x) && !isNaN(tile.y) && zoom >= 0) {
                customTile = new CustomTile();
                customTile.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler,false,0,true);
                customTile.loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadTileComplete);
                
                var tileUrl:String = rasterUrl;
                tileUrl = tileUrl.replace("|X|",tile.x);    
                tileUrl = tileUrl.replace("|Y|",tile.y);    
                tileUrl = tileUrl.replace("|Z|",zoom); 
                
                tileArr.push(customTile);      
                customTile.tileX = tile.x;
                customTile.tileY = tile.y;
                customTile.tileZ = zoom;
                             
                customTile.loader.load(new URLRequest(tileUrl));
                return customTile;    
            }
            
            return null;			
		}
		
	    private function loadTileComplete(event:Event):void {
	    	var ct:CustomTile=event.target.loader.parent;
	        
            ct.onScreenBitmapData=(ct.loader.content as Bitmap).bitmapData; //get a pointer to the onscreen bitmap data
            ct.onScreenBitmapData.threshold(ct.onScreenBitmapData,new Rectangle(0, 0, 256,256), new Point(0, 0),"==",0x00000000,0xffffffff); //make the background values transparent if specified
            ct.offScreenBitmapData=ct.onScreenBitmapData.clone(); //copy the onscreen bitmapdata to an offscreen cache

	    }		
		
		
        private function ioErrorHandler(event:IOErrorEvent):void {
            event.currentTarget.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
        }
        
		
	}
}