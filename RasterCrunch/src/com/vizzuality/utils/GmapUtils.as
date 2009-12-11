package com.vizzuality.utils
{
	import com.google.maps.LatLng;
	
	public class GmapUtils
	{		
		public static function getTileLatLong(x:Number,y:Number,zoom:Number,posX:Number,posY:Number):LatLng {
			
     		var lon:Number      = -180; // x 
      		var lonWidth:Number = 360; // width 360 
	      	var lat:Number       = -1; 
	      	var latHeight:Number = 2; 
	      	var tilesAtThisZoom:Number = 1 << zoom; 
	      	if(zoom==0)
	      		tilesAtThisZoom=1;
	      		
	      	lonWidth  = 360.0 / tilesAtThisZoom; 
	      	lon       = -180 + (x * lonWidth); 
	      	latHeight = -2.0 / tilesAtThisZoom; 
	      	lat       = 1 + (y * latHeight); 
	      	
	      	// convert lat and latHeight to degrees in a mercator projection 
	      	// note that in fact the coordinates go from 
	      	// about -85 to +85 not -90 to 90! 
	      	latHeight += lat; 
	      	latHeight = (2 * Math.atan(Math.exp(Math.PI * latHeight))) - (Math.PI / 2); 
	      	latHeight *= (180 / Math.PI); 
	      	lat = (2 * Math.atan(Math.exp(Math.PI * lat))) - (Math.PI / 2); 
	      	lat *= (180 / Math.PI); 
	      	latHeight -= lat; 
	      	if (lonWidth < 0) { 
	         	lon      = lon + lonWidth; 
	         	lonWidth = -lonWidth; 
	      	} 
	      	if (latHeight < 0) { 
	         	lat       = lat + latHeight; 
	         	latHeight = -latHeight; 
	      	} 
	      	
	      	var pixelsLonWidth:Number = lonWidth/256;
	      	var pixelsLatHeight:Number = latHeight/256;
	      	
	      	return new LatLng(lat+(pixelsLatHeight*posY),lon+(pixelsLonWidth*posX));
	      	//return new LatLng(lat,lon);
	      	
		}
	}
}