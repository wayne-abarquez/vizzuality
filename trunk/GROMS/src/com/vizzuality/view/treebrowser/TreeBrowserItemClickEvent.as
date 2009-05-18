package com.vizzuality.view.treebrowser{
	
	import flash.events.Event;
	
	import mx.core.UIComponent;

	public class TreeBrowserItemClickEvent extends Event{
		
		public var owner:UIComponent;
		
		public function TreeBrowserItemClickEvent(type:String,owner:UIComponent, bubbles:Boolean=false, cancelable:Boolean=false){	
			super(type, bubbles, cancelable);
			this.owner = owner;
		}
		
	}
}