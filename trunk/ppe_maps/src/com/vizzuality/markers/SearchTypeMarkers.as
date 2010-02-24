package com.vizzuality.markers
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
                    	case 1: options.iconOffset = new Point(-14,-33); break;
                    	case 2: options.iconOffset = new Point(-19,-42); break;
                    	case 3: options.iconOffset = new Point(-23,-60);  break;
                    	default: break;
                    }

                    options.draggable = false;
                    options.hasShadow = false;
                    options.tooltip = ob.name as String;
                    options.icon = new SearchTypeMarkersIcon(ob,type); 
                    super(location, options);
                }
        }
}