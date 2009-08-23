package {
	import com.google.maps.LatLng;
	import com.google.maps.LatLngBounds;
	import com.google.maps.Map;
	import com.google.maps.MapEvent;
	import com.google.maps.MapMouseEvent;
	import com.google.maps.MapZoomEvent;
	import com.google.maps.controls.ZoomControl;
	import com.google.maps.overlays.Marker;
	import com.kelvinluck.gmaps.Clusterer;
	import com.vizzuality.gmaps.RunMarkerCluster;
	import com.vizzuality.gmaps.RunSingleMarker;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import rosa.RosaSettings;
	import rosa.events.RosaEvent;
	import rosa.services.ServiceProxy;

	public class runnitHomeMap extends Sprite
	{
		
		private var map:Map;
		private var dataBbox:LatLngBounds;
		private var markers:Array;
		private var service:ServiceProxy;
		private var clusterer:Clusterer;
		private var attachedMarkers:Array;
		
		public function runnitHomeMap()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;			
			initMap();
		}
		
		
		private function initMap():void {
			map=new Map();
			map.key="ABQIAAAA2XCui2FzpSGWKrct5KK6RhRcXjnLaBx2ctMiRTh7Mhofu8jzCBQJQ8S8l6RXUyxznpv5HYxfT89CLg";
			map.addEventListener(MapEvent.MAP_READY, onMapReady);
			map.setSize(new Point(939, 364));
			addChild(map);
		}
		
		private function onMapReady(event:MapEvent):void
		{
			map.addControl(new ZoomControl());
			map.enableScrollWheelZoom();
			downloadData();

		}	
		
		private function onMapZoomChanged(event:MapZoomEvent):void
		{
			clusterer.zoom = map.getZoom();
			attachMarkers();
		}			
		
		private function downloadData():void {
			with(RosaSettings) {
				localTestGatewayURL="http://localhost/amfphp/gateway.php";
				gatewayURL = "http://localhost/amfphp/gateway.php";
				
			}
			service = new ServiceProxy("RunnitServices");
			service.addEventListener("getAllRunsResult", getAllRunsResult);
			service.getAllRuns();
		}
		
		private function getAllRunsResult(event:RosaEvent):void {
			markers = [];	
			dataBbox=new LatLngBounds();
			for each(var m:Object in event.result as Array) {
				var p:LatLng = new LatLng(m.lat,m.lon);
				var marker:RunSingleMarker=new RunSingleMarker(p,m.name,m.id,m.event_date)
				marker.addEventListener(MapMouseEvent.CLICK,function(e:MapMouseEvent):void {
					goToRunPage(m.id);
				});
				markers.push(marker);
				dataBbox.extend(p);
			}
			
			
			
			clusterer = new Clusterer(markers, map.getZoom(),30);
			attachedMarkers = [];
			attachMarkers();	
			
			map.addEventListener(MapZoomEvent.ZOOM_CHANGED, onMapZoomChanged);
			map.setCenter(dataBbox.getCenter(),map.getBoundsZoomLevel(dataBbox));
			
		}
		
		private function goToRunPage(id:Number):void {
			navigateToURL(new URLRequest("carrera.php?id="+id),"_self");
		}
		
		private function attachMarkers():void
		{
			for each (var marker:Marker in attachedMarkers) {
				map.removeOverlay(marker);
			}
			attachedMarkers = [];
			var clusteredMarkers:Array = clusterer.clusters;
 
			for each (var cluster:Array in clusteredMarkers) {
				if (cluster.length == 1) {
					// there is only a single marker in this cluster
					marker = cluster[0];
				} else {
					marker = new RunMarkerCluster(cluster);
				}
				map.addOverlay(marker);
				attachedMarkers.push(marker);
			}
		}		
		
	}
}
