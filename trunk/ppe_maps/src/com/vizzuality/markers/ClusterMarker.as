package com.vizzuality.markers 
{
	import com.google.maps.overlays.Marker;
	import com.google.maps.overlays.MarkerOptions;
	
	import flash.geom.Point;

	public class ClusterMarker extends Marker 
	{

		public function ClusterMarker(cluster:Array)
		{
			var options:MarkerOptions = new MarkerOptions();
			options.iconOffset = new Point(0,0);
			options.icon = new GenericMarkerIcon("clusterIcon",cluster.length.toString());
			options.hasShadow = false; 		
			
			super((cluster[0] as Marker).getLatLng(), options);
		}
	}
}