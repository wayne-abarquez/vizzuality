package com.vizzuality.services{
	
	import flash.events.Event;

	public class PicClickEvent extends Event{
		
		public static var PIC_CLICK_EVENT:String = "picClickEvent"; 
		
		private var id:String;
		
		public function PicClickEvent(type:String, id:String, bubbles:Boolean=false, cancelable:Boolean=false){
			
			super(type, bubbles, cancelable);
			this.id = id;
		}
		
	}
}