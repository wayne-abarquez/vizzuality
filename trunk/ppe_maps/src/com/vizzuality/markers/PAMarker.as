package com.vizzuality.markers
{
	import com.google.maps.LatLng;
	import com.google.maps.overlays.Marker;
	import com.google.maps.overlays.MarkerOptions;
	
	import flash.geom.Point;


        public class PAMarker extends Marker
        {

                public function PAMarker(location:LatLng)
                {
                        var options:MarkerOptions = new MarkerOptions();
                        options.iconOffset = new Point(0,0);
                        options.hasShadow = false;
                        options.draggable = false;
                        options.icon = new PAMarkerIcon('http://localhost:3000/images/thumbnails/thumb01.jpg');
                        super(location, options);
                }
        }
}