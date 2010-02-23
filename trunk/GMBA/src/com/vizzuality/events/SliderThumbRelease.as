package com.vizzuality.events
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;

	public class SliderThumbRelease extends Event
	{
		public static const SLIDER_VALUE_CHANGED:String = "sliderValueChanged";
		
		public var altitudeRange:Array;
		public var reliefRange:Array;
		public var vegtypes:ArrayCollection;
		
		public function SliderThumbRelease(type:String,altitudeRange:Array,reliefRange:Array,vegtypes:ArrayCollection, bubbles:Boolean=false, cancelable:Boolean=false) {
			this.altitudeRange=altitudeRange;
			this.reliefRange=reliefRange;
			this.vegtypes=vegtypes;

			super(type, bubbles, cancelable);
		}
		
	}
}