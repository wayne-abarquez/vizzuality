package com.vizzuality.data
{
	import com.google.maps.LatLng;
	import com.google.maps.LatLngBounds;
	
	[Bindable]
	public class Country
	{
		
		public var isocode:String;
		public var name:String;
		public var coveragePercentage:Number;
		public var marineCoveragePercentage:Number;
		public var terrestrialCoveragePercentage:Number;
		public var numAreas:Number;
		public var marineNumAreas:Number;
		public var terrestrialNumAreas:Number;
		public var numberCoral:Number;
		public var numMangrove:Number;
		public var numSeagrass:Number;
		public var bbox:LatLngBounds;
		
	}
}