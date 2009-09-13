package com.vizzuality.gmaps 
{
	import com.google.maps.overlays.Marker;
	import com.google.maps.overlays.MarkerOptions;
	
	import flash.geom.Point;

	/**
	 * @author kelvinluck
	 */
	public class RunMarkerCluster extends Marker 
	{

		public function RunMarkerCluster(cluster:Array)
		{
			var options:MarkerOptions = new MarkerOptions();
			options.iconOffset = new Point(-15,-34);
			options.icon = new GenericMarkerIcon("raceNoActiveEmpty",cluster.length.toString());
			options.hasShadow = false; 		
			options.tooltip="Click para acercar";
			
			super((cluster[0] as Marker).getLatLng(), options);
		}
	}
}