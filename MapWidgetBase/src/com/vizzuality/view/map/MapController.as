package com.vizzuality.view.map
{
	import com.google.maps.LatLng;
	import com.google.maps.LatLngBounds;
	import com.google.maps.Map;
	import com.google.maps.MapAction;
	import com.google.maps.MapEvent;
	import com.google.maps.MapMouseEvent;
	import com.google.maps.MapMoveEvent;
	import com.google.maps.MapType;
	import com.google.maps.MapZoomEvent;
	import com.google.maps.interfaces.IPane;
	import com.google.maps.interfaces.IPaneManager;
	import com.vizzuality.data.MapPosition;
	import com.vizzuality.data.PA;
	import com.vizzuality.data.WdpaLayer;
	import com.vizzuality.services.DataServiceEvent;
	import com.vizzuality.services.DataServices;
	import com.vizzuality.view.AppStates;
	import com.vizzuality.view.map.overlays.CustomTileLayer;
	import com.vizzuality.view.map.overlays.CustomTileLayerOverlay;
	
	import flash.display.Sprite;
	import flash.filters.ColorMatrixFilter;
	import flash.utils.Dictionary;
	
	import gs.TweenLite;
	
	import mx.binding.utils.BindingUtils;
	import mx.core.Application;
	import mx.managers.CursorManager;
	
	
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
		
		private var paneManager:IPaneManager;
		private var tileOverlaysPane:IPane;
		public var polygonPane:IPane;
		public var picturesPane:IPane;
		public var wikipediaPane:IPane;
		private var biodiversityPane:IPane;
		public var infowindowPane:IPane;
		
		private var mapClickCurrentAction:String;
		
		private var currentLayersOpacity:Number=0;
		
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
			paneManager = map.getPaneManager();
			var numPanes:Number = paneManager.paneCount-1;
			tileOverlaysPane = paneManager.createPane(numPanes);
			polygonPane = paneManager.createPane(numPanes+1);
			picturesPane = paneManager.createPane(numPanes+2);
			wikipediaPane = paneManager.createPane(numPanes+3);
			biodiversityPane = paneManager.createPane(numPanes+4);
			infowindowPane = paneManager.createPane(numPanes+5);
			
			map.enableContinuousZoom();
			
			AppStates.gi().mapPositions[AppStates.WORLD] = MapController.gi().getDefaultMapPosition();
			AppStates.gi().mapPositions[AppStates.COUNTRIES] = MapController.gi().getDefaultMapPosition();
			setMapPosition(getDefaultMapPosition());
			
			
		    //map.disableDragging();
		    map.addEventListener(MapZoomEvent.ZOOM_CHANGED, onMapZoomChanged);			
			map.addEventListener(MapMoveEvent.MOVE_END,onMapMoved);
			map.addEventListener(MapEvent.MAPTYPE_CHANGED,onMaptypeChanged);
			
			DataServices.gi().addEventListener(DataServiceEvent.PA_DATA_LOADED,onPaDataLoaded);
			
			//Create Panes for polygons and markers
			
			
			Application.application.onMapReady();				
			
		}
		
		
		public function getDefaultMapPosition():MapPosition {
			return new MapPosition(new LatLng(30,0),2,MapType.PHYSICAL_MAP_TYPE);
		}
		
		public function setClickListenerForAreas():void {
			if(!map.hasEventListener(MapMouseEvent.CLICK)) {				
				map.addEventListener(MapMouseEvent.CLICK, onAreaMapClick);					
			}
			mapClickCurrentAction="goToArea";
		}
		
		public function removeClickListenerForAreas(temporal:Boolean=false):void {
			if(mapClickCurrentAction=="goToArea") {
				map.removeEventListener(MapMouseEvent.CLICK, onAreaMapClick);		
				if(!temporal)
					mapClickCurrentAction=null;	
			}
		}
		
		public function setClickListenerForCountries():void {
			
			if(mapClickCurrentAction=="goToArea") {
				removeClickListenerForAreas();
			}
			if(!map.hasEventListener(MapMouseEvent.CLICK)) {
				map.addEventListener(MapMouseEvent.CLICK, onCountriesMapClick);					
			}		
			mapClickCurrentAction="goToCountry";	
		}
		
		
		public function removeClickListenerForCountries(temporal:Boolean=false):void {
			if(mapClickCurrentAction=="goToCountry") {
				map.removeEventListener(MapMouseEvent.CLICK, onCountriesMapClick);		
				if(!temporal)
					mapClickCurrentAction=null;	
			}
		}
			
		public function disableClick():void {
			removeClickListenerForAreas(true);			
			removeClickListenerForCountries(true);									
		}
		
		public function enableClick():void {
			if(mapClickCurrentAction=="goToArea") {
				setClickListenerForAreas();
			} else if(mapClickCurrentAction=="goToCountry") {
				setClickListenerForCountries();
			}			
		}		
		
		
		public function getMapPosition():MapPosition {
			return new MapPosition(map.getCenter(),map.getZoom(), map.getCurrentMapType());
		}
		
		public function setMapPosition(mp:MapPosition):void {
			//Only change of the mapPosition is different
			//trace(mp.zoom);
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
		
		public function zoomToBbox(bbox:LatLngBounds,oneLevelUp:Boolean=false):void {
			var z:Number = map.getBoundsZoomLevel(bbox);
			if (oneLevelUp)
				z=z-1;
			map.setCenter(bbox.getCenter(),z);
			AppStates.gi().mapPositions[AppStates.gi().topState] = getMapPosition();			
		}
		
		
		public function setMapLoading():void {
			//removeClickListenerForAreas();
			map.disableDragging();
			map.setDoubleClickMode(MapAction.ACTION_NOTHING);
			CursorManager.setBusyCursor();
			
			disableClick();
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
			map.setDoubleClickMode(MapAction.ACTION_PAN_ZOOM_IN);
			CursorManager.removeBusyCursor();
			CursorManager.removeBusyCursor();
			CursorManager.removeBusyCursor();
			CursorManager.removeBusyCursor();
			
			enableClick();	
				
			mapCanvas.loadingBar.visible=false;
		}	
		
		public function showMapWarning(text:String,duration:Number):void {
			
			//should only be displayed 4 secs.
			mapCanvas.alertCanvas.visible=true;
			mapCanvas.alertCanvas.alertText = text;
			mapCanvas.alertCanvas.alpha=1;
			TweenLite.to(mapCanvas.alertCanvas,duration,{alpha:0,delay:1.3,onComplete:function():void{
				mapCanvas.alertCanvas.visible=false;
				}});
			
		}
		
		private function onAreaMapClick(event:MapMouseEvent):void {
			trace("onAreaMapClick");
			if(AppStates.gi().secondState==AppStates.ABOUT) {
				AppStates.gi().setSecondState('');
			} else {
				AppStates.gi().debug("onAreaMapClick");	
				DataServices.gi().getAreasByLatLng(event.latLng);
			}
		}	
		
		private function onCountriesMapClick(event:MapMouseEvent):void {
			trace("onCountriesMapClick");
			if(AppStates.gi().secondState==AppStates.ABOUT) {
				AppStates.gi().setSecondState('');
			} else {
				DataServices.gi().getCountryByLatLng(event.latLng);
				AppStates.gi().debug("onCountriesMapClick");
			}
		}		
		
		public function goToPreviousMapPosition():void {
			map.setCenter(previousCenter,previousZoomLevel);
		}
		
		
		private function onPaDataLoaded(event:DataServiceEvent):void {
			var z:Number = map.getBoundsZoomLevel(DataServices.gi().selectedPA.bbox);
			map.setCenter(DataServices.gi().selectedPA.bbox.getCenter(),z);
		}
		
		public function addActivePa():void {
			if(DataServices.gi().activePA!=null) {
				if (DataServices.gi().activePA.polygon!=null) { 
				polygonPane.addOverlay(DataServices.gi().activePA.polygon);
				} else {
				//polygonPane.addOverlay(DataServices.gi().activePA.point);					
				}
			}
		}
		
		public function addPa(pa:PA):void {
			if (pa.geomType==PA.POLYGON) {
				polygonPane.addOverlay(pa.polygon);
				AppStates.gi().debug("added pa (POL) : "+pa.id);
			} else if (pa.geomType==PA.POINT) {					
				polygonPane.addOverlay(pa.point);
				AppStates.gi().debug("added pa (POINT) : "+pa.id);
			}
		}		
		
		public function clearPAs():void {
			AppStates.gi().debug("clear PAs");
			polygonPane.clear();
		}
		
		public function clearOverlays():void {
			AppStates.gi().debug("clear all overlays");
			picturesPane.clear();
			wikipediaPane.clear();
			biodiversityPane.clear();
			infowindowPane.clear();
		}		
		

		public function updateTileLayersOpacity(opacity:Number):void {
			if (currentLayersOpacity!=opacity) {
				for (var layerName:String in activeLayers) {
					(activeLayers[layerName] as CustomTileLayerOverlay).setAlpha(opacity);
				}
				currentLayersOpacity=opacity;
			}
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
					AppStates.gi().debug("remove "+layerName);
					tileOverlaysPane.removeOverlay(activeLayers[layerName]);
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
					tileOverlaysPane.addOverlay(activeLayers[la]);
				} else {
					if(activeLayers[la]==null) {
						activeLayers[la]=cacheLayers[la];
						AppStates.gi().debug("add "+la);
						tileOverlaysPane.addOverlay(activeLayers[la]);
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
			ctlo.foreground.alpha=0.8;
			
			BindingUtils.bindProperty(mapCanvas.discretLoading,"visible",ctlo,"numRunningRequest");
			
			return ctlo;
		}
				
		

	}
}