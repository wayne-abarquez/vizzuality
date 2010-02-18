package com.vizzuality.events
{
	import flash.events.Event;
	
	public class SliderChangeEvent extends Event
	{
		
		public static const ALTITUDE_RANGE_CHANGED:String = "altitudeRangeChanged";
		public static const RELIEF_RANGE_CHANGED:String = "reliefRangeChanged";
		public static const VEGTYPE_RANGE_CHANGED:String = "vegtypeRangeChanged";
		
		public var minVal:Number;
		public var maxVal:Number;
		public var vegtypes:Array;
		
		public function SliderChangeEvent(type:String,_minVal:Number=NaN,_maxVal:Number=NaN,_vegtypes:Array=null, bubbles:Boolean=false, cancelable:Boolean=false) {
			minVal=_minVal;
			maxVal=_maxVal;
			vegtypes=_vegtypes;

			super(type, bubbles, cancelable);
		}

	}
}