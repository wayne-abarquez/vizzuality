package org.vizzuality.events
{
	import flash.events.Event;
	
	import org.vizzuality.model.Task;

	public class TaskSelectionEvent extends Event
	{
		public static const SELECTED_TASK:String = "selectedTask";
		public var task:Task;
		
		
		public function TaskSelectionEvent(type:String,_selectedTask:Task=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			task=_selectedTask;
			
			super(type, bubbles, cancelable);
		}
		
	}
}