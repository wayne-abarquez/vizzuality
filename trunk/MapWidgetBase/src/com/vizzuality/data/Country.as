package com.vizzuality.data
{
	[Bindable]
	public class Country
	{
		
		public var isocode:String;
		public var name:String;
		public var coveragePercentage:Number;
		public var numAreas:Number;
		public var numberCoral:Number;
		public var numMangrove:Number;
		public var numSeagrass:Number;
		
		public function Country(ob:Object)
		{
			this.isocode=ob.isocode;
			this.name =  ob.name;
			this.coveragePercentage =  ob.coveragePercentage;
			this.numAreas =  ob.numAreas;
			this.numberCoral =  ob.numberCoral;
			this.numMangrove =  ob.numMangrove;
			this.numSeagrass =  ob.numSeagrass;
		}

	}
}