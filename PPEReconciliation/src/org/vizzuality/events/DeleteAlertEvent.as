package org.vizzuality.events
{
	import flash.events.Event;
	


	public class DeleteAlertEvent extends Event
	{
		public static const DELETE_ITEM:String = "deleteItem";

		public var positionX: Number;
		public var positionY: Number;
		
		
		public function DeleteAlertEvent(type:String,localX:Number,localY:Number,bubbles:Boolean=true, cancelable:Boolean=true)
		{
			positionX = localX;
			positionY = localY;
			
			super(type, bubbles, cancelable);
		}
		
	}
}