package 
{
	import com.google.maps.LatLng;
	import com.google.maps.overlays.Polygon;
	import com.google.maps.overlays.PolygonOptions;
	import com.google.maps.styles.FillStyle;
	import com.google.maps.styles.StrokeStyle;
	
	public final class MapUtils
	{
	
        /**
         * Add a circle to the global variable "map". This function won't work for circles that encompass
         * the North or South Pole. Also, there is a slight distortion in the upper-left, upper-right,
         * lower-left, and lower-right sections of the circle that worsens as it gets larger and/or closer
         * to a pole.
         * @param lat Latitude in degrees
         * @param lng Longitude in degrees
         * @param radius Radius of the circle in statute miles
         * @param {Number} strokeColor Color of the circle outline in HTML hex style, e.g. 0xFF0000
         * @param strokeWidth Width of the circle outline in pixels
         * @param strokeOpacity Opacity of the circle outline between 0.0 and 1.0
         * @param {Number} fillColor Color of the inside of the circle in HTML hex style, e.g. 0xFF0000
         * @param fillOpacity Opacity of the inside of the circle between 0.0 and 1.0
         */
        public static function drawCircle(
                            lat:Number, lng:Number, radius:Number, 
                            strokeColor:Number, strokeWidth:Number, strokeOpacity:Number, 
                            fillColor:Number, fillOpacity:Number):Polygon {

            var d2r:Number = Math.PI/180;
            var r2d:Number = 180/Math.PI;
            var circleLat:Number = radius * 0.014483;  // Convert statute miles into degrees latitude
            var circleLng:Number = circleLat/Math.cos(lat*d2r); 
            var circleLatLngs:Array = new Array();
            for (var i:Number = 0; i < 66; i++) { 
                var theta:Number = Math.PI * (i/32); 
                var vertexLat:Number = lat + (circleLat * Math.sin(theta)); 
                var vertexLng:Number = lng + (circleLng * Math.cos(theta)); 
                var latLng:LatLng = new LatLng(vertexLat, vertexLng); 
                circleLatLngs.push(latLng); 
            }
          
            var polygonOptions:PolygonOptions = new PolygonOptions();
            var fillStyle:FillStyle = new FillStyle();
            fillStyle.alpha = fillOpacity;
            fillStyle.color = fillColor;
            polygonOptions.fillStyle = fillStyle; 
    
            var strokeStyle:StrokeStyle = new StrokeStyle();
            strokeStyle.alpha = strokeOpacity;
            strokeStyle.color = strokeColor;
            strokeStyle.thickness = strokeWidth;
            polygonOptions.strokeStyle = strokeStyle
    
            var polygon:Polygon = new Polygon(circleLatLngs, polygonOptions);
            
            return polygon;
        }	
        
		public static function pointInPolygon(point:LatLng,polygon:Polygon):Boolean { 
	        var j:Number=0; 
	        var func_oddNodes:Boolean = false; 
	        var x:Number = point.lng(); 
	        var y:Number = point.lat(); 
	        for (var i:Number=0; i < polygon.getOuterVertexCount(); i++) { 
	          j++; 
	          if (j == polygon.getOuterVertexCount()) {j = 0;} 
	          if (((polygon.getOuterVertex(i).lat() < y) && (polygon.getOuterVertex(j).lat() >= y)) 
	          || ((polygon.getOuterVertex(j).lat() < y) && 
				(polygon.getOuterVertex(i).lat() >= y))) { 
	            if ( polygon.getOuterVertex(i).lng() + (y - polygon.getOuterVertex(i).lat()) 
	            /  (polygon.getOuterVertex(j).lat()-polygon.getOuterVertex(i).lat()) 
	            *  (polygon.getOuterVertex(j).lng() - polygon.getOuterVertex(i).lng())<x ) { 
	              func_oddNodes = !func_oddNodes 
	            } 
	          } 
	        } 
	        return func_oddNodes; 
	      } 
		

	}
}