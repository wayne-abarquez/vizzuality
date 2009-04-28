package com.vizzuality.view.map
{
	import com.google.maps.Map;
	import com.google.maps.MapType;
	import com.google.maps.MapZoomEvent;
	import com.vizzuality.data.WdpaLayer;
	import com.vizzuality.view.AppStates;
	import com.vizzuality.view.map.overlays.CustomTileLayer;
	import com.vizzuality.view.map.overlays.CustomTileLayerOverlay;
	
	import flash.display.Sprite;
	import flash.filters.ColorMatrixFilter;
	import flash.utils.Dictionary;
	
	import mx.binding.utils.BindingUtils;
	import mx.core.Application;
	
	
	public final class MapController
	{
		
		private static var instance:MapController;
		private var map:Map;
		private var mapCanvas:MapCanvas;
		public var ctl:CustomTileLayer;

		private var aSprite:Sprite;
		private var bSprite:Sprite;   			
		
		private var cacheLayers:Dictionary = new Dictionary();
		private var activeLayers:Dictionary = new Dictionary();
		
		public function MapController(map:Map,mapCanvas:MapCanvas)
		{
			this.map=map;
			this.mapCanvas=mapCanvas;
			
			instance = this;		
			init();
		}
		
		public static function gi():MapController {
			return instance;
		}
		
		private function init():void {
		    map.setMapType(MapType.PHYSICAL_MAP_TYPE);
		    map.setZoom(3);
		    //map.disableDragging();
		    map.addEventListener(MapZoomEvent.ZOOM_CHANGED, onMapZoomChanged);

			Application.application.onMapReady();				
			
		}
		
		private function onMapZoomChanged(event:MapZoomEvent):void {
			mapCanvas.mapHeader.zoomSlider.value = map.getZoom();
		}		
		
		
		
		public function setMapLoading():void {
			if (bSprite==null) {
				aSprite = map.getChildAt(1) as Sprite;
				bSprite = aSprite.getChildAt(0) as Sprite;
			}
			bSprite.filters = [new ColorMatrixFilter([0.13238779460000002,1.0025112879999998,0.0490316186,0,-43.75271063919999,0.0749877946,1.230711288,0.0490316186,0,-78.25571063919999,0.0749877946,1.0025112879999998,0.15963161860000002,0,-56.89591063919999,0,0,0,1,0])];
			mapCanvas.loadingBar.visible=true;
		
		}
		
		public function setMapLoaded():void {
			bSprite.filters = null;
			mapCanvas.loadingBar.visible=false;
		}		
		
		public function updateTileLayers(layers:Array):void {
			
			//first we remove from the map the layers that are active
			//that should not longer be active
			var searchForLayer:Function = function(search:String):Boolean {
				for (var i:Number=0; i<layers.length;i++) {
					if(search == layers[i])
						return true;
				}
				return false;
			}
			
			for (var layerName:String in activeLayers) {
				if (!searchForLayer(layerName)) {
					trace("remove " +layerName);
					map.removeOverlay(activeLayers[layerName]);
					activeLayers[layerName]=null;
					delete activeLayers[layerName];
				}
			}
			
			
			//We create all the layer, or add all those CTLO 
			for each(var la:String in layers) {
				//trace(la);
				if(cacheLayers[la]==null) {
					var ctlo:CustomTileLayerOverlay= createTileLayer(la);
					activeLayers[la] = ctlo;
					cacheLayers[la]=ctlo;
					trace("add " +la);
					map.addOverlay(activeLayers[la]);
				} else {
					if(activeLayers[la]==null) {
						activeLayers[la]=cacheLayers[la];
						trace("add " +la);
						map.addOverlay(activeLayers[la]);
					}
				}
			}
			
			//we set it into the state
			AppStates.gi().visibleLayers[AppStates.gi().topState]=layers;
		}
		
		public function createTileLayer(layer:String):CustomTileLayerOverlay {
			
			ctl = new CustomTileLayer(WdpaLayer.STATIC_LAYERS[WdpaLayer.ALL],WdpaLayer.DYNAMIC_LAYERS[WdpaLayer.ALL],8);		
			var ctlo:CustomTileLayerOverlay = new CustomTileLayerOverlay(ctl);
			ctl.ctlo = ctlo;
			
			BindingUtils.bindProperty(mapCanvas.temp,"text",ctlo,"numRunningRequest");
			
			return ctlo;
		}
		

	}
}