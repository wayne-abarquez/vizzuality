package com.vizzuality.gmaps 
{
	import com.google.maps.LatLng;
	import com.google.maps.overlays.Marker;
	import com.google.maps.overlays.MarkerOptions;
	
	import flash.geom.Point;

	/**
	 * @author kelvinluck
	 */
	public class RunSingleMarkerHome extends Marker 
	{

		public function RunSingleMarkerHome(location:LatLng,name:String,id:Number,eventDate:String)
		{
			var options:MarkerOptions = new MarkerOptions();
			options.iconOffset = new Point(-15,-34);
			options.hasShadow = true;
			options.draggable = false;
			options.icon = new GenericMarkerIcon("markerIcon");
			
			//var html:String="<b>" + name + "</b> \n"+eventDate;
			//options.tooltip=name;
			
			
			super(location, options);
		}
	}
}