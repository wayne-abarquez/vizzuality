package com.vizzuality.view.map
{
	import com.google.maps.Map;
	import com.google.maps.MapType;
	import com.google.maps.MapZoomEvent;
	
	import flash.display.Sprite;
	import flash.filters.ColorMatrixFilter;
	
	import mx.core.Application;
	
	public final class MapController
	{
		
		private static var instance:MapController;
		private var map:Map;
		private var mapCanvas:MapCanvas;

		private var aSprite:Sprite;
		private var bSprite:Sprite;   			
		
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
		
		

	}
}