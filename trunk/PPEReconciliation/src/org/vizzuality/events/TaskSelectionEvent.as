package org.vizzuality.events
{
	import flash.events.Event;
	
	import org.vizzuality.model.Pa;
	import org.vizzuality.model.Task;

	public class TaskSelectionEvent extends Event
	{
		public static const SELECTED_TASK:String = "selectedTask";
		public static const SELECTED_PA_FOR_REVIEW:String = "selectedPaForReview";
		public var task:Task;
		public var pa:Pa;
		
		
		public function TaskSelectionEvent(type:String,_selectedTask:Task=null,_selectedPa:Pa=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			task=_selectedTask;
			pa=_selectedPa;
			
			super(type, bubbles, cancelable);
		}
		
	}
}