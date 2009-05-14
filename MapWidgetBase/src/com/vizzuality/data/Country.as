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