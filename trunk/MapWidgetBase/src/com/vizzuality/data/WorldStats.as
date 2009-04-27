package com.vizzuality.data
{
	[Bindable]
	public class WorldStats
	{
		
		public var coveragePercentage:Number;
		public var international:Number;
		public var marine:Number;
		public var national:Number;
		public var terrestrial:Number;
		public var totalAreas:Number;
		
		public function WorldStats(ob:Object)
		{
			this.coveragePercentage=ob.coveragePercentage;
			this.international=ob.international;
			this.marine=ob.marine;
			this.national=ob.national;
			this.terrestrial=ob.terrestrial;
			this.totalAreas=ob.totalAreas;
		}

	}
}