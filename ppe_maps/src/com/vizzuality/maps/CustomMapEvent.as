package com.vizzuality.maps
{
	import flash.events.Event;
	
	public class CustomMapEvent extends Event
	{
		public static const MOUSE_OVER_AREA:String = "mouseOverArea";
		public static const MOUSE_OUT_AREA:String = "mouseOutArea";
		
		public function CustomMapEvent(type:String,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}

	}
}