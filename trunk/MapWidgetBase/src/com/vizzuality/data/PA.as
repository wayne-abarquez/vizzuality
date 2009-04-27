package com.vizzuality.data
{
	[Bindable]
	public class PA
	{
		
		public var id:Number;
		public var name:String;
		public var country:String;
		public var countryIsoCode:String;
		public var has:Number;
		
		public function PA(ob:Object)
		{
			this.id=ob.id;
			this.name =ob.name;
			this.has =ob.has;
			this.country =ob.country;
			this.countryIsoCode =ob.countryIsoCode;	
			
		}

	}
}