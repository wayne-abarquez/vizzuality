package com.vizzuality.data
{
	import com.google.maps.LatLng;
	import com.google.maps.LatLngBounds;
	
	import flash.events.EventDispatcher;
	
	[Bindable]
	public class Country extends EventDispatcher
	{
		
		public var isocode:String;
		public var name:String;
		public var coveragePercentage:Number=0;
		public var marineCoveragePercentage:Number=0;
		public var terrestrialCoveragePercentage:Number=0;
		public var numAreas:Number=0;
		public var marineNumAreas:Number=0;
		public var terrestrialNumAreas:Number=0;
		public var numNational:Number=0;
		public var numInternational:Number=0;
		public var numberCoral:Number=0;
		public var numMangrove:Number=0;
		public var numSeagrass:Number=0;
		public var numSaltMarsh:Number=0;
		public var bbox:LatLngBounds;
		
		public function Country(ob:Object=null)
		{
			if (ob!=null) {
				this.isocode=ob.iso;
				this.name =  ob.name;
				this.coveragePercentage =  ob.coveragePercentage;
				this.numAreas =  ob.numAreas;
				this.numberCoral =  ob.numberCoral;
				this.numMangrove =  ob.numMangrove;
				this.numSeagrass =  ob.numSeagrass;
				this.bbox = new LatLngBounds(
					new LatLng(ob.south,ob.west),
					new LatLng(ob.north,ob.east));			
			}
		}

	}
}