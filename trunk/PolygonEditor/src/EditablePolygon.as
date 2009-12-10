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
		private var markersDictionary:Dictionary=new Dictionary();
		public var polygon:Polygon;
		private var markersPane:IPane;
		
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
		
		private function createVertexMarker(latlng:LatLng):Marker {
			var m:Marker =  new Marker(latlng,
				new MarkerOptions({
				  icon: new CustomIconSprite(),
				  hasShadow: false,
				  clickable: true,
				  draggable: true,
				  gravity:0,
				  iconOffset: new Point(-5,-5)
				}));
			m.addEventListener(MapMouseEvent.DRAG_END,onMarkerDragEnd);
				
			return m;	
		}
		
		private function onMarkerDragEnd(event:MapMouseEvent):void {
			//update the array
			var pos:Number=0;
			for each(var ll:LatLng in polVertexes) {
				if(ll==markersDictionary[event.target]) {
					polVertexes[pos]=event.latLng;
					markersDictionary[event.target]=event.latLng;
					break
				}
				pos++;
			}
			refreshPolygon();
			
		}
		
		private function refreshPolygon():void {
			if(polVertexes.length>2) {
				if(polygon!=null)
					map.removeOverlay(polygon);	
				var tempArr:Array=polVertexes.concat();
				tempArr.push(polVertexes[0]);
				
				polygon = createPolygon(tempArr);
				map.addOverlay(polygon);
			}			
		}
		
 		private function updatePolygonMediumPoints(geome:Array):void {
			markersDictionary = new Dictionary();
			var latitude: Number;
			var longitude: Number;
			
			for (var i:Number=0; i<geome.length; i++) {
				var marker1:Marker = createVertexMarker(geome[i]);
				markersDictionary[marker1] =  geome[i];	
				
				//medium point			
				if ((i+1)!=geome.length){
					var medPoint: LatLng = new LatLng(((geome[i] as LatLng).lat() + (geome[i+1] as LatLng).lat())/2,((geome[i] as LatLng).lng() + (geome[i+1] as LatLng).lng())/2);
					var marker:Marker = createVertexMarker(medPoint);
					markersDictionary[marker] =  medPoint;					
				} else {
					var medPointLast: LatLng = new LatLng(((geome[i] as LatLng).lat() + (geome[0] as LatLng).lat())/2,((geome[i] as LatLng).lng() + (geome[0] as LatLng).lng())/2);
					var marker2:Marker = createVertexMarker(medPointLast);
					markersDictionary[marker2] =  medPointLast;
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
				map.addEventListener(MapMouseEvent.CLICK,onMapClick);
				for (var m:Object in markersDictionary) {
					markersPane.addOverlay(m as Marker);
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
				refreshPolygon();			
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
				map.removeEventListener(MapMouseEvent.CLICK,onMapClick);
				markersPane.clear();
				updatePolygonMediumPoints(polVertexes);
			}
		}
		
		private function onMapClick(event:MapMouseEvent):void {
			var marker:Marker = createVertexMarker(event.latLng);
			markersDictionary[marker] =  event.latLng;
			markersPane.addOverlay(marker);
			
			
			polVertexes.push(event.latLng);
			refreshPolygon();
			
			
		}
		
		
	}
}