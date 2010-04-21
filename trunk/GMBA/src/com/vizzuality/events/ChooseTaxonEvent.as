package com.vizzuality.events
{
	import flash.events.Event;

	public class ChooseTaxonEvent extends Event
	{
		public static const CHOSEN:String = "Choosen";
		
		public var information_:Object;
		
		public function ChooseTaxonEvent(type:String,information:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.information_ = information;
			
			super(type, bubbles, cancelable);
		}
		
	}
}