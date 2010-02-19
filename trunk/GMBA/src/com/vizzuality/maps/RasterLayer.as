package com.vizzuality.maps
{
	import com.google.maps.Copyright;
	import com.google.maps.CopyrightCollection;
	import com.google.maps.LatLng;
	import com.google.maps.LatLngBounds;
	import com.google.maps.TileLayerBase;
	import com.vizzuality.events.MyEventDispatcher;
	import com.vizzuality.events.SliderChangeEvent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;

	public class RasterLayer extends TileLayerBase
	{
        private var customTile:CustomTile;	
        private var rasterUrl:String;	
    	private var tileVisible:Array=[];
    	private var tileSources:Array=[];
    	private var tilesDic:Dictionary = new Dictionary(true);
    	private var numTilesLoaded:uint=0;
        private var zoomLevel:Number;
		
		public function RasterLayer(_rasterUrl:String) {
			
			rasterUrl=_rasterUrl;	
            var copyrightCollection:CopyrightCollection = new CopyrightCollection();
            copyrightCollection.addCopyright(new Copyright("ennefox", new LatLngBounds(new LatLng(-180, 90), new LatLng(180, -90)), 21,"ennefox"));            
            
            
            MyEventDispatcher.addEventListener(SliderChangeEvent.SLIDER_CHANGED,onSlidersChange,false,0,true);
            
            super(copyrightCollection, 0, 6,0.7);
		}
		
		public override function loadTile(tile:Point, zoom:Number):DisplayObject {
            if (!isNaN(tile.x) && !isNaN(tile.y) && zoom >= 0) {
                var tileUrl:String = rasterUrl;
                tileUrl = tileUrl.replace("|X|",tile.x);    
                tileUrl = tileUrl.replace("|Y|",tile.y);    
                tileUrl = tileUrl.replace("|Z|",zoom); 

/*                 customTile = new CustomTile();
                customTile.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler,false,0,true);
                customTile.loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadTileComplete);
                customTile.tileX = tile.x;
                customTile.tileY = tile.y;
                customTile.tileZ = zoom; */
                
				var tileLoader:Loader = new Loader();
                tileSources.push(tileLoader);     
                numTilesLoaded++; 
				tileLoader.load(new URLRequest(tileUrl)); 
				var tileSprite:Sprite=new Sprite();
				tileVisible.push(tileSprite);    
				tilesDic[tileLoader]=tileSprite;   
                             
                return tileSprite;    
            }
            
            return null;			
		}
		
	    private function loadTileComplete(event:Event):void {
	    	var ct:CustomTile=event.target.loader.parent;
	        

	    }		
		
		
        private function ioErrorHandler(event:IOErrorEvent):void {
            event.currentTarget.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
        }
        
 		private function applyThresholdToTile(sourceTile:Loader,targetTile:Sprite,altitudeRange:Array,reliefRange:Array,vegtypes:Array):void {
 			var sourceBitmapData:BitmapData = (sourceTile.content as Bitmap).bitmapData;
 			var redChannel:BitmapData = new BitmapData(256,256);
 			redChannel.copyChannel(sourceBitmapData,new Rectangle(0,0,256,256),new Point(0,0),BitmapDataChannel.RED,BitmapDataChannel.RED);
 			
 			//remove all childs
 			while(targetTile.numChildren > 0){
				targetTile.removeChildAt(0);
			}
			
			targetTile.addChild(new Bitmap(redChannel));
			
			
 		}
        
        
        private function onSlidersChange(event:SliderChangeEvent):void {
        	trace(event.altitudeRange.toString() +"  "+event.reliefRange.toString() + "   " + event.vegtypes.toString());
        	
        	//apply to all tiles in 
         	for(var tid:uint =0;tid<=numTilesLoaded;tid++) {
        		applyThresholdToTile(tileSources[tid],tilesDic[tileSources[tid]],event.altitudeRange,event.reliefRange,event.vegtypes);        		
        	}
        }
        
        
		
	}
}