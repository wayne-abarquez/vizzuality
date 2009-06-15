package com.vizzuality.view.map
{
	import com.google.maps.LatLng;
	import com.google.maps.LatLngBounds;
	import com.google.maps.Map;
	import com.google.maps.MapAction;
	import com.google.maps.MapEvent;
	import com.google.maps.MapMoveEvent;
	import com.google.maps.MapType;
	import com.google.maps.MapZoomEvent;
	import com.google.maps.interfaces.IPane;
	import com.google.maps.interfaces.IPaneManager;
	import com.vizzuality.data.MapPosition;
	import com.vizzuality.data.Taxon;
	import com.vizzuality.services.DataServices;
	import com.vizzuality.view.map.overlays.CustomTileLayer;
	import com.vizzuality.view.map.overlays.CustomTileLayerOverlay;
	import com.vizzuality.view.map.overlays.CustomWMSTileLayer;
	import com.vizzuality.view.map.overlays.CustomWMSTileLayerOverlay;
	
	import flash.display.Sprite;
	import flash.filters.ColorMatrixFilter;
	import flash.utils.Dictionary;
	
	import gs.TweenLite;
	import gs.TweenMax;
	
	import mx.binding.utils.BindingUtils;
	import mx.core.Application;
	import mx.managers.CursorManager;
	
	
	public final class MapController
	{
		
		private static var instance:MapController;
		public var map:Map;
		private var mapCanvas:MapCanvas;
		public var ctl:CustomTileLayer;
		public var ctlwms:CustomWMSTileLayer;

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
		public var polygonPane1:IPane;
		public var polygonPane2:IPane;
		public var polygonPane3:IPane;
		public var picturesPane:IPane;
		public var youtubesPane:IPane;
		public var wikipediaPane:IPane;
		private var biodiversityPane:IPane;
		public var infowindowPane:IPane;
		
		private var mapClickCurrentAction:String;
		
		public var isWikipediaActive:Boolean=false;
		[Bindable] 
		public var isPicturesActive:Boolean=false;
		[Bindable] 
		public var isYoutubesActive:Boolean=false;
		
		private var currentLayersOpacity:Number=0;

		private var ctloDic:Dictionary = new Dictionary();	
		private var gbifTileOverlayDic:Dictionary = new Dictionary();		
		
		
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
			polygonPane1 = paneManager.createPane(numPanes+1);
			polygonPane2 = paneManager.createPane(numPanes+2);
			polygonPane3 = paneManager.createPane(numPanes+3);
/* 			picturesPane = paneManager.createPane(numPanes+2);
			youtubesPane = paneManager.createPane(numPanes+3);
			wikipediaPane = paneManager.createPane(numPanes+4); */
			biodiversityPane = paneManager.createPane(numPanes+4);
			infowindowPane = paneManager.createPane(numPanes+5);
			
			//map.enableContinuousZoom();
			
			
		    //map.disableDragging();
		    map.addEventListener(MapZoomEvent.ZOOM_CHANGED, onMapZoomChanged);			
			map.addEventListener(MapMoveEvent.MOVE_END,onMapMoved);
			
			//Create Panes for polygons and markers
			setMapPosition(getDefaultMapPosition());
			
			Application.application.onMapReady();				
			
		}
		
		
		
		
		
		
		
		public function getDefaultMapPosition():MapPosition {
			return new MapPosition(new LatLng(30,0),2,MapType.PHYSICAL_MAP_TYPE);
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

		}		
		
		private function onMapMoved(event:MapMoveEvent):void {
		}
		
		private function onMaptypeChanged(event:MapEvent):void {
			
		}
		
		public function zoomToBbox(bbox:LatLngBounds,oneLevelUp:Boolean=false):void {
			var z:Number = map.getBoundsZoomLevel(bbox);
			if (oneLevelUp)
				z=z-1;
			map.setCenter(bbox.getCenter(),z);			
		}
		
		
		public function setMapLoading():void {
			//removeClickListenerForAreas();
			map.disableDragging();
			map.setDoubleClickMode(MapAction.ACTION_NOTHING);
			CursorManager.setBusyCursor();
			
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
		
		public function clearOverlays():void {
			picturesPane.clear();
			wikipediaPane.clear();
			youtubesPane.clear();
			biodiversityPane.clear();
			infowindowPane.clear();
		}		
		

		

		
		public function changeTileOpacity(speciesId:Number,value:Number):void {
			if (ctloDic[speciesId]!=null) {
				TweenLite.to(
					(ctloDic[speciesId] as CustomWMSTileLayerOverlay).foreground,
					0.6,
					{alpha:value});
				TweenLite.to(
					(gbifTileOverlayDic[speciesId] as CustomTileLayerOverlay).foreground,
					0.6,
					{alpha:value});
			}
			
		}
		
		private var tween:TweenMax;
		public function highlightSpeciesOn(speciesId:Number):void {
			if(!(DataServices.gi().taxonDictionary[speciesId] as Taxon).isHiddenFromMap) {
				tween = TweenMax.from((ctloDic[speciesId] as CustomWMSTileLayerOverlay).foreground,
						0.6,
						{alpha:0.1,loop:0}
						);						
				if(tween==null) {
				} else {
					//tween.
				}			
			}
			
		}
		public function highlightSpeciesOff(speciesId:Number):void {
			if(!(DataServices.gi().taxonDictionary[speciesId] as Taxon).isHiddenFromMap) {
				tween.clear();
				(ctloDic[speciesId] as CustomWMSTileLayerOverlay).foreground.alpha=0.9;
			}
			
		}
		
		
		public var gbifLayersActive:Dictionary=new Dictionary();
		public function toggleGbifLayer(speciesId:Number):void {
			if(gbifLayersActive[speciesId]==true) {
				tileOverlaysPane.removeOverlay(gbifTileOverlayDic[speciesId]);
				gbifLayersActive[speciesId]=false;
			} else {
				tileOverlaysPane.addOverlay(gbifTileOverlayDic[speciesId]);	
				gbifLayersActive[speciesId]=true;
				
			}
			
		}
		
		
		public function makeTileShine(speciesId:Number):void {
			
			
			if (ctloDic[speciesId]!=null) {
				//(ctloDic[speciesId] as CustomWMSTileLayerOverlay).foreground.alpha=0.1;
				TweenMax.from(
					(ctloDic[speciesId] as CustomWMSTileLayerOverlay).foreground,
					0.6,
					{alpha:0.1,remove:true,loop:0}
					);
			}
			
		}
		
		public function createGbifLayer(gbifId:Number,speciesId:Number):void {
			if(gbifId!=0) {
				var ctlgbif:CustomTileLayer= new CustomTileLayer("http://maps3.eol.org/php/map/getEolTile.php?tile=|X|_|Y|_|Z|_"+gbifId,"",23);
				var ctlo:CustomTileLayerOverlay = new CustomTileLayerOverlay(ctlgbif);
				ctlgbif.ctlo=ctlo;
				ctlo.foreground.alpha=0.7;
				BindingUtils.bindProperty(mapCanvas.discretLoading,"visible",ctlo,"numRunningRequest");
				gbifTileOverlayDic[speciesId]=ctlo;
				tileOverlaysPane.addOverlay(ctlo);
			}
			
		}
		public function removeGbifTileLayer(speciesId:Number):void {
			if (gbifTileOverlayDic[speciesId]!=null) {
				tileOverlaysPane.removeOverlay(gbifTileOverlayDic[speciesId] as CustomTileLayerOverlay);
			}			
		}
		
		
		public function removeWMSTileLayer(speciesId:Number):void {
			if (ctloDic[speciesId]!=null) {
				tileOverlaysPane.removeOverlay(ctloDic[speciesId] as CustomWMSTileLayerOverlay);
			}
		}	
		public function createWMSTileLayer(speciesId:Number,colorizeColor:Number=NaN):void {
			
			ctlwms = new CustomWMSTileLayer(speciesId,colorizeColor);		
			var ctlo:CustomWMSTileLayerOverlay = new CustomWMSTileLayerOverlay(ctlwms);
			ctlwms.ctlo = ctlo;
			ctlo.foreground.alpha=0.9;
			
			BindingUtils.bindProperty(mapCanvas.discretLoading,"visible",ctlo,"numRunningRequest");
			
			ctloDic[speciesId]=ctlo;
			tileOverlaysPane.addOverlay(ctlo);
			gbifLayersActive[speciesId]=true;
		}
				
		

	}
}