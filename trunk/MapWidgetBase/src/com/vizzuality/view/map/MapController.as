package com.vizzuality.view.map
{
	import com.google.maps.LatLng;
	import com.google.maps.LatLngBounds;
	import com.google.maps.Map;
	import com.google.maps.MapEvent;
	import com.google.maps.MapMouseEvent;
	import com.google.maps.MapMoveEvent;
	import com.google.maps.MapType;
	import com.google.maps.MapZoomEvent;
	import com.vizzuality.data.MapPosition;
	import com.vizzuality.data.WdpaLayer;
	import com.vizzuality.services.DataServiceEvent;
	import com.vizzuality.services.DataServices;
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
		public var map:Map;
		private var mapCanvas:MapCanvas;
		public var ctl:CustomTileLayer;

		private var aSprite:Sprite;
		private var bSprite:Sprite;   	
		private var filter:ColorMatrixFilter = new ColorMatrixFilter([0.13238779460000002,1.0025112879999998,0.0490316186,0,-43.75271063919999,0.0749877946,1.230711288,0.0490316186,0,-78.25571063919999,0.0749877946,1.0025112879999998,0.15963161860000002,0,-56.89591063919999,0,0,0,1,0]);
		private var emptyFilter:ColorMatrixFilter = new ColorMatrixFilter();		
		
		private var cacheLayers:Dictionary = new Dictionary();
		private var activeLayers:Dictionary = new Dictionary();
		
		private var previousZoomLevel:Number;
		private var previousCenter:LatLng;
		
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
		    map.setCenter(new LatLng(30,0),2,MapType.PHYSICAL_MAP_TYPE);
		    //map.disableDragging();
		    map.addEventListener(MapZoomEvent.ZOOM_CHANGED, onMapZoomChanged);
			
			map.addEventListener(MapMoveEvent.MOVE_END,onMapMoved);
			map.addEventListener(MapEvent.MAPTYPE_CHANGED,onMaptypeChanged);
			
			DataServices.gi().addEventListener(DataServiceEvent.PA_DATA_LOADED,onPaDataLoaded);
			
			Application.application.onMapReady();				
			
		}
		
		public function setClickListenerForAreas():void {
			if(!map.hasEventListener(MapMouseEvent.CLICK)) {
				map.addEventListener(MapMouseEvent.CLICK, onMapClick);		
			}
		}
		
		public function removeClickListenerForAreas():void {
			if(map.hasEventListener(MapMouseEvent.CLICK)) {
				map.removeEventListener(MapMouseEvent.CLICK, onMapClick);		
			}
		}
		
		public function getMapPosition():MapPosition {
			return new MapPosition(map.getCenter(),map.getZoom(), map.getCurrentMapType());
		}
		
		public function setMapPosition(mp:MapPosition):void {
			//Only change of the mapPosition is different
			if (mp.isNoEqualMapPosition(getMapPosition())) {
				map.setCenter(mp.center,mp.zoom,mp.mapType);
			}
		}
		
		private function onMapZoomChanged(event:MapZoomEvent):void {
			mapCanvas.mapHeader.zoomSlider.value = map.getZoom();

			if (AppStates.gi().mapPositions[AppStates.gi().topState] !=null) {
				(AppStates.gi().mapPositions[AppStates.gi().topState] as MapPosition).zoom = map.getZoom();
			} else {
				AppStates.gi().mapPositions[AppStates.gi().topState] = getMapPosition();
			}
		}		
		
		private function onMapMoved(event:MapMoveEvent):void {
			if (AppStates.gi().mapPositions[AppStates.gi().topState] !=null) {
				(AppStates.gi().mapPositions[AppStates.gi().topState] as MapPosition).center = map.getCenter();
				AppStates.gi().debug(AppStates.gi().topState +':'+(AppStates.gi().mapPositions[AppStates.gi().topState] as MapPosition).toString());
			} else {
				AppStates.gi().mapPositions[AppStates.gi().topState] = getMapPosition();
				AppStates.gi().debug(AppStates.gi().topState +':'+(AppStates.gi().mapPositions[AppStates.gi().topState] as MapPosition).toString());
			}
		}
		
		private function onMaptypeChanged(event:MapEvent):void {
			if (AppStates.gi().mapPositions[AppStates.gi().topState] !=null) {
				(AppStates.gi().mapPositions[AppStates.gi().topState] as MapPosition).mapType = map.getCurrentMapType();
			} else {
				AppStates.gi().mapPositions[AppStates.gi().topState] = getMapPosition();
			}
			
		}
		
		public function zoomToBbox(bbox:LatLngBounds):void {
			var z:Number = map.getBoundsZoomLevel(bbox);
			map.setCenter(bbox.getCenter(),z);
		}
		
		
		public function setMapLoading():void {
			//removeClickListenerForAreas();
			map.disableDragging();
			map.doubleClickEnabled=false;
			if (bSprite==null) {
				aSprite = map.getChildAt(1) as Sprite;
				bSprite = aSprite.getChildAt(0) as Sprite;
			}
			bSprite.filters = [filter];
			mapCanvas.loadingBar.visible=true;
		
		}
		
		public function setMapLoaded():void {
			bSprite.filters = [emptyFilter];
			map.enableDragging();
			map.doubleClickEnabled=true;
			mapCanvas.loadingBar.visible=false;
		}	
		
		
		private function onMapClick(event:MapMouseEvent):void {
			previousCenter=map.getCenter();
			previousZoomLevel=map.getZoom();
			
			DataServices.gi().getAreasByLatLng(event.latLng);
		}	
		
		public function goToPreviousMapPosition():void {
			map.setCenter(previousCenter,previousZoomLevel);
		}
		
		
		private function onPaDataLoaded(event:DataServiceEvent):void {
			var z:Number = map.getBoundsZoomLevel(DataServices.gi().selectedPA.bbox);
			map.setCenter(DataServices.gi().selectedPA.bbox.getCenter(),z);
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
					AppStates.gi().debug("remove "+layerName);
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
					AppStates.gi().debug("add "+la);
					map.addOverlay(activeLayers[la]);
				} else {
					if(activeLayers[la]==null) {
						activeLayers[la]=cacheLayers[la];
						AppStates.gi().debug("add "+la);
						trace("add " +la);
						map.addOverlay(activeLayers[la]);
					}
				}
			}
			
			//we set it into the state
			AppStates.gi().visibleLayers[AppStates.gi().topState]=layers;
		}
		
		public function createTileLayer(layer:String):CustomTileLayerOverlay {
			
			ctl = new CustomTileLayer(WdpaLayer.STATIC_LAYERS[layer],WdpaLayer.DYNAMIC_LAYERS[layer],10);		
			var ctlo:CustomTileLayerOverlay = new CustomTileLayerOverlay(ctl);
			ctl.ctlo = ctlo;
			
			BindingUtils.bindProperty(mapCanvas.temp,"text",ctlo,"numRunningRequest");
			
			return ctlo;
		}
		

	}
}