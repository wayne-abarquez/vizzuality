package com.vizzuality.markers
{
	import com.google.maps.LatLng;
	import com.google.maps.overlays.Marker;
	import com.google.maps.overlays.MarkerOptions;
	
	import flash.geom.Point;


        public class PredefinedPaPageMarker extends Marker
        {

                public function PredefinedPaPageMarker(location:LatLng,url:String)
                {
                    var options:MarkerOptions = new MarkerOptions();
                    options.iconOffset = new Point(-23,-60);
                    

                    options.draggable = false;
                    options.hasShadow = false;
                    options.icon = new PredefinedPaPageMarkerIcon(url); 
                    super(location, options);
                }
        }
}