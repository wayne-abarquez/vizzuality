package com.vizzuality.lastTest
{
	import com.google.maps.LatLng;
	import com.google.maps.overlays.Marker;
	import com.google.maps.overlays.MarkerOptions;
	
	import flash.geom.Point;


        public class SearchTypeMarkers extends Marker
        {
        	public var markerData: Object = new Object();

                public function SearchTypeMarkers(location:LatLng,ob:Object,type:Number)
                {
                		markerData = ob;
                        var options:MarkerOptions = new MarkerOptions();
                         switch (type) {
                        	case 1: options.iconOffset = new Point(-14,-18);
                        	case 2: options.iconOffset = new Point(-19,-43);
                        	case 3: options.iconOffset = new Point(-23,-60);
                        	default: break;
                        }
                        options.hasShadow = true;
                        options.draggable = false;
                         options.icon = new SearchTypeMarkersIcon(ob,type); 
                        super(location, options);
                }
        }
}