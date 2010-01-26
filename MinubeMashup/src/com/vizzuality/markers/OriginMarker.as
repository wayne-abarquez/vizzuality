package com.vizzuality.markers 
{
	import com.google.maps.LatLng;
	import com.google.maps.overlays.Marker;
	import com.google.maps.overlays.MarkerOptions;
	
	import flash.geom.Point;

	public class OriginMarker extends Marker 
	{

		public function OriginMarker(location:LatLng)
			{
			var options:MarkerOptions = new MarkerOptions();
			options.iconOffset = new Point(0,0);
			options.hasShadow = false;
			options.draggable = false;
			options.icon = new OriginMarkerIcon();
			super(location, options);
				
		}
	}
}