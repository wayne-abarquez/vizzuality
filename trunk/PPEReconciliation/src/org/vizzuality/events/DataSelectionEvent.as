package org.vizzuality.events
{
	import flash.events.Event;

	public class DataSelectionEvent extends Event
	{
		public static const COUNTRY_ADDED:String = "countryAdded";
		
		public function DataSelectionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}