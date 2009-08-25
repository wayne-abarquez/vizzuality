package com.vizzuality.gmaps 
{
	import com.google.maps.LatLng;
	import com.google.maps.overlays.Marker;
	import com.google.maps.overlays.MarkerOptions;
	
	import flash.geom.Point;

	/**
	 * @author kelvinluck
	 */
	public class RunSingleMarker extends Marker 
	{

		public function RunSingleMarker(location:LatLng,name:String,id:Number,eventDate:String)
		{
			var options:MarkerOptions = new MarkerOptions();
			options.iconOffset = new Point(-10,-10);
			options.hasShadow = true;
			options.draggable = false;
			options.icon = new CustomIconSprite();
			//options.icon = new RunSingleMarkerIcon();
			
			//var html:String="<b>" + name + "</b> \n"+eventDate;
			//options.tooltip=html;
			
			
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