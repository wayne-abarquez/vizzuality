package org.vizzuality.model
{
	import flash.events.EventDispatcher;
	
	[Bindable]
	public class Pa extends EventDispatcher
	{
		public var id:String;
		public var name:String;
		public var country:String;
		public var status:String;
		public var data:Object;
		
		public function getStatusDescription():String {
			if(status==ReviewProcess.CONFIRMED) {
				return "Confirmed";
			} else if (status==ReviewProcess.REJECTED)  {
				return "Rejected";				
			} else {
				return "";
			}
		}

	}
}