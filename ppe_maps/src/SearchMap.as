package {
	import com.google.maps.Alpha;
	import com.google.maps.InfoWindowOptions;
	import com.google.maps.LatLng;
	import com.google.maps.LatLngBounds;
	import com.google.maps.Map;
	import com.google.maps.MapEvent;
	import com.google.maps.MapMouseEvent;
	import com.google.maps.MapOptions;
	import com.google.maps.MapType;
	import com.google.maps.overlays.MarkerOptions;
	import com.google.maps.overlays.PolygonOptions;
	import com.google.maps.styles.FillStyle;
	import com.greensock.TweenLite;
	import com.greensock.plugins.*;
	import com.vizzuality.*;
	import com.vizzuality.maps.Multipolygon;
	import com.vizzuality.markers.SearchInfowindow;
	import com.vizzuality.markers.SearchMarker;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.Security;
	import flash.utils.Dictionary;
	import flash.utils.Timer;

	[SWF(backgroundColor=0xEEEEEE, widthPercent=100, heightPercent=100)]
	public class SearchMap extends Sprite
	{
		private var map:Map;
		private var mapKey:String = "nokey";
		private var iw:Dictionary=new Dictionary();
							
						
		public function SearchMap()
		{ 
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;	
			stage.addEventListener(Event.RESIZE, stageResizeHandler);
			//this.height = 364;	

			var externalDomains:Array=["ppe.org.tiles.s3.amazonaws.com","174.129.214.28:8080"];
			for each(var dom:String in externalDomains) {
			    Security.allowDomain(dom);
			    Security.loadPolicyFile("http://"+dom+"/crossdomain.xml");
			    var request:URLRequest = new URLRequest("http://"+dom+"/crossdomain.xml");
			    var loader:URLLoader = new URLLoader();
			    loader.load(request);				
			}				
					
			initMap();
			
		}

		private var timerResizing:Timer;
		private var isResizing:Boolean=false;
 		private function stageResizeHandler(ev:Event):void {
			if(map!=null && !isResizing) {
				map.setSize(new Point(stage.stageWidth, stage.stageHeight));
				//isResizing=true;
				//timerResizing.addEventListener(TimerEvent.TIMER,function(e:Event):void {
					//isResizing=false;	
					//timerResizing.stop();			
				//});
				//timerResizing.start();
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
			
			//timerResizing = new Timer(100);
			
			map.addEventListener(MapEvent.MAP_PREINITIALIZE, preinit);
			map.addEventListener(MapEvent.MAP_READY, onMapReady);
			map.setSize(new Point(stage.stageWidth, stage.stageHeight));
			addChild(map); 				
			
			
		}		
		
		private function preinit(ev:Event):void {
				var mo:MapOptions = new MapOptions();
				mo.backgroundFillStyle = new FillStyle({color:0xE9E9E9,alpha: Alpha.OPAQUE});
				mo.mapType=MapType.PHYSICAL_MAP_TYPE;	
				map.setInitOptions(mo);
		}		
		
		private function onMapReady(event:MapEvent):void {
			
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
			
			//parse the Flashvar
			var varsdata:String = this.root.loaderInfo.parameters.pas;
			var pas:Array = varsdata.split("|");
			
			var areas:Array =[];
			var bounds:LatLngBounds = new LatLngBounds();
			for each(var area:Object in pas) {
				var area:Multipolygon = new Multipolygon();
				area.data.name=areaJson.name;
				area.fromGeojsonMultiPolygon(areaJson.geojson.coordinates,polOpt);
				areas.push(area);
				//area.addToMap(map);
				bounds.union(area.getLatLngBounds());
				var markerOpt:MarkerOptions=new MarkerOptions({
				
				});
				
                var markerData: Object = new Object();	
                markerData.coordenates = area.getLatLngBounds().getCenter();
                markerData.area = area.data.name;
                //TODO: CONNECT THIS WITH THE JSON SERVICE
                markerData.sites = 7;
                markerData.isNeeded = true;	
                markerData.imgURL = "/images/thumbnails/thumb01.jpg";
                				
				var m:SearchMarker = new SearchMarker(area.getLatLngBounds().getCenter(),markerData.imgURL,markerData.sites,markerData.isNeeded);
				m.addEventListener(MapMouseEvent.ROLL_OVER, function(e:MapMouseEvent):void {
                        if(!rollingOver) {
	                        openInfoWindow(e);     
                        }
                        rollingOver=true;                                                                
                });	
                
                iw[m]=markerData;
                
				map.addOverlay(m);                
                
			}
			map.setCenter(bounds.getCenter(),map.getBoundsZoomLevel(bounds));		
	 	}			
	 	
		private function openInfoWindow(e:MapMouseEvent):void {
 
 			var m:Object = iw[e.target];
 			
 			infoWindowToOpen = new SearchInfowindow(m);
 			infoWindowToOpen.targetUrl="/sites/366165";
 			infoWindowToOpen.addEventListener(MouseEvent.ROLL_OUT,onInfowindowRollOut);
            var options:InfoWindowOptions = new InfoWindowOptions({
              customContent: infoWindowToOpen,
              padding: 10,
              hasCloseButton: false,
              pointOffset:new Point(-25,-20),
              hasShadow: false
            });
            
            infoWindowToOpen.alpha=0;
            map.openInfoWindow(new LatLng(m.coordenates.lat(),m.coordenates.lng()),options);
            TweenLite.to(infoWindowToOpen,0.5,{alpha:1});
                
        }	 
        
 		private var rollingOver:Boolean=false;
		private var infoWindowToOpen:SearchInfowindow;       
		private function onInfowindowRollOut(e:Event ):void {
			map.closeInfoWindow();
			rollingOver=false;
		}        	
	 			
	}
}
