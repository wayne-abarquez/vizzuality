package org.vizzuality.events
{
	import flash.events.Event;

	public class ConfirmationAlertEvent extends Event
	{
		public static const GO_ON:String = "ok";
		public static const STOP_NOW:String = "no";
		
		public function ConfirmationAlertEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}