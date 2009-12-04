package com.vizzuality.layers
{
	import com.google.maps.Color;
	import com.google.maps.Copyright;
	import com.google.maps.CopyrightCollection;
	import com.google.maps.LatLng;
	import com.google.maps.LatLngBounds;
	import com.google.maps.TileLayerBase;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	
	import mx.controls.sliderClasses.Slider;
	import mx.events.SliderEvent;

	public class RasterSliderLayer extends TileLayerBase
	{
        private var customTile:CustomTile;	
        private var rasterUrl:String;	
        private var slider:Slider;
    	public var tileArr:Array;
        private var zoomLevel:Number;
		
		public function RasterSliderLayer(_rasterUrl:String,_slider:Slider) {
			
			slider=_slider;	
			rasterUrl=_rasterUrl;	
            var copyrightCollection:CopyrightCollection = new CopyrightCollection();
            copyrightCollection.addCopyright(new Copyright("ennefox", new LatLngBounds(new LatLng(-180, 90), new LatLng(180, -90)), 21,"ennefox"));            
            
      		tileArr=[];
      		slider.addEventListener(SliderEvent.CHANGE,applyThreshold); //wire the change event of the slider to the applyThreshold method
            
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

            threshold(slider.value,ct.offScreenBitmapData,ct.onScreenBitmapData);            
	    }		
		
		
        private function ioErrorHandler(event:IOErrorEvent):void {
            event.currentTarget.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
        }
        
	    public function applyThreshold(event:SliderEvent):void {
	        for each (var ct:CustomTile in tileArr) {
	            threshold(slider.value,ct.offScreenBitmapData,ct.onScreenBitmapData);
	        }
	    }   
	    
	    private function threshold(_threshold:uint,offScreenBitmap:BitmapData,onScreenBitmap:BitmapData):void {
	        if (!onScreenBitmap) {
	        	return;
	        }
	        onScreenBitmap.fillRect(new Rectangle(0, 0, 256,256),0x00ffffff);
	        
	        onScreenBitmap.threshold(offScreenBitmap,new Rectangle(0, 0, 256,256), new Point(0, 0),"<",_threshold,0xddD33432,0x000000ff,false); //if we want to see the DEM then the copysource parameter is true
	        var _filter:BlurFilter = new BlurFilter(1,1);
	        onScreenBitmap.applyFilter(onScreenBitmap,new Rectangle(0, 0, 256,256),new Point(0, 0),_filter);
	    }
	    		
		
	}
}