package
{
	import com.google.maps.InfoWindowOptions;
	import com.google.maps.LatLng;
	import com.google.maps.LatLngBounds;
	import com.google.maps.Map;
	import com.google.maps.MapEvent;
	import com.google.maps.MapMouseEvent;
	import com.google.maps.MapOptions;
	import com.google.maps.MapZoomEvent;
	import com.google.maps.controls.ControlPosition;
	import com.google.maps.controls.ZoomControl;
	import com.google.maps.controls.ZoomControlOptions;
	import com.google.maps.overlays.Marker;
	import com.google.maps.overlays.MarkerOptions;
	import com.google.maps.styles.FillStyle;
	import com.kelvinluck.gmaps.Clusterer;
	import com.vizzuality.gmaps.GenericMarkerIcon;
	import com.vizzuality.gmaps.RunMarkerCluster;
	import com.vizzuality.gmaps.RunSingleMarker;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.StyleSheet;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	
	import rosa.RosaSettings;
	import rosa.events.RosaEvent;
	import rosa.services.ServiceProxy;

	[SWF(backgroundColor=0xFFFFFF, width=257, height=194)]
	public class UserRacesMap extends Sprite
	{
		
		private var map:Map;
		[Embed('assets/cargandomapa1.png')] 
		private var loadingImg:Class;		
		private var imgLoading:Bitmap;
		private var square:Sprite;
		private var markers:Array;
		private var service:ServiceProxy;
		private var clusterer:Clusterer;
		private var attachedMarkers:Array;
		private var paramObj:Object;
						
		public function UserRacesMap()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;					
			
			imgLoading= new loadingImg() as Bitmap;
			imgLoading.x = 80;
			imgLoading.y = 20;
			imgLoading.width=100;
			imgLoading.height=100;
			
			mouseChildren = true;		
			
				
			initMap();
		}
		
		private function initMap():void {
			map=new Map();
			map.addEventListener(MapEvent.MAP_PREINITIALIZE, preinit);
			if(loaderInfo.url.indexOf("runnity.net")>=0) {
				map.key="ABQIAAAAtDJGVn6RztUmxjnX5hMzjRS5lFIZ4lX1ZuOUC3gMG9aTZZnVExRO7Xbt-wEBLhd43QE_x_w9pE80BQ";				
			} else
			if(loaderInfo.url.indexOf("runnity.com")>=0) {
				map.key="ABQIAAAAtDJGVn6RztUmxjnX5hMzjRTy9E-TgLeuCHEEJunrcdV8Bjp5lBTu2Rw7F-koeV8TrxpLHZPXoYd2BA";
			} else
			if(loaderInfo.url.indexOf("67.23.47.172")>=0) {
				map.key="ABQIAAAAtDJGVn6RztUmxjnX5hMzjRTGDsp2z8MalcroimtHohqExHETcBS4NC7BdwWef8UXYbVt7VWSNZ9bOQ";
			} else
			if(loaderInfo.url.indexOf("runnity.es")>=0) {
				map.key="ABQIAAAAtDJGVn6RztUmxjnX5hMzjRQK12cEqCNB3jyFRUdZAxcDvhADJRQn0mHTp4RIKJVv2RqDsWp8h9RPvA";				
			} else {
				map.key="ABQIAAAAtDJGVn6RztUmxjnX5hMzjRT2yXp_ZAY8_ufC3CFXhHIE1NvwkxSPLBWm1r4y_v-I6fII4c2FT0yK6w";
			}
			map.addEventListener(MapEvent.MAP_READY, onMapReady);
			map.setSize(new Point(257, 194));
			addChild(map);
			square = new Sprite();
			square.graphics.beginFill(0xFFFFFF);
			square.graphics.drawRect(0,0,257,152);
			square.graphics.endFill();
			square.x = 0;
			square.y = 0;			
			addChild(square);
			addChild(imgLoading);
		}		
		 
		private function preinit(ev:Event):void {
				var mo:MapOptions = new MapOptions();
				mo.backgroundFillStyle = new FillStyle({color:0xFFFFFF});
				map.setInitOptions(mo);
		}	
		
		private function onMapReady(event:MapEvent):void
		{
			var zco:ZoomControlOptions= new ZoomControlOptions({
				position:new ControlPosition(ControlPosition.ANCHOR_TOP_LEFT, 3, 3),
				hasScrollTrack:false
			});
			map.addControl(new ZoomControl(zco));
			downloadData();
		}	
		
		private function downloadData():void {
			with(RosaSettings) {
				localTestGatewayURL="/amfphp/gateway.php";
				gatewayURL = "/amfphp/gateway.php";
				
			}
			service = new ServiceProxy("RunnitServices");
			service.addEventListener(RosaEvent.RESPONSE, getUserRaces);
			service.getUserRaces(this.root.loaderInfo.parameters.id);
			//service.getUserRaces(25);
		}		
		
		private var iw:Dictionary=new Dictionary();
		private function getUserRaces(event:RosaEvent):void {
			markers = [];	
			var dataBbox:LatLngBounds=new LatLngBounds(); 
			if(event.result!=null) {
				for each(var m:Object in event.result as Array) {
					var p:LatLng = new LatLng(m.lat,m.lng);
					var marker:RunSingleMarker=new RunSingleMarker(p,m.name,m.id,m.event_date)
					iw[marker]=m;
					marker.addEventListener(MapMouseEvent.CLICK,function(e:MapMouseEvent):void {
						
						goToRunPage(e);
					});					
					markers.push(marker);
					dataBbox.extend(p);
				}
				clusterer = new Clusterer(markers, map.getZoom(),30);
				attachedMarkers = [];
				attachMarkers();	
				
				map.addEventListener(MapZoomEvent.ZOOM_CHANGED, onMapZoomChanged);
			}
			
			
			
			var options:MarkerOptions = new MarkerOptions();
			options.iconOffset = new Point(-10,-10);
			options.icon = new GenericMarkerIcon("markerIcon");
			if(event.result!=null) {
				if (markers.length>1) {
					map.setCenter(dataBbox.getCenter(),map.getBoundsZoomLevel(dataBbox));
				} else if(markers.length==1) {
					map.setCenter((markers[0] as Marker).getLatLng(),9);
				}
			}
			
			
			removeChild(imgLoading);	
			removeChild(square);	
			
		}	

		
		private function goToRunPage(e:MapMouseEvent):void {
			var m:Object = iw[e.target];
			navigateToURL(new URLRequest("/run/"+m.id+"/"+m.name.split(" ").join("/")),"_self");
		}			
		
		
		private function onMapZoomChanged(event:MapZoomEvent):void
		{
			map.closeInfoWindow();
			clusterer.zoom = map.getZoom();
			attachMarkers();
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
					marker.addEventListener(MapMouseEvent.CLICK,function(e:MapMouseEvent):void {
						map.zoomIn(e.latLng,true,false);
					});
					
				}
				map.addOverlay(marker);
				attachedMarkers.push(marker);
			}
		}			
		
	}
}