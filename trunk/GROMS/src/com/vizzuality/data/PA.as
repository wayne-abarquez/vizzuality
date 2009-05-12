package com.vizzuality.data
{
	import com.google.maps.LatLng;
	import com.google.maps.LatLngBounds;
	import com.google.maps.overlays.Polygon;
	
	[Bindable]
	public class PA
	{
		public static const POINT:String ="esriGeometryMultipoint";
		public static const POLYGON:String ="esriGeometryPolygon";
		public var id:Number;
		public var name:String;
		public var designation:String;
		public var country:String;
		public var countryIsoCode:String;
		public var has:Number;
		public var bbox:LatLngBounds;
		
		//The geometry of the PA could be a POLYGON or a POINT
		public var polygon:Polygon;
		public var point:Polygon;
		public var geomType:String;
		
		public function PA(ob:Object=null)
		{
			if(ob!= null) {
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

		public function getBbox():LatLngBounds {
			if(bbox!=null)
				return bbox;
			
			if (geomType == POLYGON) {
				bbox = polygon.getLatLngBounds();
			} else {
				bbox = point.getLatLngBounds();
			}		
			return bbox;
		}
		
		public function get geometry():Polygon {
			if (geomType == POLYGON) {
				return polygon;
			}
			return point;				
		}
		
		public function getCenter():LatLng {
			if (geomType == POLYGON) {
				return polygon.getLatLngBounds().getCenter();
			} else {
				return point.getLatLngBounds().getCenter();
			}		
		}
	}
}