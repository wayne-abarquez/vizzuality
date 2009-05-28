package com.vizzuality.data
{
	import com.google.maps.LatLng;
	import com.google.maps.LatLngBounds;
	import com.vizzuality.view.map.overlays.MultiPolygon;
	
	[Bindable]
	public class Taxon
	{
		public var id:Number;
		public var name:String;
		public var source:String;
		public var commonNameEnglish:String;
		public var commonNameGerman:String;
		public var commonNameSpanish:String;
		public var commonNameFreanch:String;
		public var genus:String;
		public var group:String;
		public var className:String;
		public var migrationType:String;
		public var cms:String;
		public var cms_link:String;
		public var red_list:String;
		public var cites:String;	
		public var chart:Object;
		
		public var geometry:MultiPolygon = new MultiPolygon();
		

		public function getBbox():LatLngBounds {			
			return geometry.getBBox();
		}
		
		public function getCenter():LatLng {
			return geometry.getCenter();	
		}
		
	}
}