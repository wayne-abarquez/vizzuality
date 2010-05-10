package {
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
	import com.google.maps.styles.FillStyle;
	import com.kelvinluck.gmaps.Clusterer;
	import com.vizzuality.gmaps.RunMarkerClusterHome;
	import com.vizzuality.gmaps.RunSingleMarker;
	import com.vizzuality.gmaps.RunSingleMarkerHome;
	
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

	[SWF(backgroundColor=0xFFFFFF, width=939, height=364)]
	public class runnitHomeMap extends Sprite
	{
		
		private var map:Map;
		private var dataBbox:LatLngBounds;
		private var markers:Array;
		private var service:ServiceProxy;
		private var clusterer:Clusterer;
		private var attachedMarkers:Array;
		private var paramObj:Object;
		private var square:Sprite;
		
		
		[Embed('assets/cargandomapa1.png')] 
		private var loadingImg:Class;		
		private var imgLoading:Bitmap;
		
		public function runnitHomeMap()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;					
			
			imgLoading= new loadingImg() as Bitmap;
			imgLoading.x = 400;
			imgLoading.y = 80;
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
			if(loaderInfo.url.indexOf("runnity.es")>=0) {
				map.key="ABQIAAAAtDJGVn6RztUmxjnX5hMzjRQK12cEqCNB3jyFRUdZAxcDvhADJRQn0mHTp4RIKJVv2RqDsWp8h9RPvA";				
			} else
			if(loaderInfo.url.indexOf("67.23.47.172")>=0) {
				map.key="ABQIAAAAXucQwXp28TiGqramtQ-1nhTGDsp2z8MalcroimtHohqExHETcBT5ufo4NMa7ge3ZWP3vXPrzs4p00Q";				
			} else {
				map.key="ABQIAAAAXucQwXp28TiGqramtQ-1nhTGDsp2z8MalcroimtHohqExHETcBT5ufo4NMa7ge3ZWP3vXPrzs4p00Q";				
			}
			map.addEventListener(MapEvent.MAP_READY, onMapReady);
			map.setSize(new Point(939, 364));
			addChild(map);
			square = new Sprite();
			square.graphics.beginFill(0xFFFFFF);
			square.graphics.drawRect(0,0,939,364);
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
				position:new ControlPosition(ControlPosition.ANCHOR_TOP_LEFT, 10, 10)
			});
			map.addControl(new ZoomControl(zco));
			map.enableScrollWheelZoom();
			downloadData();

		}	
		
		private function onMapZoomChanged(event:MapZoomEvent):void
		{
			map.closeInfoWindow();
			clusterer.zoom = map.getZoom();
			attachMarkers();
		}			
		
		private function downloadData():void {
			with(RosaSettings) {
				localTestGatewayURL="http://localhost/amfphp/gateway.php";
				gatewayURL = "http://runnity.com/amfphp/gateway.php";
				
			}
			service = new ServiceProxy("RunnitServices");
			service.addEventListener("getAllRunsResult", getAllRunsResult);
			service.getAllRuns();
		}
		
		private function openInfoWindow(e:MapMouseEvent):void {
			
			var m:Object = iw[e.target];
			
			if (m.distance_text=="null")
				m.distance_text="";
			
			var titleFormat:TextFormat = new TextFormat();
			titleFormat.bold = true;
			var titleStyleSheet:StyleSheet = new StyleSheet();
			var contentFormat:TextFormat = new TextFormat("Arial", 10);
			var options:InfoWindowOptions = new InfoWindowOptions({

			  strokeStyle: {
			    color: 0x666666,
			    thickness:1
			  },
			  fillStyle: {
			    color: 0xFFFFFF,
			    alpha: 0.9
			  },
			  titleFormat: titleFormat,
			  titleStyleSheet: titleStyleSheet,
			  contentFormat: contentFormat,
			  width: 200,
			  cornerRadius: 3,
			  padding: 10,
			  hasCloseButton: false,
			  hasTail: true,
			  pointOffset:new Point(0,-10),
			  tailWidth: 20,
			  tailHeight: 18,
			  tailOffset: -22,
			  tailAlign: InfoWindowOptions.ALIGN_LEFT,
			  pointOffset: new Point(3, 8),
			  hasShadow: true,
			  title:m.name,
			  content:(m.event_date as String).substr(8,2) + '/' + 
			  	(m.event_date as String).substr(5,2) + '/' + (m.event_date as String).substr(0,4) + ' | ' + m.distance_text
			});
			map.openInfoWindow(e.latLng,options);
			
		}		
		
		private var iw:Dictionary=new Dictionary();
		private function getAllRunsResult(event:RosaEvent):void {
			markers = [];	
			dataBbox=new LatLngBounds();
			for each(var m:Object in event.result as Array) {
				var p:LatLng = new LatLng(m.lat,m.lon);
				var marker:RunSingleMarkerHome=new RunSingleMarkerHome(p,m.name,m.id,m.event_date)
				iw[marker]=m;
				marker.addEventListener(MapMouseEvent.CLICK,function(e:MapMouseEvent):void {
					
					goToRunPage(e);
				});
				marker.addEventListener(MapMouseEvent.ROLL_OVER, function(e:MapMouseEvent):void {
					openInfoWindow(e);									
				});
				marker.addEventListener(MapMouseEvent.ROLL_OUT, function(e:MapMouseEvent):void {
					map.closeInfoWindow();
				});						
				markers.push(marker);
				dataBbox.extend(p);
			}
			
			
			
			clusterer = new Clusterer(markers, map.getZoom(),30);
			attachedMarkers = [];
			attachMarkers();	
			
			map.addEventListener(MapZoomEvent.ZOOM_CHANGED, onMapZoomChanged);
			
			map.setCenter(dataBbox.getCenter(),map.getBoundsZoomLevel(dataBbox)-1);
				
			
			
			removeChild(imgLoading);	
			removeChild(square);	
			
		}
		
		private function goToRunPage(e:MapMouseEvent):void {
			var m:Object = iw[e.target];
			navigateToURL(new URLRequest("run/"+m.id+"/"+m.name.split(" ").join("/")),"_self");
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
					marker = new RunMarkerClusterHome(cluster);
					marker.addEventListener(MapMouseEvent.CLICK,function(e:MapMouseEvent):void {
						map.zoomIn(e.latLng,true,false);
					});
					marker.addEventListener(MapMouseEvent.ROLL_OVER, function(e:MapMouseEvent):void {
								var titleFormat:TextFormat = new TextFormat();
								titleFormat.bold = true;
								var titleStyleSheet:StyleSheet = new StyleSheet();
								var contentFormat:TextFormat = new TextFormat("Arial", 10);
								var options:InfoWindowOptions = new InfoWindowOptions({

								  strokeStyle: {
								    color: 0x666666,
								    thickness:1
								  },
								  fillStyle: {
								    color: 0xFFFFFF,
								    alpha: 0.9
								  },
								  titleFormat: titleFormat,
								  titleStyleSheet: titleStyleSheet,
								  contentFormat: contentFormat,
								  width: 200,
								  cornerRadius: 3,
								  padding: 2,
								  hasCloseButton: false,
								  hasTail: false,
								  pointOffset:new Point(0,-17),
								  tailWidth: 20,
								  tailHeight: 18,
								  tailOffset: -22,
								  tailAlign: InfoWindowOptions.ALIGN_LEFT,
								  pointOffset: new Point(3, 8),
								  hasShadow: false,
								  title:"Click para hacer ver más..."
								});
								map.openInfoWindow(e.latLng,options);
					});					
					marker.addEventListener(MapMouseEvent.ROLL_OUT, function(e:MapMouseEvent):void {
						map.closeInfoWindow();
					});
					
					
				}
				map.addOverlay(marker);
				attachedMarkers.push(marker);
			}
		}		
		
	}
}
