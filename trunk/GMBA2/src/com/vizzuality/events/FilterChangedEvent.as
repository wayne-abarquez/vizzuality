package com.vizzuality.events
{
	import flash.events.Event;
	
	public class FilterChangedEvent extends Event
	{
		
		public static const FILTER_CHANGED:String = "filterChanged";
		public var mustChangeUrl:Boolean = true;
		
		public function FilterChangedEvent(type:String,_mustChangeUrl:Boolean=true,bubbles:Boolean=false, cancelable:Boolean=false) {
			this.mustChangeUrl = _mustChangeUrl;
			super(type, bubbles, cancelable);
		}

	}
}