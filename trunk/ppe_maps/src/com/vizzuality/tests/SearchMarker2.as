package com.vizzuality.tests
{
	import com.google.maps.LatLng;
	import com.google.maps.overlays.Marker;
	import com.google.maps.overlays.MarkerOptions;
	
	import flash.geom.Point;


        public class SearchMarker2 extends Marker
        {
        	public var markerData: Object = new Object();

                public function SearchMarker2(location:LatLng,ob:Object)
                {
                		markerData = ob;
                        var options:MarkerOptions = new MarkerOptions();
                        options.iconOffset = new Point(-16,-40);
                        options.hasShadow = true;
                        options.draggable = false;
                        options.icon = new SearchMarkerIcon2(ob);
                        super(location, options);
                }
        }
}