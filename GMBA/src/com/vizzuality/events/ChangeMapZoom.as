package com.vizzuality.events
{
	import flash.events.Event;

	public class ChangeMapZoom extends Event
	{
		
		public static const CHANGED:String = "ZoomChanged";
		
		public var zoom:Number;		
	
		public function ChangeMapZoom(type:String, zoom:Number, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.zoom = zoom;
			
			super(type, bubbles, cancelable);
		}
		
	}
}