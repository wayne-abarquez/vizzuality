package com.vizzuality.events
{
	import flash.events.Event;
	
	public class FilterChangedEvent extends Event
	{
		
		public static const FILTER_CHANGED:String = "filterChanged";
		public static const ELEVATION_CHANGE:String ="elevationChange";
		public static const RELIEF_CHANGE:String ="reliefChange";
		public static const VEGETATION_CHANGE:String ="vegetationChange";
		public static const TAXON_CHANGE:String ="taxonChange";
		public static const MAP_CHANGE:String ="mapChange";
		public var mustChangeUrl:Boolean = true;
		public var changeType:String;
		
		public function FilterChangedEvent(type:String,_changeType:String,_mustChangeUrl:Boolean=true,bubbles:Boolean=false, cancelable:Boolean=false) {
			this.mustChangeUrl = _mustChangeUrl;
			this.changeType = _changeType;
			super(type, bubbles, cancelable);
		}

	}
}