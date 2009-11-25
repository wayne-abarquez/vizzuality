package org.vizzuality.events
{
	import flash.events.Event;
	
	import org.vizzuality.model.Task;

	public class CancelTaskEvent extends Event
	{
		public static const CANCEL_TASK:String = "cancelTask";
		public var task:Task;
		public var positionX: Number;
		public var positionY: Number;
		public function CancelTaskEvent(type:String,_task:Task,_positionX:Number,_positionY:Number, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			task=_task;
			positionX = _positionX;
			positionY = _positionY;
		}
		
	}
}