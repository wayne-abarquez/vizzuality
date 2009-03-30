package com.vizzuality.event
{
	import flash.events.Event;
	import mx.collections.ArrayCollection;

	public class ResultJson extends Event
	{
		public static const JSON_RESULT: String = "onJsonResult";
		public var jsonData:Array;
		public function ResultJson(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}