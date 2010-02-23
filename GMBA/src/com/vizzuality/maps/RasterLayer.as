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
	import flash.display.Shader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ShaderEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;

	public class RasterLayer extends TileLayerBase
	{
        private var rasterUrl:String;	
 
 		private var tileRect256:Rectangle=new Rectangle(0,0,256,256);
 		private var centerPoint:Point = new Point(0,0);        
 		private var tilesDic:Dictionary=new Dictionary();
 		private var map:IMap;
        
        [Embed(source="threshold.pbj", mimeType="application/octet-stream")]
        private var DynamicFilteringOfBands:Class;
        private var shader:Shader = new Shader( new DynamicFilteringOfBands() );
        
		
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
 			shader.data.inputImage.input=sourceBitmapData;
  			shader.data.minR.value = [altitudeRange[0]/7889];
 			shader.data.maxR.value = [altitudeRange[1]/7889];
 			shader.data.minG.value = [reliefRange[0]/3397];
 			shader.data.maxG.value = [reliefRange[1]/3397]; 
 			shader.data.minB.value = [0.0];
 			shader.data.maxB.value = [1.0];

			//clear the tile before drawing again
 			targetTile.graphics.clear();
 			
 			targetTile.graphics.beginShaderFill(shader);
 			targetTile.graphics.drawRect(0,0,256,256);
 			targetTile.graphics.endFill();

			
 		}
 		
        
        
        private function onSlidersChange(event:SliderChangeEvent):void {
        	
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