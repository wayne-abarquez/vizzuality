package com.vizzuality.layers
{
	import com.google.maps.Map;
	import com.google.maps.MapMoveEvent;
	import com.google.maps.MapZoomEvent;
	import com.google.maps.overlays.TileLayerOverlay;
	
	import mx.controls.sliderClasses.Slider;
	import mx.events.SliderEvent;
	
	public class RasterSliderLayerOverlay extends TileLayerOverlay
	{
		private var map:Map;
		private var rasterTileLayer:RasterSliderLayer;
		
		public function RasterSliderLayerOverlay(rasterUrl:String,_map:Map,slider:Slider) {
			map=_map;
			rasterTileLayer= new RasterSliderLayer(
				"http://downloads.wdpa.org/ArcGIS/rest/services/GID/DEM_Greyscale_reclass/MapServer/tile/|Z|/|Y|/|X|.png",
				slider);
			map.addEventListener(MapMoveEvent.MOVE_END,mapMoveEnd);
			map.addEventListener(MapZoomEvent.ZOOM_CHANGED,zoomChanged);
			super(rasterTileLayer);
		}
		
	    private function mapMoveEnd(event:MapMoveEvent):void {
	        rasterTileLayer.applyThreshold(null);
	    }
	    private function zoomChanged(event:MapZoomEvent):void {
	        trace("zoomChanged");
	        //rasterTileLayer.tileArr=[]
	        rasterTileLayer.applyThreshold(null);
	    }	   	

	}
}