package com.vizzuality.maps
{
	import com.google.maps.Copyright;
	import com.google.maps.CopyrightCollection;
	import com.google.maps.LatLng;
	import com.google.maps.LatLngBounds;
	import com.google.maps.MapZoomEvent;
	import com.google.maps.TileLayerBase;
	import com.google.maps.interfaces.IMap;
	import com.vizzuality.events.MyEventDispatcher;
	import com.vizzuality.events.SliderChangeEvent;
	import com.vizzuality.model.StateSingletonModel;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
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
        private var rasterUrl:String;	
        public static const MASK_R:uint = 0xFF0000;
        public static const MASK_G:uint = 0x00FF00;
        public static const MASK_B:uint = 0x0000FF;
 
 		private var tileRect256:Rectangle=new Rectangle(0,0,256,256);
 		private var centerPoint:Point = new Point(0,0);        
 		private var tilesDic:Dictionary=new Dictionary();
 		private var map:IMap;
        
		
		public function RasterLayer(_rasterUrl:String,_map:IMap) {
			
			rasterUrl=_rasterUrl;	
			map=_map;
            var copyrightCollection:CopyrightCollection = new CopyrightCollection();
            copyrightCollection.addCopyright(new Copyright("ennefox", new LatLngBounds(new LatLng(-180, 90), new LatLng(180, -90)), 21,"ennefox"));            
            
            
            map.addEventListener(MapZoomEvent.CONTINUOUS_ZOOM_START,onZoomStart);
            
            
            MyEventDispatcher.addEventListener(SliderChangeEvent.SLIDER_CHANGED,onSlidersChange,false,0,true);
            
            super(copyrightCollection, 0, 6,0.7);
		}
		
		public override function loadTile(tile:Point, zoom:Number):DisplayObject {
            if (!isNaN(tile.x) && !isNaN(tile.y) && zoom >= 0) {
                var tileUrl:String = rasterUrl;
                tileUrl = tileUrl.replace("|X|",tile.x);    
                tileUrl = tileUrl.replace("|Y|",tile.y);    
                tileUrl = tileUrl.replace("|Z|",zoom); 
                
				var tileLoader:Loader = new Loader();
				tileLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadedComplete,false,0,true);
				tileLoader.load(new URLRequest(tileUrl)); 
				var tileSprite:Sprite=new Sprite();
				//tileSprite.blendMode = BlendMode.NORMAL;
				tilesDic[tileLoader]=tileSprite;   
                             
                return tileSprite;    
            }
            
            return null;			
		}
		
		private function onLoadedComplete(event:Event):void {
			
			var gi:StateSingletonModel=StateSingletonModel.gi();
			
			applyThresholdToTile(
				event.currentTarget.loader as Loader,
				tilesDic[event.currentTarget.loader] as Sprite,
				gi.altitudeRange,
				gi.reliefRange,
				gi.vegtypeRange);
				
		}
		
		
		
        private function ioErrorHandler(event:IOErrorEvent):void {
            event.currentTarget.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
        }
        
 		private function applyThresholdToTile(sourceTile:Loader,targetTile:Sprite,altitudeRange:Array,reliefRange:Array,vegtypes:Array):void {
 			var sourceBitmapData:BitmapData = (sourceTile.content as Bitmap).bitmapData;
 			//Aplicar el threshold aal sourceBitmapData en un nuevo Bitmap
 
 			var bitMapDataRed:BitmapData = new BitmapData(256,256,true, 0x00FFFFFF);
        	//var bitMapDataGreen:BitmapData = new BitmapData(256,256,true, 0x00FFFFFF);
        	//var bitMapDataBlue:BitmapData = new BitmapData(256,256,true, 0x00FFFFFF);			
 			
 			//bitMapRed.copyChannel(sourceBitmapData,tileRect256,centerPoint,BitmapDataChannel.RED,BitmapDataChannel.RED);
			//bitMapDataGreen.copyChannel(sourceBitmapData,tileRect256,centerPoint,BitmapDataChannel.GREEN,BitmapDataChannel.GREEN);
			//bitMapBlue.copyChannel(sourceBitmapData,tileRect256,centerPoint,BitmapDataChannel.BLUE,BitmapDataChannel.BLUE); 	
 			
 			var altitudeMin:Number =altitudeRange[0];
 			if (altitudeMin<=1) altitudeMin=31;
 			var altitudeMax:Number =altitudeRange[1];
 			if (altitudeMax==7889) altitudeMax=7869;
 			
 			var reliefMin:Number =reliefRange[0];
 			if (reliefMin<=1) reliefMin=15;
 			var reliefMax:Number =reliefRange[1];
 			if (reliefMax==3397) reliefMax=3383;
 			
 			
 			bitMapDataRed.threshold(sourceBitmapData, tileRect256, centerPoint, "<", ((altitudeMin*256/7889)/256)*0xFFFFFF, 0xFF000000, MASK_R, false);
 			bitMapDataRed.threshold(sourceBitmapData, tileRect256, centerPoint, ">", ((altitudeMax*256/7889)/256)*0xFFFFFF, 0xFF000000, MASK_R, false);

 			//bitMapDataGreen.threshold(sourceBitmapData, tileRect256, centerPoint, "<", ((reliefMax*256/3397)/256)*0xFFFFFF, 0xFF000000, MASK_G, false);
 			//bitMapDataGreen.threshold(sourceBitmapData, tileRect256, centerPoint, ">", ((reliefMin*256/3397)/256)*0xFFFFFF, 0xFF000000, MASK_G, false);
 			
 			var outputRedBitmap:Bitmap = new Bitmap(bitMapDataRed);
 			//var outputGreenBitmap:Bitmap = new Bitmap(bitMapDataGreen);
 			//var outputGreenBitmap:Bitmap;
 			
 			//-------
 			
 			//remove all childs
 			while(targetTile.numChildren > 0){
				targetTile.removeChildAt(0);
			}
			
			targetTile.addChild(outputRedBitmap);
			//targetTile.addChild(outputGreenBitmap);
			//targetTile.addChild(outputGreenBitmap);
			
			
 		}
        
        
        private function onSlidersChange(event:SliderChangeEvent):void {
        	//trace(event.altitudeRange.toString() +"  "+event.reliefRange.toString() + "   " + event.vegtypes.toString());
        	
        	//apply to all tiles in 
        	for (var tileSource:Object in tilesDic) {
        		applyThresholdToTile(tileSource as Loader,tilesDic[tileSource],event.altitudeRange,event.reliefRange,event.vegtypes);        		
			}
        }
        
        
        private function onZoomStart(event:MapZoomEvent):void {
        	tilesDic=new Dictionary();
        }
        
        
		
	}
}