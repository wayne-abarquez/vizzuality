package com.vizzuality.components
{
	
	import flash.events.Event;

	public class ItemClickTreeBrowserEvent extends Event
	{
		
		public static const ITEM_CLICK:String = "ItemClick"
		public var itemRenderer: ItemListRenderer;
		
		public function ItemClickTreeBrowserEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}