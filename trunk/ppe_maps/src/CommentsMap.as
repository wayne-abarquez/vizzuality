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
	import com.google.maps.overlays.Polygon;
	import com.google.maps.styles.FillStyle;
	import com.greensock.TweenLite;
	import com.greensock.plugins.*;
	import com.vizzuality.gmaps.Clusterer;
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
	public class CommentsMap extends Sprite
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
		private var paPoint: LatLng;
		private var domain:String;
		
		
					
		public function CommentsMap()
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
			
			domain=root.loaderInfo.parameters.domain;
			if (domain=='') {
				domain = 'http://localhost:3000';
			}
			
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
			
			var zoomPlus:vizzButton = new vizzButton(this,10,10,25,25,"+",18,6,2);
			zoomPlus.addEventListener(MouseEvent.CLICK, function (ev:MouseEvent):void {
				map.setZoom(map.getZoom()+1);
			}); 
			var zoomMinus:vizzButton = new vizzButton(this,10,40,25,25,"-",18,8,1);
			zoomMinus.addEventListener(MouseEvent.CLICK, function (ev:MouseEvent):void {
				map.setZoom(map.getZoom()-1);
			}); 
			
			//json urle xample: "/protected_areas/"+this.root.loaderInfo.parameters.id+"/comments.json"
			paPoint = new LatLng(this.root.loaderInfo.parameters.palat,this.root.loaderInfo.parameters.palon);
			var paId:Number=root.loaderInfo.parameters.id;
			var commentJson: URLRequest = new URLRequest(domain + "/sites/"+(paId)+"/comments.json");

            var urlLdr: URLLoader = new URLLoader();
            urlLdr.addEventListener(Event.COMPLETE, onGetPAJson);
            urlLdr.load(commentJson);

		}
		
		private function onGetPAJson(ev:Event):void {	
			
			var areasJson:Object = JSON.decode(ev.target.data);
			var areas:Array =[];
			var bounds:LatLngBounds = new LatLngBounds();
			markers = [];	
			dataBbox=new LatLngBounds();
							
			var paMarker:PAMarker = new PAMarker(paPoint);
			 
			dataBbox.extend(paMarker.getLatLng());
			map.addOverlay(paMarker);                
			
			
			for each(var m:Object in areasJson.protected_area.comments as Array) {
				
				var place:LatLng = new LatLng(m.user.latitude,m.user.longitude);
				var marker:SingleMarker=new SingleMarker(place,m.username,m.created_at,"commentIcon");
				iw[marker]=m;
				marker.addEventListener(MapMouseEvent.CLICK,function(e:MapMouseEvent):void {
					trace('click in marker');
				});
				marker.addEventListener(MapMouseEvent.ROLL_OVER, function(e:MapMouseEvent):void {
					openInfoWindow(e);
					/* var options:MarkerOptions = new MarkerOptions();
					options.icon = new GenericMarkerIcon('activityIcon');
					(e.target as SingleMarker).setOptions(options);	 */							
				});
				marker.addEventListener(MapMouseEvent.ROLL_OUT, function(e:MapMouseEvent):void {
					map.closeInfoWindow();
					/* var options1:MarkerOptions = new MarkerOptions();
					options1.icon = GenericMarkerIcon('commentIcon');
					(e.target as SingleMarker).setOptions(options1); */
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
            map.openInfoWindow(new LatLng(m.user.latitude,m.user.longitude),options);
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
						var contentFormat:TextFormat = new TextFormat("Arial", 10,0xFFFFFF,true,null,null,null,null,"center");
						var options:InfoWindowOptions = new InfoWindowOptions({

						  strokeStyle: {
						    color: 0xcccccc,
						    thickness:1,
						    alpha:0
						  },
						  fillStyle: {
						    color: 0x000000,
						    alpha: 0.75
						  },
						  contentFormat: contentFormat,
						  contentStyleSheet: titleStyleSheet,
						  width: 80,
						  height: 25,
						  cornerRadius: 3,
						  padding: 6,
						  hasCloseButton: false,
						  hasTail: true,
						  pointOffset:new Point(12,-5),
						  tailWidth: 15,
						  tailHeight: 8,
						  tailOffset: -22,
						  tailAlign: InfoWindowOptions.ALIGN_CENTER,
						  pointOffset: new Point(0,0),
						  hasShadow: false,
						  content:"VIEW MORE"
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
