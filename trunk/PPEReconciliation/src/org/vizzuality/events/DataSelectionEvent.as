package org.vizzuality.events
{
	import flash.events.Event;
	
	import org.vizzuality.model.Country;

	public class DataSelectionEvent extends Event
	{
		public static const COUNTRY_ADDED:String = "countryAdded";
		public static const COUNTRY_REMOVED:String = "countryRemoved";
		public var selectedCountry:Country;
		public var selectedPaId:Number;
		
		
		public function DataSelectionEvent(type:String,_selectedCountry:Country=null,_selectedPaId:Number=NaN, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			selectedCountry=_selectedCountry;
			selectedPaId=_selectedPaId;
			
			super(type, bubbles, cancelable);
		}
		
	}
}