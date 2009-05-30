package com.vizzuality.datatypes
{
	import com.google.maps.LatLng;
	import com.google.maps.LatLngBounds;
	import com.google.maps.overlays.Polygon;
	import com.google.maps.overlays.PolygonOptions;
	
	import gs.TweenLite;
	
	import mx.core.Application;

	public class MultiPolygon
	{
		public var polygons:Array=[]
		public var numPolygons:Number=0;
		private var bbox:LatLngBounds = new LatLngBounds();
		
		public function addEncodedPolygon(encodedPolyLines:Array,polygonOptions:PolygonOptions):void {
			var polygon:Polygon = Polygon.fromEncoded(encodedPolyLines,polygonOptions);
			polygons.push(polygon);	
			bbox.union(polygon.getLatLngBounds());
			numPolygons++;
		}
		
		public function addPolygon(polygon:Polygon):void {
			polygons.push(polygon);
			bbox.union(polygon.getLatLngBounds());
			numPolygons++;
		}
		
		public function getBBox():LatLngBounds {			
			return bbox;		
		}
		public function getCenter():LatLng {
			return bbox.getCenter();		
		}
		
		
		public function addToMapSmooth():void {
			for each(var pol:Polygon in polygons) {
				pol.foreground.alpha=0;
				Application.application.map.addOverlay(pol);
				TweenLite.to(pol.foreground,1.0,{alpha:0.8});								
			}
		}
		
		public function removeFromMap():void {
			for each(var pol:Polygon in polygons) {
				Application.application.map.removeOverlay(pol);
			}
		}
		
		
	}
}