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
			if(this.center.lat() != mp.center.lat())
				return true;
			if(this.center.lng() != mp.center.lng())
				return true;
			if (this.zoom != mp.zoom)
				return true;
			if(this.mapType.getName() != mp.mapType.getName())
				return true;
			
			return false	
		}
		
		public function toString():String{
			return (center.lat()+","+center.lng()+"/"+zoom+"/"+mapType.getName());
		}
	}
}