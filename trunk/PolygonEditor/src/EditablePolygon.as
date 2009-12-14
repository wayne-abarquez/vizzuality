package
{
	import com.google.maps.LatLng;
	import com.google.maps.Map;
	import com.google.maps.MapAction;
	import com.google.maps.MapMouseEvent;
	import com.google.maps.interfaces.IPane;
	import com.google.maps.overlays.Marker;
	import com.google.maps.overlays.MarkerOptions;
	import com.google.maps.overlays.Polygon;
	import com.google.maps.overlays.PolygonOptions;
	
	import flash.geom.Point;
	import flash.utils.Dictionary;

	public class EditablePolygon
	{
		
		public var polVertexes:Array;
		private var _editable:Boolean=false;
		private var vertexMarkerOptions:MarkerOptions;
		private var map:Map;
		private var markersDictionary:Dictionary = new Dictionary();
		private var comparativeDictionary: Dictionary = new Dictionary();
		private var arrayAllPoints: Array = new Array();
		private var mediumDictionary: Dictionary = new Dictionary();
		public var polygon:Polygon;
		private var markersPane:IPane;
		private var counter: Number = 0;
		private var pos:Number = 0;
		private var lastPointMarker: LatLng;
		
		public function EditablePolygon(_map:Map,points:Array=null, options:PolygonOptions=null)
		{
			map=_map;		
			
			if(points!=null)
				polygon = new Polygon(points,options);
				
			for each(var point:LatLng in points) {
				var marker:Marker = createVertexMarker(point);
				markersDictionary[marker] = point;
			}
			if (points!=null) {
				polVertexes=points;
			} else {
				polVertexes=[];
			}
			markersPane = map.getPaneManager().createPane();
			map.getPaneManager().placePaneAt(markersPane,
				map.getPaneManager().paneCount);
		}
		
		private function createVertexMarker(latlng:LatLng,medium:Boolean=false):Marker {
			var m:VizzMarker =  new VizzMarker(latlng,
				new MarkerOptions({
				  icon: new CustomIconSprite(),
				  hasShadow: false,
				  clickable: true,
				  draggable: true,
				  gravity:0,
				  iconOffset: new Point(-5,-5)
				}),medium);
			m.addEventListener(MapMouseEvent.DRAG_STEP,onMarkerDragMove);
			m.addEventListener(MapMouseEvent.DRAG_END,onMarkerDragEnd);
							
			return m;	
		}
		
		private function onMarkerDragMove(event:MapMouseEvent):void {

			var medium: Boolean = false;
			pos= 0;
			
			for each(var ll:LatLng in arrayAllPoints) {
				
				if(ll==mediumDictionary[event.target]) {
/* 					if ((event.target as VizzMarker).medium == true) {
						(event.target as VizzMarker).medium = false;
						
						 
					} */
					arrayAllPoints[pos]=event.latLng;
					mediumDictionary[event.target]=event.latLng;
					break;
				}
				pos++;
			}
			refreshPolygon(arrayAllPoints);

		}
		
		private function onMarkerDragEnd(event:MapMouseEvent):void {
			(event.target as VizzMarker).medium = true;
			(event.target as VizzMarker).setLatLng(event.latLng);
			
			
			var posAnt:Number;
			var posPos:Number;
			
			if (pos-1<0) {
				posAnt = arrayAllPoints.length-1;
			} else {
				posAnt = pos-1;
			}
			
			if (pos+1==arrayAllPoints.length) {
				posPos = 0;
			} else {
				posPos = pos + 1;
			}
			
			
			var medPointAnt: LatLng = /* intermediatePoint((arrayAllPoints[posAnt] as LatLng).lat(),(arrayAllPoints[posAnt] as LatLng).lng(),(event.latLng).lat(),(event.latLng).lng()); */
			new LatLng(((arrayAllPoints[posAnt] as LatLng).lat() + (event.latLng).lat())/2,((arrayAllPoints[posAnt] as LatLng).lng() + (event.latLng).lng())/2);
			var marker:Marker = createVertexMarker(medPointAnt,true);
			mediumDictionary[marker] = medPointAnt;
			markersPane.addOverlay(marker as VizzMarker);
			
			var medPointPos: LatLng = /* intermediatePoint((event.latLng).lat(),(event.latLng).lng(),(arrayAllPoints[posPos] as LatLng).lat(),(arrayAllPoints[posPos] as LatLng).lng()); */
			new LatLng(((event.latLng).lat() + (arrayAllPoints[posPos] as LatLng).lat())/2,((event.latLng).lng() + (arrayAllPoints[posPos] as LatLng).lng())/2);
			var marker2:Marker = createVertexMarker(medPointPos,true);
			mediumDictionary[marker2] = medPointPos;
			markersPane.addOverlay(marker2 as VizzMarker);

			arrayAllPoints.splice(pos,0,medPointAnt);
			arrayAllPoints.splice(pos+2,0,medPointPos);
		}
		
		
		private function refreshPolygon(vertexes:Array):void {
			
			try {
				polygon.removeEventListener(MapMouseEvent.CLICK,function (ev:MapMouseEvent):void {startEdit();});
				map.removeEventListener(MapMouseEvent.CLICK,function(ev:MapMouseEvent):void {stopEdit();});
			} catch (e:Error) {
			
			}
			
			if(vertexes.length>2) {
				if(polygon!=null)
					map.removeOverlay(polygon);	
				var tempArr:Array=vertexes.concat();
				tempArr.push(vertexes[0]);
				
				polygon = createPolygon(tempArr);
 				polygon.addEventListener(MapMouseEvent.CLICK,function (ev:MapMouseEvent):void {startEdit();});
				map.addEventListener(MapMouseEvent.CLICK,function(ev:MapMouseEvent):void {stopEdit();});
				map.addOverlay(polygon);
			}			
		}
		
 		private function updatePolygonMediumPoints(geome:Array):void {
 			
			arrayAllPoints = [];
			mediumDictionary = new Dictionary();
			var latitude: Number;
			var longitude: Number;
			var obj: Object;

			for(var i:Number=0; i<geome.length; i++) {
				var marker1:Marker = createVertexMarker(geome[i]);
				mediumDictionary[marker1] = geome[i]; 
				arrayAllPoints.push(geome[i]);	
				
				//medium point			
				if ((i+1)!=geome.length){
					var medPoint: LatLng = /* intermediatePoint((geome[i] as LatLng).lat(),(geome[i] as LatLng).lng(),(geome[i+1] as LatLng).lat(),(geome[i+1] as LatLng).lng()); */
					new LatLng(((geome[i] as LatLng).lat() + (geome[i+1] as LatLng).lat())/2,((geome[i] as LatLng).lng() + (geome[i+1] as LatLng).lng())/2);
					var marker:Marker = createVertexMarker(medPoint,true);
					mediumDictionary[marker] = medPoint; 
					arrayAllPoints.push(medPoint);	
				} else {
					var medPointLast: LatLng = /* intermediatePoint((geome[i] as LatLng).lat(),(geome[i] as LatLng).lng(),(geome[0] as LatLng).lat(),(geome[0] as LatLng).lng()); */
 					new LatLng(((geome[i] as LatLng).lat() + (geome[0] as LatLng).lat())/2,((geome[i] as LatLng).lng() + (geome[0] as LatLng).lng())/2);			
					var marker2:Marker = createVertexMarker(medPointLast,true);
					mediumDictionary[marker2] = medPointLast;
					arrayAllPoints.push(medPointLast);
					trace('último punto: lat->' + geome[i].lat() + '  lng->' + geome[i].lng());
					trace('primer punto: lat->' + geome[0].lat() + '  lng->' + geome[0].lng());
					trace('punto intermedio: lat->' + medPointLast.lat() + '  lng->' + medPointLast.lng());
				}
			}
		}
		
		private function createPolygon(vertex:Array):Polygon {
			var pOps:PolygonOptions = new PolygonOptions({geodesic:true});
			var p:Polygon = new Polygon(vertex,pOps);
			return p;
		}
		
		public function startEdit():void {
			if(!_editable) {
				_editable=true;
				map.useHandCursor=true;
				map.buttonMode=true;
				for (var mar:Object in mediumDictionary) {
					markersPane.addOverlay(mar as VizzMarker);
				}
			}
			
		}
		
		public function startDrawing():void {
			map.disableDragging();
			map.setDoubleClickMode(MapAction.ACTION_NOTHING);
		  	map.addEventListener(MapMouseEvent.MOUSE_DOWN,onStartDrawing);
		  	map.addEventListener(MapMouseEvent.MOUSE_UP,onStopDrawing);	
		  	_editable=true;			
			map.useHandCursor=true;
			map.buttonMode=true;		  	
		}		
		
		private function onStartDrawing(event:MapMouseEvent):void {
			map.addEventListener(MapMouseEvent.MOUSE_MOVE,whileDrawing);
		}
		
		private function whileDrawing(event:MapMouseEvent):void {
			var marker:Marker = createVertexMarker(event.latLng);
			markersDictionary[marker] =  event.latLng;
			markersPane.addOverlay(marker);
			polVertexes.push(event.latLng);
			refreshPolygon(polVertexes);			
		}
		
		private function onStopDrawing(event:MapMouseEvent):void {
			map.removeEventListener(MapMouseEvent.MOUSE_MOVE,whileDrawing);
			map.removeEventListener(MapMouseEvent.MOUSE_DOWN,onStartDrawing);
			map.removeEventListener(MapMouseEvent.MOUSE_UP,onStopDrawing);	
			map.enableDragging();
			map.setDoubleClickMode(MapAction.ACTION_PAN_ZOOM_IN);
			stopEdit();
		}		
		
		public function stopEdit():void {
			if(_editable) {
				_editable=false;
				map.useHandCursor=false;
				map.buttonMode=false;				
				markersPane.clear();
				
				if (!isEmptyDictionary(mediumDictionary)) {
					polVertexes = new Array();
					for (var i:Number=0; i<arrayAllPoints.length;i++) {
						if (i % 2 !=1) {
							polVertexes.push(arrayAllPoints[i] as LatLng);
						}
					}
				}
				
				updatePolygonMediumPoints(polVertexes);
			}
		}	
		
		private function isEmptyDictionary(dict:Dictionary):Boolean {
		    for each(var obj:Object in dict)
		    {
		        if(obj != null)
		        {
		           return false
		        }
		    }
		    return true;
		 }
		 
		 private function intermediatePoint(la1:Number, lo1:Number, la2:Number, lo2:Number):LatLng {
		 	
			/*var d:Number = Math.acos(Math.sin(lat1)*Math.sin(lat2)+Math.cos(lat1)*Math.cos(lat2)*Math.cos(lon1-lon2));
		 	var f:Number = 0.5;
		 	
 	        var A:Number = Math.sin((1-f)*d)/Math.sin(d);
	        var B:Number = Math.sin(f*d)/Math.sin(d);
	        var x:Number = A*Math.cos(lat1)*Math.cos(lon1) +  B*Math.cos(lat2)*Math.cos(lon2);
	        var y:Number = A*Math.cos(lat1)*Math.sin(lon1) +  B*Math.cos(lat2)*Math.sin(lon2);
	        var z:Number = A*Math.sin(lat1) + B*Math.sin(lat2);
	        var lat:Number = Math.atan2(z,Math.sqrt(x*x+y*y));
	        var lon:Number = Math.atan2(y,x); */
	
		 	
			var lat1:Number = la1*Math.PI/180
			var lng1:Number = lo1*Math.PI/180;
			var lat2:Number = la2*Math.PI/180;
			var lng2:Number = lo2*Math.PI/180;
			var d:Number = 2*Math.asin(Math.sqrt(Math.pow((Math.sin((lat1-lat2)/2)),2)+Math.cos(lat1)*Math.cos(lat2)*Math.pow(Math.sin((lng1-lng2)/2),2)));
			var A:Number = Math.sin((1-0.5)*d)/Math.sin(d);
			var B:Number = Math.sin(0.5*d)/Math.sin(d);
			var x:Number = A*Math.cos(lat1)*Math.cos(lng1)+B*Math.cos(lat2)*Math.cos(lng2);
			var y:Number = A*Math.cos(lat1)*Math.sin(lng1)+B*Math.cos(lat2)*Math.sin(lng2);
			var z:Number = A*Math.sin(lat1)+B*Math.sin(lat2);
			var lat:Number = Math.atan2(z,Math.sqrt(Math.pow(x,2)+Math.pow(y,2)))*180/Math.PI;
			var lng:Number = Math.atan2(y,x)*180/Math.PI;
			
			return new LatLng(lat,lng);
		}
		
	}
}