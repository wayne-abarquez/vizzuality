package {
	import com.adobe.serialization.json.JSON;
	import com.google.maps.Alpha;
	import com.google.maps.InfoWindowOptions;
	import com.google.maps.LatLng;
	import com.google.maps.LatLngBounds;
	import com.google.maps.Map;
	import com.google.maps.MapEvent;
	import com.google.maps.MapMouseEvent;
	import com.google.maps.MapOptions;
	import com.google.maps.MapType;
	import com.google.maps.MapZoomEvent;
	import com.google.maps.overlays.Marker;
	import com.google.maps.overlays.MarkerOptions;
	import com.google.maps.overlays.Polygon;
	import com.google.maps.overlays.PolygonOptions;
	import com.google.maps.styles.FillStyle;
	import com.greensock.TweenLite;
	import com.greensock.plugins.*;
	import com.vizzuality.gmaps.Clusterer;
	import com.vizzuality.maps.Multipolygon;
	import com.vizzuality.markers.ClusterMarker;
	import com.vizzuality.markers.PAGeneralInfowindow;
	import com.vizzuality.markers.PAMarker;
	import com.vizzuality.markers.SingleMarker;
	import com.vizzuality.vizzButton;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.Security;
	import flash.text.StyleSheet;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;

	[SWF(backgroundColor=0xEEEEEE, widthPercent=100, heightPercent=100)]
	public class ActivityMap extends Sprite
	{
		private var map:Map;
		private var square:Sprite;	
		private var picturesSquare:Sprite;	
		private var pol:Polygon;
		private var dataBbox:LatLngBounds;
		private var markers:Array;
		private var clusterer:Clusterer;
		private var attachedMarkers:Array;
		private var mapKey:String = "nokey";
		private var iw:Dictionary=new Dictionary();	
		private var domain:String;
		
		
					
		public function ActivityMap()
		{ 
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;	
			stage.addEventListener(Event.RESIZE, stageResizeHandler);
			//this.height = 364;	

			var externalDomains:Array=["ppe.org.tiles.s3.amazonaws.com","174.129.214.28:8080","ppe.tinypla.net"];
			for each(var dom:String in externalDomains) {
			    Security.allowDomain(dom);
			    Security.loadPolicyFile("http://"+dom+"/crossdomain.xml");
			    var request:URLRequest = new URLRequest("http://"+dom+"/crossdomain.xml");
			    var loader:URLLoader = new URLLoader();
			    loader.load(request);				
			}				
			
			square = new Sprite();
			square.graphics.beginFill(0x275186);
			square.graphics.drawRect(0,0,960, stage.stageHeight);
			square.graphics.endFill();
			addChildAt(square,0);
			
			positionElements();
						
			initMap();	
			
		}
		

		private var isResizing:Boolean=false;
 		private function stageResizeHandler(ev:Event):void {
 			positionElements();
			if(map!=null && !isResizing) {
				map.setSize(new Point(stage.stageWidth, stage.stageHeight-5));

			}
		}	
		
		private function initMap():void {
			map=new Map();
			
			var mk:String=root.loaderInfo.parameters.key;
			if(mk!=null) {
				map.key=root.loaderInfo.parameters.key;
			} else {
				map.key=mapKey;
			}			
			
			
			map.addEventListener(MapEvent.MAP_PREINITIALIZE, preinit);
			map.addEventListener(MapEvent.MAP_READY, onMapReady);
			map.setSize(new Point(stage.stageWidth, stage.stageHeight-6));
			addChild(map); 				
			
			
		}		
		
		private function preinit(ev:Event):void {
				var mo:MapOptions = new MapOptions();
				mo.backgroundFillStyle = new FillStyle({color:0xE9E9E9,alpha: Alpha.OPAQUE});
				mo.mapType=MapType.PHYSICAL_MAP_TYPE;	
				map.setInitOptions(mo);
		}	
		
		
		private function positionElements():void {
			square.x = (stage.stageWidth/2) - (960/2);
			square.y = 0;	
			square.height=stage.stageHeight;			
		}
		
		private function onMapReady(event:MapEvent):void {
			map.y= 3;
			
			var polOpt:PolygonOptions=new PolygonOptions({
				  strokeStyle: {
				    thickness: 2,
				    color: 0xFF7600,
				    alpha: 1
				  },
				  fillStyle: {
				    color: 0xFF7600,
				    alpha: 0.4
				  }	
			});		
			
			var zoomPlus:vizzButton = new vizzButton(this,10,10,25,25,"+",18,6,2);
			zoomPlus.addEventListener(MouseEvent.CLICK, function (ev:MouseEvent):void {
				map.setZoom(map.getZoom()+1);
			}); 
			var zoomMinus:vizzButton = new vizzButton(this,10,40,25,25,"-",18,8,1);
			zoomMinus.addEventListener(MouseEvent.CLICK, function (ev:MouseEvent):void {
				map.setZoom(map.getZoom()-1);
			}); 	
			
			
			var temp:String = '[{"name":"Yosemite National Park","geojson":{"type":"MultiPolygon","bbox":[130.666680,-25.416670,131.370590,-25.081670],"coordinates":[[[[130.74986,-25.16335],[130.74999,-25.26666],[130.75002,-25.26666],[130.83337,-25.26665],[130.92921,-25.26668],[130.92924,-25.26857],[131.00841,-25.26841],[131.00837,-25.26667],[131.08337,-25.26667],[131.1667,-25.26666],[131.25002,-25.26665],[131.33338,-25.26666],[131.37059,-25.26666],[131.37058,-25.33332],[131.37059,-25.41667],[131.33336,-25.41667],[131.25003,-25.41667],[131.16669,-25.41667],[131.08337,-25.41665],[131.00003,-25.41665],[130.91668,-25.41665],[130.83337,-25.41667],[130.75004,-25.41665],[130.66668,-25.41666],[130.66671,-25.33333],[130.66669,-25.08167],[130.75002,-25.12334],[130.74986,-25.16335]]]]} ,' + 
					'"comments":[{"user": "simon","place":{"lat":"-30.34","lon": "123.234"},"ago":"3 hours ago","action":"edit PA data"},{"user": "craig","place":{"lat":"-29.45","lon": "123.234"},"ago":"3 hours ago","action":"edit PA data"},{"user": "saleiva","place":{"lat":"-23.34","lon": "119.234"},"ago":"3 hours ago","action":"edit PA data"},{"user": "jatorre","place":{"lat":"-22.34","lon": "118.234"},"ago":"3 hours ago","action":"edit PA data"},{"user": "jam","place":{"lat":"-23.34","lon": "119.234"},"ago":"3 hours ago","action":"edit PA data"}]}]'; 

			var areasJson:Object = JSON.decode(temp);
			var areas:Array =[];
			var bounds:LatLngBounds = new LatLngBounds();
			markers = [];	
			dataBbox=new LatLngBounds();
			
			for each(var areaJson:Object in areasJson as Array) {
				var area:Multipolygon = new Multipolygon();
				area.data.name=areaJson.name;
				area.fromGeojsonMultiPolygon(areaJson.geojson.coordinates,polOpt);
				areas.push(area);
				area.addToMap(map);
				bounds.union(area.getLatLngBounds());
				var markerOpt:MarkerOptions=new MarkerOptions({});
				
                var markerData: Object = new Object();	
                markerData.coordenates = area.getLatLngBounds().getCenter();
                markerData.area = area.data.name;
                				
/* 				var paMarker:PAMarker = new PAMarker(area.getLatLngBounds().getCenter()); */
				
				dataBbox.extend(bounds.getCenter());
/* 				map.addOverlay(paMarker); */                
			}
			
			
			for each(var m:Object in areasJson[0].comments as Array) {
				var place:LatLng = new LatLng(m.place.lat,m.place.lon);
				var marker:SingleMarker=new SingleMarker(place,m.user,m.ago,"activityIcon");
				iw[marker]=m;
				marker.addEventListener(MapMouseEvent.CLICK,function(e:MapMouseEvent):void {
					trace('click in marker');
				});
				marker.addEventListener(MapMouseEvent.ROLL_OVER, function(e:MapMouseEvent):void {
					openInfoWindow(e);									
				});
				marker.addEventListener(MapMouseEvent.ROLL_OUT, function(e:MapMouseEvent):void {
					map.closeInfoWindow();
				});						
				markers.push(marker);
				dataBbox.extend(place);
			}
			
			
			
			clusterer = new Clusterer(markers, map.getZoom(),25);
			attachedMarkers = [];
			attachMarkers();	
			
			map.addEventListener(MapZoomEvent.ZOOM_CHANGED, onMapZoomChanged);
			
			map.setCenter(dataBbox.getCenter(),map.getBoundsZoomLevel(dataBbox)-1);
	
	 	}		
	 	
	 	private function onMapZoomChanged(event:MapZoomEvent):void {
			map.closeInfoWindow();
			clusterer.zoom = map.getZoom();
			attachMarkers();
		}	
	 	
        
        private function openInfoWindow(e:MapMouseEvent):void {
			
			var m:Object = iw[e.target];

			infoWindowToOpen = new PAGeneralInfowindow(m);
 			infoWindowToOpen.targetUrl="/sites/366165";
 			infoWindowToOpen.addEventListener(MouseEvent.ROLL_OUT,onInfowindowRollOut);
            var options:InfoWindowOptions = new InfoWindowOptions({
              customContent: infoWindowToOpen,
              padding: 10,
              hasCloseButton: false,
              pointOffset:new Point(-63,-79),
              hasShadow: true
            });
            
            infoWindowToOpen.alpha=0;
            map.openInfoWindow(new LatLng(m.place.lat,m.place.lon),options);
            TweenLite.to(infoWindowToOpen,0.3,{alpha:1});
                
        }	 
        
 		private var rollingOver:Boolean=false;
		private var infoWindowToOpen:PAGeneralInfowindow;       
		private function onInfowindowRollOut(e:Event ):void {
			map.closeInfoWindow();
			rollingOver=false;
		}  
		

		

		private function attachMarkers():void {
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
					marker = new ClusterMarker(cluster);
					marker.addEventListener(MapMouseEvent.CLICK,function(e:MapMouseEvent):void {
						map.zoomIn(e.latLng,true,false);
					});
					marker.addEventListener(MapMouseEvent.ROLL_OVER, function(e:MapMouseEvent):void {
						var titleFormat:TextFormat = new TextFormat();
						titleFormat.bold = true;
						var titleStyleSheet:StyleSheet = new StyleSheet();
						var contentFormat:TextFormat = new TextFormat("Arial", 12,0x333333);
						var options:InfoWindowOptions = new InfoWindowOptions({

						  strokeStyle: {
						    color: 0xcccccc,
						    thickness:1
						  },
						  fillStyle: {
						    color: 0xFFFFFF,
						    alpha: 0.9
						  },
						  titleFormat: titleFormat,
						  titleStyleSheet: titleStyleSheet,
						  contentFormat: contentFormat,
						  width: 113,
						  cornerRadius: 3,
						  padding: 4,
						  hasCloseButton: false,
						  hasTail: false,
						  pointOffset:new Point(12,-5),
						  tailWidth: 0,
						  tailHeight: 0,
						  tailOffset: -22,
						  tailAlign: InfoWindowOptions.ALIGN_CENTER,
						  pointOffset: new Point(0,0),
						  hasShadow: false,
						  content:"Click to view more"
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
