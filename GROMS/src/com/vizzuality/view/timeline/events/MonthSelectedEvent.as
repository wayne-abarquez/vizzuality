package com.vizzuality.view.timeline.events
{
	import flash.events.Event;

	public class MonthSelectedEvent extends Event
	{
		public static const ON_CHOOSE_MONTHS: String = "onMoveComponentData";
		
		public var monthStart: Number;
		public var monthEnd: Number;
		
		public function MonthSelectedEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}