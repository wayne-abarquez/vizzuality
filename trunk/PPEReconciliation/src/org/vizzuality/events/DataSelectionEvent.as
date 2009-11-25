package org.vizzuality.events
{
	import flash.events.Event;
	
	import org.vizzuality.model.Country;
	import org.vizzuality.model.Pa;

	public class DataSelectionEvent extends Event
	{
		public static const COUNTRY_ADDED:String = "countryAdded";
		public static const COUNTRY_REMOVED:String = "countryRemoved";
		public static const PA_ADDED:String = "paAdded";
		public static const PA_REMOVED:String = "paRemoved";
		public static const DATA_DOWNLOADED:String = "dataDownloaded";
		
		public var selectedCountry:Country;
		public var selectedPa:Pa;
		
		
		public function DataSelectionEvent(type:String,_selectedCountry:Country=null,_selectedPa:Pa=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			selectedCountry=_selectedCountry;
			selectedPa=_selectedPa;
			
			super(type, bubbles, cancelable);
		}
		
	}
}