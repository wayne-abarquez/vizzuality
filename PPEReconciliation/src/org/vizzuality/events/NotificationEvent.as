package org.vizzuality.events
{
	import flash.events.Event;

	public class NotificationEvent extends Event
	{
		public static const TASK_LIST_NOTIFICATION:String="taskListNotification";
		
		public var message:String;
		public function NotificationEvent(type:String,_message:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			message=_message;
			super(type, bubbles, cancelable);
		}
		
	}
}