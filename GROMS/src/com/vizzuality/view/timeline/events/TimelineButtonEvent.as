package com.vizzuality.view.timeline.events
{
	import flash.events.Event;

	public class TimelineButtonEvent extends Event
	{
		public static const INFORMATION_SPECIE: String = "onClickInformation";
		public static const DELETE_SPECIE: String = "onDeleteSpecie";
		public static const INFORMATION_GBIF: String = "onClickGBIFInformation";
		public static const TIMELINE_VISIBLE: String = "onVisibleClick";
		
		public var specieID: int;
		public var visible: Boolean = true;
		
		public function TimelineButtonEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}