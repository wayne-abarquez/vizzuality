/**
* Copyright 2009 Google Inc. 
* Licensed under the Apache License, Version 2.0:
*  http://www.apache.org/licenses/LICENSE-2.0
*/

package com.vizzuality.maps {

  import com.google.maps.LatLng;
  import com.google.maps.LatLngBounds;
  import com.google.maps.Map;
  import com.google.maps.interfaces.IPane;
  import com.google.maps.overlays.EncodedPolylineData;
  import com.google.maps.overlays.Polygon;
  import com.google.maps.overlays.PolygonOptions;
  import com.vizzuality.utils.MapUtils;

  /** 
  * MultiPolygonWithValue is a wrapper class for Flash Maps API polygons
  * that associates a multipolygon geometry with a numerical value.
  *   
  * @author Simon Ilyushchenko
  */  
  public class Multipolygon  {

	//data associated to the object
	public var data:Object = new Object();
    // List of Polygon objects comprising this object.
    private var polygons:Array = [];

    public function Multipolygon() {
    }

    /** 
    * Add a Polygon to the current list of polygons.
    * 
    * @param points Array of LatLng coordinates
    * @param options PolygonOptions 
    */  
    public function addPolygonFromLatLng(
        points:Array, options:PolygonOptions = null):void {
      var p:Polygon = new Polygon(points, options);
      polygons.push(p);
    }
  
    /** 
    * Add a Polygon constructed from encoded polylines
    * 
    * @param points Array of encoded polylines
    * @param options PolygonOptions 
    */  
    public function addPolygonFromEncoded(
        polylineList:Array, options:PolygonOptions = null):void {
      var p:Polygon = Polygon.fromEncoded(polylineList, options);
      polygons.push(p);
    }
  
    /** 
    * Add a Polygon constructed from a geojson object
    * 
    * @param geojsonMultiPolygon A geojson object
    * @param options PolygonOptions 
    */  
    

    public function fromGeojsonMultiPolygon(geojsonMultiPolygon:Object, options:PolygonOptions = null):void {
        
        
      var p:PolylineEncoder = new PolylineEncoder(18,2,0.00001,true);

        	
       //EACH POLYGON
      for each(var geojsonPolygon:Array in geojsonMultiPolygon) {
        //EACH LINE
        var encodedLines:Array = [];
        for each(var geojsonPoints:Array in geojsonPolygon) {
          var vertices:Array = [];
          //EACH VERTICE
          for each (var geojsonPoint:Array in geojsonPoints) {
            vertices.push(new LatLng(geojsonPoint[1], geojsonPoint[0]));
          }
          var verticesEncoded:Object = p.dpEncode(vertices);
          encodedLines.push(new EncodedPolylineData(verticesEncoded.encodedPoints, 2, verticesEncoded.encodedLevels, 18));
        }
        addPolygonFromEncoded(encodedLines,options);
      } 
    }
    
    
    
    /*private var encodedLines:Array = [];
    private var vertices: Array = [];
    private var i: Number = 0;
    private var j: Number = 0;
    private var k: Number = 0;
    private var _geojsonMultiPolygon: Object = new Object();
    private var _options: PolygonOptions = new PolygonOptions();
    private var firstTime:Boolean = true; */
    
/*     public function fromGeojsonMultiPolygon(geojsonMultiPolygon:Object, options:PolygonOptions = null):void {
 */        
/*         if (firstTime) {
        	this.addEventListener(Event.ENTER_FRAME,onEnterFrame);
        	_geojsonMultiPolygon = geojsonMultiPolygon;
        	_options = options;
        	firstTime = false;
        }
        
      	var p:PolylineEncoder = new PolylineEncoder(18,2,0.00001,true);
		for (i; i<(geojsonMultiPolygon as Array).length; i++) {
			for (j; j<((geojsonMultiPolygon[i] as Array)).length; j++) {
				for (k; k<(geojsonMultiPolygon[i][j] as Array).length;k++) {
					vertices.push(new LatLng((geojsonMultiPolygon[i][j] as Array)[1] as Number, (geojsonMultiPolygon[i][j] as Array)[0] as Number));
				}
			    var verticesEncoded:Object = p.dpEncode(vertices);
          		encodedLines.push(new EncodedPolylineData(verticesEncoded.encodedPoints, 2, verticesEncoded.encodedLevels, 18));
          		vertices = [];
			}
			addPolygonFromEncoded(encodedLines,options);
			encodedLines = [];
		}     */    
        
        	
/*        //EACH POLYGON
      for each(var geojsonPolygon:Array in geojsonMultiPolygon) {
        //EACH LINE
        var encodedLines:Array = [];
        for each(var geojsonPoints:Array in geojsonPolygon) {
          var vertices:Array = [];
          //EACH VERTICE
          for each (var geojsonPoint:Array in geojsonPoints) {
            vertices.push(new LatLng(geojsonPoint[1], geojsonPoint[0]));
          }
          var verticesEncoded:Object = p.dpEncode(vertices);
          encodedLines.push(new EncodedPolylineData(verticesEncoded.encodedPoints, 2, verticesEncoded.encodedLevels, 18));
        }
        addPolygonFromEncoded(encodedLines,options);
      } 
    }
    
    
    private function onEnterFrame(ev:Event):void {
    	
    } */
    
    
    

    /** 
    * Change polygon options on all constituent polygons
    */  
    public function setOptions(options:PolygonOptions):void {
      for each(var polygon:Polygon in polygons) {
        polygon.setOptions(options);
      }
    }

    /** 
    * Add an event listener to all constituent polygons
    */  
    public function addEventListener(eventType:String, f:Function):void {
      for each(var p:Polygon in polygons) {
        p.addEventListener(eventType, f);
      }
    }

    /** 
    * Remove an event listener from all constituent polygons
    */  
    public function removeEventListener(eventType:String, f:Function):void {
      for each(var p:Polygon in polygons) {
        p.removeEventListener(eventType, f);
      }
    }

    /** 
    * Add all constituent polygons to a map
    */  
    public function addToMap(map:Map): void {
      for each(var p:Polygon in polygons) {
        map.addOverlay(p);
      }
    }
    public function addToPane(pane:IPane): void {
      for each(var p:Polygon in polygons) {
        pane.addOverlay(p);
      }
    }

    /** 
    * Remove all constituent polygons from a map
    */  
    public function removeFromMap(map:Map): void {
      for each(var p:Polygon in polygons) {
        map.removeOverlay(p);
      }
    }
    
    public function getLatLngBounds():LatLngBounds {
      var bounds:LatLngBounds=new LatLngBounds();
      for each(var p:Polygon in polygons) {
        bounds.union(p.getLatLngBounds());
      }    	
      return bounds;
    }

	public function pointInPolygon(latlng:LatLng):Boolean {
		for each(var p:Polygon in polygons) {
			if (MapUtils.pointInPolygon(latlng,p))
				return true;
		}		
		return false;	
	}    
    
    
  }
}
