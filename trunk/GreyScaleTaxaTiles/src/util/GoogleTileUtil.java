/**
 * 
 */
package util;

import java.awt.Point;
import java.awt.geom.Point2D;

/**
 * @author tim
 *
 */
public class GoogleTileUtil {

           /**
            * returns the lat/lng as an "Offset Normalized Mercator" pixel coordinate,
            * this is a coordinate that runs from 0..1 in latitude and longitude with 0,0 being
            * top left. Normalizing means that this routine can be used at any zoom level and
            * then multiplied by a power of two to get actual pixel coordinates.
            * @param lat in degrees
            * @param lng in degrees
            * @return
            */
        public static Point2D toNormalisedPixelCoords(double lat, double lng) {
           // first convert to Mercator projection
           // first convert the lat lon to mercator coordintes.
           if (lng > 180) {
              lng -= 360;
           }

           lng /= 360;
           lng += 0.5;

           lat = 0.5 - ((Math.log(Math.tan((Math.PI / 4) + ((0.5 * Math.PI * lat) / 180))) / Math.PI) / 2.0);

           return new Point2D.Double(lng, lat);
        }

        /**
         * returns a point that is a google tile reference for the tile containing the lat/lng and at the zoom level.
         * @param lat
         * @param lng
         * @param zoom
         * @return
         */
        public static Point toTileXY(double lat, double lng, int zoom) {
           Point2D normalised = toNormalisedPixelCoords(lat, lng);
           int scale = 1 << zoom;

           // can just truncate to integer, this looses the fractional "pixel offset"
           return new Point((int) (normalised.getX() * scale), (int) (normalised.getY() * scale));
        }   
        
}