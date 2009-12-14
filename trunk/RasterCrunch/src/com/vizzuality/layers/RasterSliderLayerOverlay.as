package com.vizzuality.layers
{
	import com.google.maps.Map;
	import com.google.maps.MapMoveEvent;
	import com.google.maps.MapZoomEvent;
	import com.google.maps.overlays.TileLayerOverlay;
	
	import mx.controls.HSlider;
	
	
	public class RasterSliderLayerOverlay extends TileLayerOverlay
	{
		private var map:Map;
		private var rasterTileLayer:RasterSliderLayer;
		
		public function RasterSliderLayerOverlay(rasterUrl:String,_map:Map,slider:HSlider) {
			map=_map;
			rasterTileLayer= new RasterSliderLayer(
				rasterUrl,
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