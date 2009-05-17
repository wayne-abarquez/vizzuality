package com.vizzuality.data
{
	import com.google.maps.LatLng;
	import com.google.maps.LatLngBounds;
	import com.vizzuality.view.map.overlays.MultiPolygon;
	
	import flash.events.EventDispatcher;
	
	[Bindable]
	public class PA extends EventDispatcher
	{
		public static const POINT:String ="point";
		public static const POLYGON:String ="polygon";
		//Mandatory
		public var id:Number;
		public var name:String;
		public var country:String;
		public var countryIsoCode:String;
		public var geomType:String;
		public var isInternational:Boolean=false;
		
		//Non mandatory
		public var designation:String;
		public var has:Number;
		public var totalArea:Number;
		public var currentStatus:String;
		public var establishmentYear:String;
		public var iucnCategory:String;
		public var siteGovernance:String;
		public var status:String;
		public var siteType:String;
		
		//The geometry of the PA could be a POLYGON or a POINT	
		public var geometry:MultiPolygon = new MultiPolygon();
		

		public function getBbox():LatLngBounds {			
			return geometry.getBBox();
		}
		
		public function getCenter():LatLng {
			return geometry.getCenter();	
		}
	}
}