package org.vizzuality.model
{
	import flash.events.EventDispatcher;
	
	[Bindable]
	public class Country extends EventDispatcher
	{
		public var name:String;
		public var id:Number;
		public var code:String;
		public var numareas:Number;
		public var isSelectedForDownload:Boolean=false;
		public var ind:Number;

	}
}