package com.vizzuality.markers 
{
	import com.google.maps.LatLng;
	import com.google.maps.overlays.Marker;
	import com.google.maps.overlays.MarkerOptions;
	
	import flash.geom.Point;

	public class SingleMarker extends Marker 
	{

		public function SingleMarker(location:LatLng,type:String)
			{
			var options:MarkerOptions = new MarkerOptions();
			options.iconOffset = new Point(0,0);
			options.hasShadow = false;
			options.draggable = false;
			switch(type)
			{
			    case 'muypoco':
			        options.icon = new GenericMarkerIcon('yellow');
			        break;
			    case 'poco':
			        options.icon = new GenericMarkerIcon('orange');
			        break;
			    case 'algo':
			        options.icon = new GenericMarkerIcon('darkorange');
			        break;
			    case 'mucho':
			        options.icon = new GenericMarkerIcon('red');
			        break;
			    case 'special':
			        options.icon = new GenericMarkerIcon('special');
			        break;
			}
			
			super(location, options);
				
		}
	}
}