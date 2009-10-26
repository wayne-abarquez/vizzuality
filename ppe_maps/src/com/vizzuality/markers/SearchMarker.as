package com.vizzuality.markers
{
	import com.google.maps.LatLng;
	import com.google.maps.overlays.Marker;
	import com.google.maps.overlays.MarkerOptions;
	
	import flash.geom.Point;


        public class SearchMarker extends Marker
        {

                public function SearchMarker(location:LatLng,imageUrl:String,sites:int,isNeeded:Boolean)
                {
                        var options:MarkerOptions = new MarkerOptions();
                        options.iconOffset = new Point(0,0);
                        options.hasShadow = false;
                        options.draggable = false;
                        options.icon = new SearchMarkerIcon(imageUrl,sites,isNeeded);
                        super(location, options);
                }
        }
}