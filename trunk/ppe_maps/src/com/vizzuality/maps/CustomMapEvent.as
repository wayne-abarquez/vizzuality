package com.vizzuality.maps
{
	import flash.events.Event;
	
	public class CustomMapEvent extends Event
	{
		public static const MOUSE_OVER_AREA:String = "mouseOverArea";
		public static const MOUSE_OUT_AREA:String = "mouseOutArea";
		
		public var _local_x: Number;
		public var _local_y: Number;
		
		public function CustomMapEvent(type:String,local_x:Number,local_y:Number,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			_local_x = local_x;
			_local_y = local_y;
			super(type, bubbles, cancelable);
		}

	}
}