package com.vizzuality.gmaps 
{
	import com.google.maps.LatLng;
	import com.google.maps.overlays.Marker;
	import com.google.maps.overlays.MarkerOptions;

	/**
	 * @author kelvinluck
	 */
	public class RunSingleMarker extends Marker 
	{

		public function RunSingleMarker(location:LatLng)
		{
			var options:MarkerOptions = new MarkerOptions();
			options.hasShadow = false;
			options.draggable = false;
			options.icon = new RunSingleMarkerIcon();
			super(location, options);
		}
	}
}

import flash.display.Sprite;
internal class RunSingleMarkerIcon extends Sprite
{

	public function RunSingleMarkerIcon()
	{
		graphics.beginFill(0xff0000);
		graphics.drawCircle(0, 0, 6);
	}
}