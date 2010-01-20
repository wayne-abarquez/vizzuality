package com.vizzuality.tests 
{
	import com.google.maps.overlays.Marker;
	import com.google.maps.overlays.MarkerOptions;
	
	import flash.geom.Point;

	public class SearchClusterMarker extends Marker 
	{
		public var clusterArray: Array = new Array();

		public function SearchClusterMarker(cluster:Array)
		{
			clusterArray = cluster;
			var options:MarkerOptions = new MarkerOptions();
			options.iconOffset = new Point(0,0);
			options.icon = new SearchClusterMarkerIcon(cluster.length.toString());
			options.hasShadow = false; 		
			
			super((cluster[0] as Marker).getLatLng(), options);
		}
	}
}