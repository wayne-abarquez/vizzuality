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
					//cambiar en el poligono array
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
			
			
			var medPointAnt: LatLng = new LatLng(((arrayAllPoints[posAnt] as LatLng).lat() + (event.latLng).lat())/2,((arrayAllPoints[posAnt] as LatLng).lng() 
			+ (event.latLng).lng())/2);
			var marker:Marker = createVertexMarker(medPointAnt,true);
			mediumDictionary[marker] = medPointAnt;
			markersPane.addOverlay(marker as VizzMarker);
			
			var medPointPos: LatLng = new LatLng(((event.latLng).lat() + (arrayAllPoints[posPos] as LatLng).lat())/2,((event.latLng).lng() 
			+ (arrayAllPoints[posPos] as LatLng).lng())/2);
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
					var medPoint: LatLng = new LatLng(((geome[i] as LatLng).lat() + (geome[i+1] as LatLng).lat())/2,((geome[i] as LatLng).lng() + (geome[i+1] as LatLng).lng())/2);
					var marker:Marker = createVertexMarker(medPoint,true);
					mediumDictionary[marker] = medPoint; 
					arrayAllPoints.push(medPoint);	
				} else {
					var medPointLast: LatLng = new LatLng(((geome[i] as LatLng).lat() + (geome[0] as LatLng).lat())/2,((geome[i] as LatLng).lng() + (geome[0] as LatLng).lng())/2);
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
			var p:Polygon = new Polygon(vertex);
			return p;
		}
		
		public function startEdit():void {
			if(!_editable) {
				_editable=true;
				map.useHandCursor=true;
				map.buttonMode=true;
				/* map.addEventListener(MapMouseEvent.CLICK,onMapClick); */
/* 				for (var m:Object in markersDictionary) {
					markersPane.addOverlay(m as Marker);
				} */
				
				//add medium points to the map
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
			//if(Application.application.isInLand) {
				var marker:Marker = createVertexMarker(event.latLng);
				markersDictionary[marker] =  event.latLng;
				markersPane.addOverlay(marker);
				
				
				polVertexes.push(event.latLng);
				refreshPolygon(polVertexes);			
			//}
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
/* 				map.removeEventListener(MapMouseEvent.CLICK,onMapClick); */
				markersPane.clear();
				updatePolygonMediumPoints(polVertexes);
			}
		}
		
/* 		private function onMapClick(event:MapMouseEvent):void {
			var marker:Marker = createVertexMarker(event.latLng);
			markersDictionary[marker] =  event.latLng;
			markersPane.addOverlay(marker);
			
			
			polVertexes.push(event.latLng);
			refreshPolygon();
			
			
		} */
		
		
	}
}