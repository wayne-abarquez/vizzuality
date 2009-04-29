package com.vizzuality.services
{
	import flash.events.Event;

	public class DataServiceEvent extends Event
	{
		
		public static const PA_DATA_LOADED:String='paDataLoaded';
		public static const COUNTRY_DATA_LOADED:String='countryDataLoaded';
		public static const WORLD_DATA_LOADED:String='worldDataLoaded';
		public static const AREAS_FOR_LATLNG_LOADED:String='areasForLatLngLoaded';
		
		public function DataServiceEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}