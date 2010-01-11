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
/* 			var dateNow: Date = new Date();
			var raceDate: Date = new Date();
			raceDate.setFullYear(Number(eventDate.slice(0,4)),Number(eventDate.slice(5,7))-1,Number(eventDate.slice(8,10)));
 			raceDate.setHours(Number(eventDate.slice(11,13)),Number(eventDate.slice(14,16)),Number(eventDate.slice(17,19)));
 			
			if (raceDate<dateNow){
				options.icon = new GenericMarkerIcon("oldRaces");
			} else { */
				options.icon = new GenericMarkerIcon("markerIcon");
/* 			} */
			
			
			
			//var html:String="<b>" + name + "</b> \n"+eventDate;
			//options.tooltip=name;
			
			
			super(location, options);
		}
	}
}