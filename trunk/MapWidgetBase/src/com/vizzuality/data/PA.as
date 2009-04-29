package com.vizzuality.data
{
	import com.google.maps.LatLng;
	import com.google.maps.LatLngBounds;
	
	[Bindable]
	public class PA
	{
		
		public var id:Number;
		public var name:String;
		public var country:String;
		public var countryIsoCode:String;
		public var has:Number;
		public var bbox:LatLngBounds;
		
		public function PA(ob:Object)
		{
			this.id=ob.id;
			this.name =ob.name;
			this.has =ob.has;
			this.country =ob.country;
			this.countryIsoCode =ob.countryIsoCode;	
			this.bbox = new LatLngBounds(
				new LatLng(ob.south,ob.west),
				new LatLng(ob.north,ob.east));
		}

	}
}