

package com.vizzuality.events
{
	import flash.events.Event;

	public class TreeBrowserEvent extends Event
	{
		public static const NODE_SELECTED:String = "treeBrowserNodeSelected";
		
		public var item:Object;
		public var isBranch:Boolean;
		
		public function TreeBrowserEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event{
			var event:TreeBrowserEvent = new TreeBrowserEvent(type, bubbles, cancelable);
			event.item = item;
			event.isBranch = isBranch;
			return event;
		}
	}
}