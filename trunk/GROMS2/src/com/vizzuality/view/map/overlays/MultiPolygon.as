package com.vizzuality.view.map.overlays
{
	import com.google.maps.LatLng;
	import com.google.maps.LatLngBounds;
	import com.google.maps.overlays.Polygon;
	import com.google.maps.overlays.PolygonOptions;
	import com.vizzuality.utils.MapUtils;
	import com.vizzuality.view.map.MapController;

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
		
		
		public function addToMap():void {
			for each(var pol:Polygon in polygons) {
				MapController.gi().polygonPane.addOverlay(pol);
			}
		}
		
		public function removeFromMap():void {
			for each(var pol:Polygon in polygons) {
				MapController.gi().polygonPane.removeOverlay(pol);
			}
		}
		
		public function pointInPolygon(latlng:LatLng):Boolean {
			for each(var pol:Polygon in polygons) {
				if (MapUtils.pointInPolygon(latlng,pol))
					return true;
			}		
			return false;	
		}
		
		
	}
}