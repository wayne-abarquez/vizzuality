/** PolylineEncoder.as
 * This is a port of the Javascript class PolylineEncoder.js from Mark McClure
 * The original source, with comments, can be found at: 
 * http://facstaff.unca.edu/mcmcclur/GoogleMaps/EncodePolyline/PolylineEncoder.js
 * 
 * For more information check:
 * http://facstaff.unca.edu/mcmcclur/GoogleMaps/EncodePolyline/PolylineEncoderClass.html
 * 
 * 
 * Ported by Javier de la Torre (Vizzuality)
 */
 

package 
{
	import com.google.maps.LatLng;
	
	public class PolylineEncoder
	{
		
		public var numLevels:Number;
		public var zoomFactor:Number;
		public var verySmall:Number;
		public var forceEndpoints:Boolean;
		public var zoomLevelBreaks:Array;
		
		public function PolylineEncoder(numLevels:Number, zoomFactor:Number, verySmall:Number, forceEndpoints:Boolean) {
			  var i:Number;
			  if(!numLevels) {
			    numLevels = 18;
			  }
			  if(!zoomFactor) {
			    zoomFactor = 2;
			  }
			  if(!verySmall) {
			    verySmall = 0.00001;
			  }
			  if(!forceEndpoints) {
			    forceEndpoints = true;
			  }
			  this.numLevels = numLevels;
			  this.zoomFactor = zoomFactor;
			  this.verySmall = verySmall;
			  this.forceEndpoints = forceEndpoints;
			  this.zoomLevelBreaks = new Array(numLevels);
			  for(i = 0; i < numLevels; i++) {
			    this.zoomLevelBreaks[i] = verySmall*Math.pow(zoomFactor, numLevels-i-1);
			  }
		}
		
		// The main function.  Essentially the Douglas-Peucker
		// algorithm, adapted for encoding. Rather than simply
		// eliminating points, we record their from the
		// segment which occurs at that recursive step.  These
		// distances are then easily converted to zoom levels.		
		public function dpEncode(points:Array):Object {
			  var absMaxDist:Number = 0;
			  var stack:Array = [];
			  var dists:Array = new Array(points.length);
			  var maxDist:Number, maxLoc:Number, temp:Number, current:Array;
			  var i:Number, encodedPoints:String, encodedLevels:String;
			  var segmentLength:Number;
			  
			  if(points.length > 2) {
			    stack.push([0, points.length-1]);
			    while(stack.length > 0) {
			      current = stack.pop();
			      maxDist = 0;
			      segmentLength = Math.pow(points[current[1]].lat()-points[current[0]].lat(),2) + 
			        Math.pow(points[current[1]].lng()-points[current[0]].lng(),2);
			      for(i = current[0]+1; i < current[1]; i++) {
			        temp = this.distance(points[i], 
			          points[current[0]], points[current[1]],
			          segmentLength);
			        if(temp > maxDist) {
			          maxDist = temp;
			          maxLoc = i;
			          if(maxDist > absMaxDist) {
			            absMaxDist = maxDist;
			          }
			        }
			      }
			      if(maxDist > this.verySmall) {
			        dists[maxLoc] = maxDist;
			        stack.push([current[0], maxLoc]);
			        stack.push([maxLoc, current[1]]);
			      }
			    }
			  }
			  
			  encodedPoints = this.createEncodings(points, dists);
			  encodedLevels = this.encodeLevels(points, dists, absMaxDist);
			  return {
			    encodedPoints: encodedPoints,
			    encodedLevels: encodedLevels,
			    encodedPointsLiteral: encodedPoints.replace(/\\/g,"\\\\")
			  }
		}
		
		public function dpEncodeToJSON(points:Array, color:String, weight:Number, opacity:Number):Object {
		  var result:Object;
		  
		  if(!opacity) {
		    opacity = 0.9;
		  }
		  if(!weight) {
		    weight = 3;
		  }
		  if(!color) {
		    color = "#0000ff";
		  }
		  result = this.dpEncode(points);
		  return {
		    color: color,
		    weight: weight,
		    opacity: opacity,
		    points: result.encodedPoints,
		    levels: result.encodedLevels,
		    numLevels: this.numLevels,
		    zoomFactor: this.zoomFactor
		  }
		}		

		// distance(p0, p1, p2) computes the distance between the point p0
		// and the segment [p1,p2].  This could probably be replaced with
		// something that is a bit more numerically stable.
		public function distance(p0:LatLng, p1:LatLng, p2:LatLng, segLength:Number):Number {
		  var u:Number, out:Number;
		  
		  if(p1.lat() === p2.lat() && p1.lng() === p2.lng()) {
		    out = Math.sqrt(Math.pow(p2.lat()-p0.lat(),2) + Math.pow(p2.lng()-p0.lng(),2));
		  }
		  else {
		    u = ((p0.lat()-p1.lat())*(p2.lat()-p1.lat())+(p0.lng()-p1.lng())*(p2.lng()-p1.lng()))/
		      segLength;
		  
		    if(u <= 0) {
		      out = Math.sqrt(Math.pow(p0.lat() - p1.lat(),2) + Math.pow(p0.lng() - p1.lng(),2));
		    }
		    if(u >= 1) {
		      out = Math.sqrt(Math.pow(p0.lat() - p2.lat(),2) + Math.pow(p0.lng() - p2.lng(),2));
		    }
		    if(0 < u && u < 1) {
		      out = Math.sqrt(Math.pow(p0.lat()-p1.lat()-u*(p2.lat()-p1.lat()),2) +
		        Math.pow(p0.lng()-p1.lng()-u*(p2.lng()-p1.lng()),2));
		    }
		  }
		  return out;
		}

		// The createEncodings function is very similar to Google's
		// http://www.google.com/apis/maps/documentation/polyline.js
		// The key difference is that not all points are encoded, 
		// since some were eliminated by Douglas-Peucker.
		public function createEncodings(points:Array, dists:Array):String {
		  var i:Number, dlat:Number, dlng:Number;
		  var plat:Number = 0;
		  var plng:Number = 0;
		  var encoded_points:String = "";
		
		  for(i = 0; i < points.length; i++) {
		    if(dists[i] != undefined || i == 0 || i == points.length-1) {
		      var point:LatLng = points[i];
		      var lat:Number = point.lat();
		      var lng:Number = point.lng();
		      var late5:Number = Math.floor(lat * 1e5);
		      var lnge5:Number = Math.floor(lng * 1e5);
		      dlat = late5 - plat;
		      dlng = lnge5 - plng;
		      plat = late5;
		      plng = lnge5;
		      encoded_points += this.encodeSignedNumber(dlat) + 
		        this.encodeSignedNumber(dlng);
		    }
		  }
		  return encoded_points;
		}

		// This computes the appropriate zoom level of a point in terms of it's 
		// distance from the relevant segment in the DP algorithm.  Could be done
		// in terms of a logarithm, but this approach makes it a bit easier to
		// ensure that the level is not too large.
		public function computeLevel(dd:Number):Number {
		  var lev:Number;
		  if(dd > this.verySmall) {
		    lev=0;
		    while(dd < this.zoomLevelBreaks[lev]) {
		      lev++;
		    }
		    return lev;
		  }
		  return lev;
		}

		// Now we can use the previous function to march down the list
		// of points and encode the levels.  Like createEncodings, we
		// ignore points whose distance (in dists) is undefined.
		public function encodeLevels(points:Array, dists:Array, absMaxDist:Number):String {
		  var i:Number;
		  var encoded_levels:String = "";
		  if(this.forceEndpoints) {
		    encoded_levels += this.encodeNumber(this.numLevels-1)
		  } else {
		    encoded_levels += this.encodeNumber(
		      this.numLevels-this.computeLevel(absMaxDist)-1)
		  }
		  for(i=1; i < points.length-1; i++) {
		    if(dists[i] != undefined) {
		      encoded_levels += this.encodeNumber(
		        this.numLevels-this.computeLevel(dists[i])-1);
		    }
		  }
		  if(this.forceEndpoints) {
		    encoded_levels += this.encodeNumber(this.numLevels-1)
		  } else {
		    encoded_levels += this.encodeNumber(
		      this.numLevels-this.computeLevel(absMaxDist)-1)
		  }
		  return encoded_levels;
		}



		// This function is very similar to Google's, but I added
		// some stuff to deal with the double slash issue.
		public function encodeNumber(num:Number):String {
		  var encodeString:String = "";
		  var nextValue:Number, finalValue:Number;
		  while (num >= 0x20) {
		    nextValue = (0x20 | (num & 0x1f)) + 63;
		//     if (nextValue == 92) {
		//       encodeString += (String.fromCharCode(nextValue));
		//     }
		    encodeString += (String.fromCharCode(nextValue));
		    num >>= 5;
		  }
		  finalValue = num + 63;
		//   if (finalValue == 92) {
		//     encodeString += (String.fromCharCode(finalValue));
		//   }
		  encodeString += (String.fromCharCode(finalValue));
		  return encodeString;
		}
		
		// This one is Google's verbatim.
		public function encodeSignedNumber(num:Number):String {
		  var sgn_num:Number = num << 1;
		  if (num < 0) {
		    sgn_num = ~(sgn_num);
		  }
		  return(this.encodeNumber(sgn_num));
		}

		
		
	}
	
	
}