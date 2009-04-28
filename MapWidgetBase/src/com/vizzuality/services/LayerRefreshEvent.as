package com.vizzuality.services
{
	import flash.events.Event;

	public class LayerRefreshEvent extends Event
	{
		
		public var layers:Array;
		public static const LAYERS_REFRESHED:String='layersRefreshed';
		
		public function LayerRefreshEvent(type:String, layers:Array, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.layers=layers;
			super(type, bubbles, cancelable);
		}
		
	}
}