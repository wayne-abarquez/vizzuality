package com.vizzuality.feature
{
	import com.google.maps.LatLngBounds;
	import com.google.maps.overlays.Polygon;
	import com.google.maps.overlays.PolygonOptions;
	
	public class Country
	{
		public var isocode:String;
		public var shape:Polygon;
		public var attributes:Object;
		public var polOpt:PolygonOptions;
		public var bbox:LatLngBounds;
		public var name:String;
		public var occurrences:Number;
		public var providers:Number;
		public var resources:Number;
		
		public function Country(isocode:String,attributes:Object,shape:Polygon,polOpt:PolygonOptions=null,bbox:LatLngBounds=null,name:String=null)
		{
			this.isocode=isocode;
			this.shape=shape;
			this.attributes=attributes;	
			this.polOpt=polOpt;
			this.bbox=bbox;
			this.name=name;
			
			this.occurrences=attributes.occurrences;
			this.providers=attributes.providers;
			this.resources=attributes.resources;
		}

	}
}