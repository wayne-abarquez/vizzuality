package com.vizzuality.events
{
	import flash.events.Event;
	
	public class SliderChangeEvent extends Event
	{
		
		public static const SLIDER_CHANGED:String = "sliderChanged";
		
		public var altitudeRange:Array;
		public var reliefRange:Array;
		public var vegtypes:Array;
		
		public function SliderChangeEvent(altitudeRange:Array,reliefRange:Array,vegtypes:Array, bubbles:Boolean=false, cancelable:Boolean=false) {
			this.altitudeRange=altitudeRange;
			this.reliefRange=reliefRange;
			this.vegtypes=vegtypes;

			super(type, bubbles, cancelable);
		}

	}
}