package com.vizzuality.layers
{
	import com.google.maps.Copyright;
	import com.google.maps.CopyrightCollection;
	import com.google.maps.LatLng;
	import com.google.maps.LatLngBounds;
	import com.google.maps.PaneId;
	import com.google.maps.TileLayerBase;
	import com.google.maps.overlays.Marker;
	import com.vizzuality.utils.GmapUtils;
	
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

	public class RasterSliderLayer extends TileLayerBase
	{
        private var customTile:CustomTile;	
        private var rasterUrl:String;	
        private var slider:HSlider;
    	public var tileArr:Array;
        private var zoomLevel:Number;
		
		public function RasterSliderLayer(_rasterUrl:String,_slider:HSlider) {
			
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

            threshold(slider.values,ct);            
	    }		
		
		
        private function ioErrorHandler(event:IOErrorEvent):void {
            event.currentTarget.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
        }
        
	    public function applyThreshold(event:SliderEvent):void {
	        for each (var ct:CustomTile in tileArr) {
	            threshold(slider.values,ct);
	        }
	    }   
	    
	    
	    private function threshold(_threshold:Array,ct:CustomTile):void {
	        if (!ct.onScreenBitmapData) {
	        	return;
	        }
	        ct.onScreenBitmapData.fillRect(new Rectangle(0, 0, 256,256),0x00ffffff);
	        
	        var val1:Number;
	        var val2:Number;
	        if (slider.thumbCount==2) {
	        	val1 = slider.values[0];
	        	val2 = slider.values[1];
	        } else {
	        	val2 = slider.value;
	        }
	        
/* 	        if(val1>0) {
		        onScreenBitmap.threshold(offScreenBitmap,new Rectangle(0, 0, 256,256), new Point(0, 0),">",val1,0x000000ff,0x000000ff,false); //if we want to see the DEM then the copysource parameter is true        	
		        onScreenBitmap.threshold(offScreenBitmap,new Rectangle(0, 0, 256,256), new Point(0, 0),"<",val2,0xddD33432,0x000000ff,false); //if we want to see the DEM then the copysource parameter is true
	        } else {
		        onScreenBitmap.threshold(offScreenBitmap,new Rectangle(0, 0, 256,256), new Point(0, 0),"<",val2,0xddD33432,0x000000ff,false); //if we want to see the DEM then the copysource parameter is true	        	
	        } */
	        ct.onScreenBitmapData.threshold(ct.offScreenBitmapData,new Rectangle(0, 0, 256,256), new Point(0, 0),"<",val2,0xddD33432,0x000000ff,false); //if we want to see the DEM then the copysource parameter is true	        	
	        
	        //getHighlightedAreas(ct);
	        
	        //var _filter:BlurFilter = new BlurFilter(1,1);
	        //onScreenBitmap.applyFilter(onScreenBitmap,new Rectangle(0, 0, 256,256),new Point(0, 0),_filter);
	    }
	    		
	    private function getHighlightedAreas(ct:CustomTile):void {
	    	Application.application.map.getPaneManager().getPaneById(PaneId.PANE_MARKER).clear();
	    	//var redBounds:Rectangle = onScreenBitmap.getColorBoundsRect(0, 3721606194, true);
	    	for (var bx:uint=0;bx<4;bx++){
		    	for (var by:uint=0;by<4;by++){
		    		if (ct.onScreenBitmapData.getPixel32(bx*64,by*64) == 0xddD33432) {
			    		trace("flooded: "+(ct.tileX)+"-"+(ct.tileY));
			    		var pos:LatLng = GmapUtils.getTileLatLong(ct.tileX,ct.tileY,ct.tileZ,bx*64,by*64);
			    		Application.application.map.addOverlay(
			    			new Marker(pos));
			    		trace(pos);
		    		}
		    	}
	    	}
	    }
		
	}
}