package com.vizzuality.markers 
{
	import com.google.maps.LatLng;
	import com.google.maps.overlays.Marker;
	import com.google.maps.overlays.MarkerOptions;
	
	import flash.geom.Point;

	public class InfoMarker extends Marker 
	{
		public var color: String;
		public function InfoMarker(location:LatLng,city:String,precio:String,type:String)
			{
			var options:MarkerOptions = new MarkerOptions();
			options.iconOffset = new Point(0,0);
			options.hasShadow = false;
			options.draggable = false;
			switch(type)
			{
			    case 'muypoco':
			    	color = "yellow";
			        options.icon = new GenericMarkerInfoIcon(color,city,precio);
			        break;
			    case 'poco':
			    	color = "orange";
			        options.icon = new GenericMarkerInfoIcon(color,city,precio);
			        break;
			    case 'algo':
			    	color = "darkorange";
			        options.icon = new GenericMarkerInfoIcon(color,city,precio);
			        break;
			    case 'mucho':
			    	color = "red";
			        options.icon = new GenericMarkerInfoIcon(color,city,precio);
			        break;
			}
			
			super(location, options);
				
		}
	}
}