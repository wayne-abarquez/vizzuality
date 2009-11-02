package com.vizzuality.markers 
{
	import com.google.maps.LatLng;
	import com.google.maps.overlays.Marker;
	import com.google.maps.overlays.MarkerOptions;
	
	import flash.geom.Point;

	public class SingleMarker extends Marker 
	{

		public function SingleMarker(location:LatLng,name:String,ago:String,type:String)
		{
			var options:MarkerOptions = new MarkerOptions();
			options.iconOffset = new Point(0,0);
			options.hasShadow = true;
			options.draggable = false;
			options.icon = new GenericMarkerIcon(type);

			super(location, options);
		}
	}
}