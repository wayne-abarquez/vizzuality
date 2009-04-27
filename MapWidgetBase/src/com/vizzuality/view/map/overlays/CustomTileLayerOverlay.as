package com.vizzuality.view.map.overlays
{
	import com.google.maps.overlays.TileLayerOverlay;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;

	public class CustomTileLayerOverlay extends TileLayerOverlay
	{
		[Bindable]
		public var numRunningRequest:Number=0;
		
		public function CustomTileLayerOverlay(ctlo:CustomTileLayer)
		{
			//numRunningRequest = ctlo.numRunningRequest;
			super(ctlo);
		}		
		
	}
}