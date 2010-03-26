package com.vizzuality.events
{
	import flash.events.Event;

	public class OpenTaxonomicEvent extends Event
	{
		public static const OPEN:String = "open";
		
		public function OpenTaxonomicEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}