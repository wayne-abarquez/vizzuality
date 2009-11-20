package org.vizzuality.events
{
	import flash.events.Event;
	
	import org.vizzuality.model.Task;

	public class CancelTaskEvent extends Event
	{
		public static const CANCEL_TASK:String = "cancelTask";
		public var task:Task;
		public function CancelTaskEvent(type:String,_task:Task, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			task=_task;
		}
		
	}
}