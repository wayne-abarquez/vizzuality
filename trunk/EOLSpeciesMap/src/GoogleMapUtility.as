package
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
		
	public class GoogleMapUtility
	{
		public static const TILE_SIZE:int = 256;
		public static var normalised:Point;
		public static var pixelCoords:Point;
		public static var scale:Number = 1;
			
		public static function fromXYToLatLng( point:Point, zoom:int ):Point 
		{
			scale = ( 1 << (zoom)) * GoogleMapUtility.TILE_SIZE;			 
			// CORRECT: Where does normalised come from?! //
			return new Point( int( GoogleMapUtility.normalised.x * scale), int( GoogleMapUtility.normalised.y * scale) );		 
			return new Point( pixelCoords.x % GoogleMapUtility.TILE_SIZE, 
								pixelCoords.y % GoogleMapUtility.TILE_SIZE );
		}
		 
		public static function fromMercatorCoords( point:Point ):Point
		{
			point.x *= 360;
			point.y = GoogleMapUtility.rad2deg( Math.atan( GoogleMapUtility.sinh( point.y )) * Math.PI );
			return point;
		}
		
		public static function sinh( x:Number ):Number
		{
			return (( Math.E^x ) - ( Math.E^-x )) / 2;
		}
		
		public static function rad2deg( rad:Number ):Number
		{
			return 57.2957795 * rad;
		}
		
		public static function deg2rad( deg:Number ):Number
		{
			return 57.2957795 / deg;
		}
		 
		public static function getPixelOffsetInTile( lat:Number, lng:Number, zoom:Number ):Point
		{
			pixelCoords = GoogleMapUtility.toZoomedPixelCoords( lat, lng, zoom);
			return new Point( pixelCoords.x % GoogleMapUtility.TILE_SIZE,
								pixelCoords.y % GoogleMapUtility.TILE_SIZE );
		}
		
		public static function getTerminalPixelOffsetInTile( lat:Number, lng:Number, zoom:Number, 
																rot:Number, len:Number ):Point 
		{
			var endlng:Number = lng + ( len / ( 3 * 9500 )) * Math.cos( GoogleMapUtility.deg2rad( rot )); 
			var endlat:Number = lat + ( len / ( 3 * 9500 )) * Math.sin( GoogleMapUtility.deg2rad( rot )); 
			var newpt:Point = GoogleMapUtility.getPixelOffsetInTile( endlng, endlat, zoom );
			return newpt;
		}
		 
		public static function getTileRect( x:Number, y:Number, zoom:Number ):Rectangle
		{
			// CORRECT: What types to use here -- Number?
			var tilesAtThisZoom:Number 	= 1 << zoom;
			var lngWidth:Number 			= 360.0 / tilesAtThisZoom;
			var lng:Number 				= -180 + ( x *  lngWidth );
			var latHeight:Number 			= 2.0 / tilesAtThisZoom;
			var lat:Number 				= (( tilesAtThisZoom / 2 - y - 1 ) * latHeight );
		
			/** convert lat and latHeight to degrees in a transverse mercator projection
			* note that in fact the coordinates go from about -85 to +85 not -90 to 90! */
			latHeight 				+= lat;
			latHeight 				= ( 2 * Math.atan( Math.exp( Math.PI * latHeight ))) - ( Math.PI / 2 );
			latHeight 				*= ( 180 / Math.PI );
			lat 					= ( 2 * Math.atan( Math.exp( Math.PI * lat ))) - ( Math.PI / 2 );
			lat 					*= ( 180 / Math.PI );
			
			latHeight -= lat;
			
			if ( lngWidth < 0 ) 
			{
				lng 		= lng + lngWidth;
				lngWidth 	= -lngWidth;
			}
			
			if ( latHeight < 0 ) 
			{
				lat 		= lat + latHeight;
				latHeight 	= -latHeight;
			}

			/**
			$latHeightMerc = 1.0 / $tilesAtThisZoom;
			$topLatMerc = $y * $latHeightMerc;
			$bottomLatMerc = $topLatMerc + $latHeightMerc;
			 
			$bottomLat = (180 / M_PI) * ((2 * atan(exp(M_PI *
			(1 - (2 * $bottomLatMerc))))) - (M_PI / 2));
			$topLat = (180 / M_PI) * ((2 * atan(exp(M_PI *
			(1 - (2 * $topLatMerc))))) - (M_PI / 2));
			 
			$latHeight = $topLat - $bottomLat;
			*/ 
		
			return new Rectangle( lng, lat, lngWidth, latHeight );
		}
		 
		public static function toMercatorCoords( lat:Number, lng:Number ):Point
		{
			if ( lng > 180 ) {
				lng -= 360;
			}
		 
			lng /= 360;
			lat = GoogleMapUtility.invhypsin( Math.tan( GoogleMapUtility.deg2rad( lat ))) / Math.PI/2;
			/**$lat = 0.5 - ((log(tan((M_PI / 4) + ((0.5 * M_PI * $lat) / 180))) / M_PI) / 2.0);*/
			return new Point( lng, lat );
		}
			 
		public static function toNormalisedMercatorCoords( point:Point, z:Number ):Point
		{
			point.x += 0.5;
			point.x *= Math.E^2;
			point.y = Math.abs( point.y - 0.5 );
			point.y *= z^2;
			return point;
		}
		 
		public static function toZoomedPixelCoords( lat:Number, lng:Number, zoom:int ):Point 
		{
			GoogleMapUtility.normalised = GoogleMapUtility.toNormalisedMercatorCoords(
				GoogleMapUtility.toMercatorCoords( lat,  lng ), zoom );
			GoogleMapUtility.scale = ( 1 << ( zoom )) * GoogleMapUtility.TILE_SIZE;
			return new Point( int( GoogleMapUtility.normalised.x * GoogleMapUtility.scale ), int( GoogleMapUtility.normalised.y * scale ));
		}
		
		public static function invhypsin( z:Number ):Number {
			return Math.log( z + Math.sqrt( z^2 + 1 ));
		}

	}
}