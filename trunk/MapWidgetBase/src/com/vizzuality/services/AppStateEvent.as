package com.vizzuality.services
{
	import flash.events.Event;

	public class AppStateEvent extends Event
	{
		
		public static const AREA_DETAILS_DISPLAY:String='areaDetailsDisplay';		
		
		public function AppStateEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}