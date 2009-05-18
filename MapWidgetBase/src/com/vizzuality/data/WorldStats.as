package com.vizzuality.data
{
	import mx.formatters.NumberFormatter;
	
	[Bindable]
	public class WorldStats
	{
		
		public var coveragePercentage:Number;
		public var international:Number;
		public var marine:Number;
		public var national:Number;
		public var terrestrial:Number;
		public var totalAreas:Number;
		public var marineTerrestrialCount:Number;
		
		public function WorldStats(ob:Object=null)
		{
			if(ob!=null) {
				this.coveragePercentage=ob.coveragePercentage;
				this.international=ob.international;
				this.marine=ob.marine;
				this.national=ob.national;
				this.terrestrial=ob.terrestrial;
				this.totalAreas=ob.totalAreas;
				this.marineTerrestrialCount=ob.marineTerrestrialCount;
			}
		}
		

	}
}