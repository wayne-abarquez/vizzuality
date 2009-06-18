package com.ninem.controls.treebrowserclasses
{
	import flash.display.DisplayObject;
	
	import gs.TweenLite;
	
	import mx.controls.List;
	import mx.events.FlexEvent;
    import mx.core.mx_internal;


	[Event(name="custom",type="mx.events.FlexEvent")]

	public class TreeBrowserList extends List {
		use namespace mx_internal; //tells Actionscript that mx_internal is a namespace 
	        
	        public function TreeBrowserList()
	        {
	            super();
	        }
		
		public function get renderers():Array
	        {
	            //prefix the internal property name with its namespace
	            return mx_internal::rendererArray;
	        }
	}
}