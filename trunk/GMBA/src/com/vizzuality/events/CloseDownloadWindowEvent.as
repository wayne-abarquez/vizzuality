package com.vizzuality.events
{
	import flash.events.Event;

	public class CloseDownloadWindowEvent extends Event
	{
		public static const CLOSE_WINDOW:String = "closeWindow";
		
		public function CloseDownloadWindowEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}