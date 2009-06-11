package com.vizzuality.view.map.overlays
{
	import com.google.maps.LatLng;
	import com.google.maps.LatLngBounds;
	import com.google.maps.interfaces.IPane;
	import com.google.maps.overlays.Polygon;
	import com.google.maps.overlays.PolygonOptions;
	import com.vizzuality.utils.MapUtils;
	import com.vizzuality.view.map.MapController;

	public class MultiPolygon
	{
		public var polygons:Array=[];
		public var numPolygons:Number=0;
		private var bbox:LatLngBounds = new LatLngBounds();
		
		private var currentPane:IPane;
		
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
		
		
		public function addToMap(pane:Number):void {
			for each(var pol:Polygon in polygons) {
				switch(pane) {
					case 1:
						currentPane=MapController.gi().polygonPane1;
						
						break;
					case 2:
						currentPane=MapController.gi().polygonPane2;
						break;
					case 3:
						currentPane=MapController.gi().polygonPane3;
						break;
				}
				currentPane.addOverlay(pol);
			}
		}
		
		public function removeFromMap():void {
			for each(var pol:Polygon in polygons) {
				currentPane.removeOverlay(pol);
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