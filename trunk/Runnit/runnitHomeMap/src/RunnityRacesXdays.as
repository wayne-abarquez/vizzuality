package {
	import com.google.maps.InfoWindowOptions;
	import com.google.maps.LatLng;
	import com.google.maps.LatLngBounds;
	import com.google.maps.Map;
	import com.google.maps.MapEvent;
	import com.google.maps.MapMouseEvent;
	import com.google.maps.MapOptions;
	import com.google.maps.MapZoomEvent;
	import com.google.maps.overlays.Marker;
	import com.google.maps.styles.FillStyle;
	import com.kelvinluck.gmaps.Clusterer;
	import com.vizzuality.VizzButton;
	import com.vizzuality.gmaps.RunMarkerClusterHome;
	import com.vizzuality.gmaps.RunSingleMarkerHome;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.StyleSheet;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	
	import rosa.RosaSettings;
	import rosa.events.RosaEvent;
	import rosa.services.ServiceProxy;

	[SWF(backgroundColor=0xFFFFFF, width=508, height=355)]
	public class RunnityRacesXdays extends Sprite
	{
		
		private var map:Map;
		private var dataBbox:LatLngBounds;
		private var markers:Array;
		private var service:ServiceProxy;
		private var clusterer:Clusterer;
		private var attachedMarkers:Array;
		private var paramObj:Object;
		private var square:Sprite;
		public static const millisecondsPerDay:int = 1000 * 60 * 60 * 24;
	
		//Number of days for show races
		private var Xdays: Number = 30;
		private var runType: Number = 30;
		
		
		[Embed('assets/cargandomapa1.png')] 
		private var loadingImg:Class;		
		private var imgLoading:Bitmap;

		[Embed(source="assets/btnsMap.swf", symbol="zoomInButton")]
        private var ZoomInButton:Class;
        
        [Embed(source="assets/btnsMap.swf", symbol="zoomInButton_over")]
        private var ZoomInButton_over:Class;
 
        [Embed(source="assets/btnsMap.swf", symbol="zoomOutButton")]
        private var ZoomOutButton:Class;
        
        [Embed(source="assets/btnsMap.swf", symbol="zoomOutButton_over")]
        private var ZoomOutButton_over:Class;	
		private var zoomplus:Bitmap;
		
		
		
		public function RunnityRacesXdays()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;				
			
			imgLoading= new loadingImg() as Bitmap;
			imgLoading.x = 180;
			imgLoading.y = 120;
			mouseChildren = true;	
			
			var bkg_blue:Sprite = new Sprite();
			bkg_blue.graphics.beginFill(0x9FB4CB);
			bkg_blue.graphics.drawRect(0,0,510,357);
			bkg_blue.graphics.endFill();
			bkg_blue.x = 0;
			bkg_blue.y = 0;
			addChild(bkg_blue);	
			
				
			initMap();
		}
		
		
		private function initMap():void {

			map=new Map();
			if(this.root.loaderInfo.parameters.mapkey!=null) {
				map.key=this.root.loaderInfo.parameters.mapkey;							
			} else {
				map.key="ABQIAAAAtDJGVn6RztUmxjnX5hMzjRT2yXp_ZAY8_ufC3CFXhHIE1NvwkxSPLBWm1r4y_v-I6fII4c2FT0yK6w";
			}
			map.addEventListener(MapEvent.MAP_PREINITIALIZE, preinit);
			map.addEventListener(MapEvent.MAP_READY, onMapReady);
			map.x=1;
			map.y=1;
			map.setSize(new Point(508, 355));
			addChild(map);
			square = new Sprite();
			square.graphics.beginFill(0xFFFFFF);
			square.graphics.drawRect(0,0,508,355);
			square.graphics.endFill();
			square.x = 1;
			square.y = 1;			
			addChild(square); 
			addChild(imgLoading);
		}
		
		private function preinit(ev:Event):void {
				var mo:MapOptions = new MapOptions();
				mo.backgroundFillStyle = new FillStyle({color:0xFFFFFF});
				map.setInitOptions(mo);
		}
		
		private function onMapReady(event:MapEvent):void {
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
				localTestGatewayURL="http://www.runnity.com/amfphp/gateway.php";
				gatewayURL = "http://www.runnity.com/amfphp/gateway.php";
				
			}
			service = new ServiceProxy("RunnitServices");
			service.addEventListener("getAllRunsResult", getAllRunsResult);
			service.getAllRuns(30);
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
			  pointOffset:new Point(0,-28),
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

					var marker:RunSingleMarkerHome=new RunSingleMarkerHome(p,m.name,m.id,m.event_date);
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
			map.setCenter(dataBbox.getCenter(),map.getBoundsZoomLevel(dataBbox));

			removeChild(imgLoading);	
			removeChild(square);
			
			var zoomIn:Sprite = new ZoomInButton();			
			var zoomIn_over: Sprite = new ZoomInButton_over();
            addChild(zoomIn);
            zoomIn.x = 10;
            zoomIn.y = 10;
            zoomIn_over.x = 0;
            zoomIn_over.y = 0;
            zoomIn.addEventListener(MouseEvent.ROLL_OVER,function (ev:MouseEvent):void {
				zoomIn.addChild(zoomIn_over);
				zoomIn_over.mouseChildren = false;
				zoomIn_over.buttonMode = true;

			}); 
            zoomIn.addEventListener(MouseEvent.ROLL_OUT,function (ev:MouseEvent):void {
				zoomIn.removeChild(zoomIn_over);
				zoomIn_over.mouseChildren = false;
				zoomIn_over.buttonMode = true; 
			}); 
			zoomIn.addEventListener(MouseEvent.CLICK, function (ev:MouseEvent):void {
				map.setZoom(map.getZoom()+1);
			}); 
		
			
			var zoomOut:Sprite = new ZoomOutButton();			
			var zoomOut_over: Sprite = new ZoomOutButton_over();
            addChild(zoomOut);
            zoomOut.x = 10;
            zoomOut.y = 45;
            zoomOut_over.x = 0;
            zoomOut_over.y = 0;
            zoomOut.addEventListener(MouseEvent.ROLL_OVER,function (ev:MouseEvent):void {
				zoomOut.addChild(zoomOut_over);
				zoomOut_over.mouseChildren = false;
				zoomOut_over.buttonMode = true;

			}); 
            zoomOut.addEventListener(MouseEvent.ROLL_OUT,function (ev:MouseEvent):void {
				zoomOut.removeChild(zoomOut_over);
				zoomOut_over.mouseChildren = false;
				zoomOut_over.buttonMode = true; 
			});  
			zoomOut.addEventListener(MouseEvent.CLICK, function (ev:MouseEvent):void {
				map.setZoom(map.getZoom()-1);
			}); 

		}
		
		private function goToRunPage(e:MapMouseEvent):void {
			var m:Object = iw[e.target];
			navigateToURL(new URLRequest("http://www.runnity.com/run/"+m.id+"/"+m.name.split(" ").join("/")),"_blank"); 
			
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
