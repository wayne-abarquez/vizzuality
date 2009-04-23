package com.vizzuality.feature
{
	import com.google.maps.overlays.Marker;
	
	public class Provider
	{
		public var id:Number;
		public var resource_count:Number;
		public var occurrence_count:Number;
		public var country_isocode:String;
		public var name:String;
		public var url:String;
		public var city:String;
		public var marker:Marker;
		
		public function Provider(id:Number,marker:Marker,resource_count:Number=NaN,
							occurrence_count:Number=NaN,country_isocode:String=null,name:String=null,url:String=null,
							city:String=null)
		{
			this.id=id;
			this.resource_count=resource_count;
			this.occurrence_count=occurrence_count;
			this.country_isocode=country_isocode;
			this.name=name;
			this.url=url;
			this.city=city;
			this.marker=marker;
		}

	}
}