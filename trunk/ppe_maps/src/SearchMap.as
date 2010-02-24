package {
	import com.adobe.serialization.json.JSON;
	import com.google.maps.Alpha;
	import com.google.maps.LatLng;
	import com.google.maps.LatLngBounds;
	import com.google.maps.Map;
	import com.google.maps.MapEvent;
	import com.google.maps.MapOptions;
	import com.google.maps.MapType;
	import com.google.maps.MapZoomEvent;
	import com.google.maps.overlays.Marker;
	import com.google.maps.overlays.MarkerOptions;
	import com.google.maps.overlays.PolygonOptions;
	import com.google.maps.overlays.TileLayerOverlay;
	import com.google.maps.styles.FillStyle;
	import com.greensock.plugins.*;
	import com.vizzuality.*;
	import com.vizzuality.gmaps.Clusterer;
	import com.vizzuality.maps.Multipolygon;
	import com.vizzuality.markers.SearchTypeMarkers;
	import com.vizzuality.tileoverlays.GeoserverTileLayer;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.Security;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	import flash.utils.Timer;

	[SWF(backgroundColor=0xEEEEEE, widthPercent=100, heightPercent=100)]
	public class SearchMap extends Sprite
	{
		
		[Embed(source="assets/btnsMap.swf", symbol="zoomInButton")]
        private var ZoomInButton:Class;
        
        [Embed(source="assets/btnsMap.swf", symbol="zoomInButton_over")]
        private var ZoomInButton_over:Class;
 
        [Embed(source="assets/btnsMap.swf", symbol="zoomOutButton")]
        private var ZoomOutButton:Class;
        
        [Embed(source="assets/btnsMap.swf", symbol="zoomOutButton_over")]
        private var ZoomOutButton_over:Class;		
		
		
		private var map:Map;
		private var mapKey:String = "nokey";
		private var iw:Dictionary=new Dictionary();
		private var domain: String;
		
		private var markers:Array;
		private var clusterer:Clusterer;
		private var attachedMarkers:Array;
		private var mp:Multipolygon;
		private var paJson:Object;
		

		
		private var dataLoaded: Boolean = false;
		private var dataAnalyzed: Boolean = false;
									
														
		public function SearchMap()
		{ 
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;	
			stage.addEventListener(Event.RESIZE, stageResizeHandler);
			//this.height = 364;	

			var externalDomains:Array=["ppe.org.tiles.s3.amazonaws.com","ppe.tinypla.net",];
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
		
		private var iw2:Dictionary=new Dictionary();
		private var tl:GeoserverTileLayer;
		private var tlo:TileLayerOverlay;
		private function onMapReady(event:MapEvent):void {
			
			
			var exampleSprite2: Sprite = new Sprite();
            var countryText2: TextField = new TextField();
            countryText2.text = "FS";
            var newFormat2:TextFormat = new TextFormat(); 
   			newFormat2.size = 16; 
   			newFormat2.color = 0xFFFFFF;
   			newFormat2.italic = false;
   			newFormat2.letterSpacing = 0;
			newFormat2.font = "Helvetica";
    		countryText2.setTextFormat(newFormat2); 
            countryText2.width = 29;
            countryText2.height = 29;
            countryText2.x = 3;
            countryText2.y = 7;

			
			tl = new GeoserverTileLayer(false);
			tlo = new TileLayerOverlay(tl);
			map.addOverlay(tlo);		
			
			markers = new Array();
		 	addZoomButtons();
				
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
			paJson = JSON.decode(varsdata);
			
			markers = [];	
			
			var areas:Array =[];
			var bounds:LatLngBounds = new LatLngBounds();
			for each(var areaJson:Object in paJson as Array) {
				var areaCoords:LatLng = new LatLng(areaJson.y,areaJson.x);
				bounds.extend(areaCoords);
				var markerOpt:MarkerOptions=new MarkerOptions({});
                var markerData: Object = new Object();	
                markerData.coordenates = areaCoords;
                markerData.area = areaJson.name;
                //TODO: CONNECT THIS WITH THE JSON SERVICE
                markerData.sites = areaJson.pois;
                markerData.isNeeded = true;	
                markerData.imgURL = areaJson.image;
                markerData.paId = areaJson.id;
                markerData.local_name = areaJson.local_name;
                
                var marker:SearchTypeMarkers = new SearchTypeMarkers(areaCoords,markerData,3);
                iw2[marker] = markerData;
                markers.push(marker);              
			}
			if (markers.length==1) {
				map.setCenter(bounds.getCenter(),map.getBoundsZoomLevel(bounds)-5);
			} else {
				map.setCenter(bounds.getCenter(),map.getBoundsZoomLevel(bounds));
			}
			
			dataLoaded=true;

			
			map.panBy(new Point(0,-45),false);
			map.addEventListener(MapZoomEvent.ZOOM_CHANGED, onMapZoomChanged);
			clusterer = new Clusterer(markers, map.getZoom(),70);
			attachedMarkers = [];
			attachMarkers();			
		}

		
		private function onMapZoomChanged(event:MapZoomEvent):void{
			clusterer.zoom = map.getZoom();
			attachMarkers();
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
					map.addOverlay(marker);
					attachedMarkers.push(marker);
				} else {					
					var i:Number = 0;
					for each(var mar:SearchTypeMarkers in cluster) {
						
						var typeMarker: Number = distanceBetweenMarkers(map.fromLatLngToPoint(mar.getLatLng()),i,cluster);
						
						var obj: Object = new Object();
						obj.imgURL = mar.markerData.imgURL;
						obj.coordenates = mar.markerData.coordenates;
						obj.area = mar.markerData.area;
						obj.sites = mar.markerData.sites;
						obj.paId = mar.markerData.paId;
						obj.local_name = mar.markerData.local_name;
						
						marker = new SearchTypeMarkers(obj.coordenates,obj,typeMarker);
 						map.addOverlay(marker);
						attachedMarkers.push(marker);
						
						i++;
					}
				}
			}
			

		}	
		
		
		private function distanceBetweenMarkers(originPoint:Point, pos:Number, markersArray: Array):Number {
			
			for (var i:Number = 0; i<markersArray.length; i++) {
				if (pos!=i) {
					var nearPoint: Point = map.fromLatLngToPoint((markersArray[i] as SearchTypeMarkers).getLatLng());
					if ((originPoint.x - nearPoint.x < 10) ||  (originPoint.y - nearPoint.y < 10)) {
						return 1;
					}
				}
			}
			return 2;
		}
		
		private function addZoomButtons():void {
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
	}
}
