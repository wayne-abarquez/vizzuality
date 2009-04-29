package com.vizzuality.data
{
	import com.google.maps.LatLng;
	import com.google.maps.interfaces.IMapType;
	
	public class MapPosition
	{
		
		public var center:LatLng;
		public var zoom:Number;
		public var mapType:IMapType;
		
		public function MapPosition(_center:LatLng,z:Number,mapType:IMapType)
		{
			this.center=_center;
			this.zoom=z;
			this.mapType=mapType;
		}

		public function isNoEqualMapPosition(mp:MapPosition):Boolean {
			return(this.center.lat() != mp.center.lat() ||
				this.center.lng() != mp.center.lng() ||
				this.zoom != mp.zoom||
				this.mapType.getName() != mp.mapType.getName());
		}
		
		public function toString():String{
			return (center.lat()+","+center.lng()+"/"+zoom+"/"+mapType.getName());
		}
	}
}