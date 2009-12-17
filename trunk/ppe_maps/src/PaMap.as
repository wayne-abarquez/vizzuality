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
	import com.google.maps.overlays.Marker;
	import com.google.maps.overlays.MarkerOptions;
	import com.google.maps.overlays.PolygonOptions;
	import com.google.maps.overlays.TileLayerOverlay;
	import com.google.maps.styles.FillStyle;
	import com.google.maps.styles.StrokeStyle;
	import com.greensock.TweenLite;
	import com.greensock.plugins.*;
	import com.vizzuality.ImageCarrousel;
	import com.vizzuality.data.ImageData;
	import com.vizzuality.maps.CustomMapEvent;
	import com.vizzuality.maps.MapEventDispatcher;
	import com.vizzuality.maps.Multipolygon;
	import com.vizzuality.markers.PAInfoWindow;
	import com.vizzuality.markers.PAMarker;
	import com.vizzuality.markers.TooltipMarker;
	import com.vizzuality.tileoverlays.GeoserverTileLayer;
	import com.vizzuality.vizzButton;
	
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.system.Security;
	import flash.utils.Dictionary;

	[SWF(backgroundColor=0xeeeeee, widthPercent=100, heightPercent=100)]
	public class PaMap extends Sprite
	{
		private var map:Map;
		private var square:Sprite;	
		//private var butButtonsBitmap:Bitmap;
		private var dataLoaded:Boolean=false;
		private var dataAnalyzed:Boolean=false;
		private var data:Object;
		private var panoramioMarkers:Dictionary = new Dictionary(true);
		private var imageDict:Dictionary = new Dictionary(true);
		public var picturesInfoWindows:Dictionary = new Dictionary(true);	

		private var imgC:ImageCarrousel;
		
		private var mouseOverPa:Boolean=false;


		private var mapKey:String = "nokey";
		private var mp:Multipolygon;
		private var domain: String;
		
		private var paId:Number;
		private var loadingSprite: Sprite = new Sprite();
		private var infoWindowToOpen: PAInfoWindow;
		private var paMarker: PAMarker;
		private var paDictionary: Dictionary = new Dictionary();
		private var tooltip: TooltipMarker;
		

		/*[Embed(source='assets/loadAnimation.swf', symbol="loadAnimation")] 
	  	private var loading:Class; */
		
				
			
		/*[Embed('assets/bottom_buttons.png')] 
		private var butButtons:Class;	*/						
						
		public function PaMap()
		{ 
			//Define stage properties
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;	
			stage.addEventListener(Event.RESIZE, stageResizeHandler);


			//This is to allow the access to the tiles for the mouse over
			var externalDomains:Array=["ppe.org.tiles.s3.amazonaws.com","174.129.214.28:8080"];
			for each(var dom:String in externalDomains) {
			    Security.allowDomain(dom);
			    Security.loadPolicyFile("http://"+dom+"/crossdomain.xml");
			    var request:URLRequest = new URLRequest("http://"+dom+"/crossdomain.xml");
			    var loader:URLLoader = new URLLoader();
			    loader.load(request);				
			}				
			
			//Draw the blue square around the map
			square = new Sprite();
			square.graphics.beginFill(0x275186);
			square.graphics.drawRect(0,0,960, stage.stageHeight);
			square.graphics.endFill();
			addChild(square);
			//addChildAt(square,0);
			
			//poisition it
			positionElements();	
								
			//create the map					
			map=new Map();			
			var mk:String=root.loaderInfo.parameters.key;
			if(mk!=null) {
				map.key=root.loaderInfo.parameters.key;
			} else {
				map.key=mapKey;
			}							
			map.y=3;			
			map.addEventListener(MapEvent.MAP_PREINITIALIZE, preinit);
			map.addEventListener(MapEvent.MAP_READY, onMapReady);
			map.setSize(new Point(stage.stageWidth, stage.stageHeight-46));
			addChildAt(map,1); 			
				

			//get the PA data
			domain=root.loaderInfo.parameters.domain;
			if (domain=='') {
				domain = 'http://localhost:3000';
			}
			
			var dsLoader:URLLoader = new URLLoader();
			dsLoader.addEventListener(Event.COMPLETE,onDataLoaded);
			paId=root.loaderInfo.parameters.id;
			if(isNaN(paId)) {
				paId=2027;
			}
			dsLoader.load(new URLRequest(domain + "/sites/"+paId+"/json"));
			
		}
		
		private function onDataLoaded(event:Event):void {
			dataLoaded=true;
			data = JSON.decode(event.currentTarget.data as String);			
			
			//Only load the data if the map is ready or it will fail
			if(map.isLoaded() && !dataAnalyzed) {
				dataAnalyzed=true;
				loadData();				
			}
		}
		
		private function loadData():void {
			//Polygon options for the PA
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
			
			//the data will always be a MultiPolygon
			mp= new Multipolygon();
			mp.fromGeojsonMultiPolygon(data.coordinates,polOpt);						
			mp.addToMap(map);

			//Set the center of the map to the bbox of the area			
			map.setCenter(mp.getLatLngBounds().getCenter(),map.getBoundsZoomLevel(mp.getLatLngBounds()));		
			
			//If there is pictures then display the ImageCarrousel
			if((data.pictures as Array).length>1) {
				imgC = new ImageCarrousel();
				imgC.init(data.pictures as Array);
				addChild(imgC);
				
				//Because the carrusel stay in the middle we have to pan the map and reposition
				map.panBy(new Point(-320,0),false);
				positionElements();
				
			}
			
			//retrieve picture from panoramio
			getPanoramioPictures();
		}		
		
		private function preinit(ev:Event):void {
				var mo:MapOptions = new MapOptions();
				mo.backgroundFillStyle = new FillStyle({color:0xE9E9E9,alpha: Alpha.OPAQUE});
				mo.mapType=MapType.PHYSICAL_MAP_TYPE;	
				map.setInitOptions(mo);
		}		
		
		private function onMapReady(event:MapEvent):void {
			
			map.addEventListener(MapMouseEvent.DOUBLE_CLICK,onMapDoubleClick);
			//map.addEventListener(MapZoomEvent.ZOOM_CHANGED,onZoomChange);
			
			var zoomPlus:vizzButton = new vizzButton(this,10,10,25,25,"+",18,6,2);
			zoomPlus.addEventListener(MouseEvent.CLICK, function (ev:MouseEvent):void {
				map.setZoom(map.getZoom()+1);
			}); 
			var zoomMinus:vizzButton = new vizzButton(this,10,40,25,25,"-",18,8,1);
			zoomMinus.addEventListener(MouseEvent.CLICK, function (ev:MouseEvent):void {
				map.setZoom(map.getZoom()-1);
			}); 
			
			if(dataLoaded && !dataAnalyzed) {
				dataAnalyzed=true;
				loadData();	
			}
			
			//add the default PPE layer for visualizing the other Pas
			var tl:GeoserverTileLayer = new GeoserverTileLayer();
			var tlo:TileLayerOverlay = new TileLayerOverlay(tl);
			map.addOverlay(tlo);		
			MapEventDispatcher.addEventListener(CustomMapEvent.MOUSE_OUT_AREA,function(event:CustomMapEvent):void {mouseOverPa=false;});
			MapEventDispatcher.addEventListener(CustomMapEvent.MOUSE_OVER_AREA,function(event:CustomMapEvent):void {mouseOverPa=true;});
			map.addEventListener(MapMouseEvent.CLICK,onMapClick);				

		}		
		private function onMapClick(event:MapMouseEvent):void {
			if(mouseOverPa && !mp.pointInPolygon(event.latLng)) {
				map.closeInfoWindow();
				loadingSprite.graphics.lineStyle(1,0x666666,1);
				loadingSprite.graphics.beginFill(0xFFFFFF);
				loadingSprite.graphics.drawRoundRect(0,0,30,30,5,5);
				loadingSprite.graphics.endFill();
				addChild(loadingSprite);
				loadingSprite.x = (map.fromLatLngToViewport(event.latLng) as Point).x;
				loadingSprite.y = (map.fromLatLngToViewport(event.latLng) as Point).y;
				this.addEventListener(MouseEvent.MOUSE_MOVE,onMoveCursorLoading);
				
				//get PA clicked
				var dsLoader:URLLoader = new URLLoader();
				dsLoader.addEventListener(Event.COMPLETE,onGetPaByCoordsResult);
				dsLoader.load(new URLRequest(domain + "/api/sites_by_point/"+(event.latLng as LatLng).lng()+"/"+ (event.latLng as LatLng).lat()));
				/* TweenLite.delayedCall(3,onGetPaByCoordsResult,[{"name": "area", "point": event.latLng}]); */
				
			}
		}
		
		
		private function onMapDoubleClick(event:MapMouseEvent):void {
			//trace("onMapDoubleClick");			
			if(imgC!=null) {
				map.panBy(new Point(-320,0),false);
			}
		}
		
/* 		private function onZoomChange(event:MapZoomEvent):void {
			trace("onZoomChange");			
			if(imgC!=null) {
				map.panBy(new Point(-320,0),false);
			}
		} */
		
		
		private function getPanoramioPictures():void {		
			var url:String= "http://www.panoramio.com/map/get_panoramas.php?order=popularity&set=public&from=0&to=20&size=mini_square";		
	
			panoramioMarkers = new Dictionary(true);		
			var bbox:LatLngBounds=mp.getLatLngBounds();	
/* 			var bbox:LatLngBounds = new LatLngBounds(
				new LatLng(bboxAll.getSouth()+(bboxAll.getSouth()*0.002),bboxAll.getWest()-(bboxAll.getWest()*0.001)),
				new LatLng(bboxAll.getNorth()-(bboxAll.getNorth()*0.002),bboxAll.getEast()+(bboxAll.getEast()*0.001))
				); */
		
			var loader:URLLoader= new URLLoader();		
			loader.addEventListener(Event.COMPLETE,onPanoramioResult);	
			loader.addEventListener(IOErrorEvent.IO_ERROR,function(event:IOErrorEvent):void{trace("error loading panoramio");});	
			
/* 			var pol:Polygon = new Polygon([new LatLng(bbox.getSouth(),bbox.getWest()),
										   new LatLng(bbox.getNorth(),bbox.getWest()),
										   new LatLng(bbox.getNorth(),bbox.getEast()),
										   new LatLng(bbox.getSouth(),bbox.getEast()),
										   new LatLng(bbox.getSouth(),bbox.getWest())]);
			map.addOverlay(pol);	 */						   
			loader.load(new URLRequest(url + "&minx="+bbox.getWest()+"&miny="+bbox.getSouth()+"&maxx="+bbox.getEast()+"&maxy="+bbox.getNorth()));		
			}		
			
			private function onPanoramioResult(event:Event):void {		
				var res:Object = JSON.decode(event.currentTarget.data as String);		
				for each(var photo:Object in res.photos) {		
					if(mp.pointInPolygon(new LatLng(photo.latitude, photo.longitude))) {		
			
						var img:ImageData=new ImageData();		
						img.latlng = new LatLng(photo.latitude,photo.longitude);		
						img.source="Panoramio";		
						img.owner = photo.owner_name		
						img.sourceUrl = photo.photo_url;		
						img.title = photo.photo_title;		
						img.imageUrl = (photo.photo_file_url as String).replace("mini_square","thumbnail");		
						img.thumbnail = (photo.photo_file_url as String).replace("medium","mini_square");		
						img.id=photo.photo_id;		
						img.height=photo.height;		
						img.width=photo.width;	
			
			
						//pictures.addItem(img);		
						var loader:Loader = new Loader();		
						loader.contentLoaderInfo.addEventListener(Event.COMPLETE, createImageMarker,false,0,true);		
						imageDict[loader]=img;		
						loader.load(new URLRequest(img.thumbnail));		
			
					}		
				}		
			}		
		
		
		private function createImageMarker(ev:Event):void {
			var photo:ImageData=imageDict[ev.target.loader];
			
			//Set the images thumbnail images to 25x25
			(ev.target.loader as Loader).width=25;
			(ev.target.loader as Loader).height=25;
			
			var latlng:LatLng = photo.latlng;
	      	var photoUrl:String = photo.imageUrl;
	      	
	       var marker:Marker = new Marker(latlng, new MarkerOptions(
	       	{/* tooltip: photo.title, */
	       	 draggable:false,
	       	 hasShadow:false,	        
	       	 icon: ev.target.loader}));
	       	
	       	if (photo.title !='') {
		       	marker.addEventListener(MapMouseEvent.ROLL_OVER, function (ev:MapMouseEvent):void {
		       		tooltip = new TooltipMarker(photo.title);
					tooltip.x = (map.fromLatLngToViewport(ev.latLng) as Point).x + 28;
					tooltip.y = (map.fromLatLngToViewport(ev.latLng) as Point).y + 28;
		       		addChild(tooltip);
		       	});
		       	marker.addEventListener(MapMouseEvent.ROLL_OUT, function(ev:MapMouseEvent):void {
		       		removeChild(tooltip);
		       	});  	       		
	       	}
              
        	var infowindow:Loader= new Loader();
        	infowindow.load(new URLRequest(photo.imageUrl));
        	infowindow.addEventListener(MouseEvent.CLICK,function(event:MouseEvent):void {
        		navigateToURL(new URLRequest(photo.sourceUrl));
        	});
        	
        	infowindow.contentLoaderInfo.addEventListener(Event.COMPLETE,function(event:Event):void {
		   		var loader:LoaderInfo= event.currentTarget as LoaderInfo;
		   		var s:Sprite=new Sprite();
		   		s.addChild(infowindow);
		   		s.buttonMode=true;
 		   		var optionsMark:InfoWindowOptions = new InfoWindowOptions({
	                customContent: loader.loader,
	                strokeStyle: new StrokeStyle({thickness: 6, color:0xFFFFFF}),
	                cornerRadius:0,
					hasShadow:false,
	                width: (photo.width/2.1),
	                height: (photo.height/2.1),
	                drawDefaultFrame: true					
				});  	 
				picturesInfoWindows[marker]=optionsMark;
		        marker.addEventListener(MapMouseEvent.CLICK, function(e:MapMouseEvent):void {
		      		marker.openInfoWindow(optionsMark);  
		      		//map.panTo(e.latLng);   
		        });      
	        	map.addOverlay(marker);
        		
        	});
	        panoramioMarkers[photo]=marker;
		} 		

		
		private function positionElements():void {
 			square.x = (stage.stageWidth/2) - (960/2);
			square.y = 0;	
			square.height=stage.stageHeight-40;
			
			if(imgC!=null) {
				imgC.x=square.x;
				imgC.y= stage.stageHeight-imgC.height-20;
			}
		}
		
 		private function stageResizeHandler(ev:Event):void {
			positionElements();
			if(map!=null)
				map.setSize(new Point(stage.stageWidth, stage.stageHeight-45));
		}
		
		private function onGetPaByCoordsResult(ev:Event):void {
			
 			removeChild(loadingSprite);
			this.removeEventListener(MouseEvent.MOUSE_MOVE,onMoveCursorLoading);
			try {
				map.removeOverlay(paMarker);				
			} catch (e:Error) {}
			
			paMarker = new PAMarker(ev.target.data as Object);
			
			paMarker.addEventListener(MapMouseEvent.ROLL_OVER, function(e:MapMouseEvent):void {
	            if(!rollingOver) {
	                openInfoWindow(e);     
	            }
	            rollingOver=true;                                                                
            });	
            
            paDictionary[paMarker]=ev.target.data;
                        
			map.addOverlay(paMarker);
		}
		
		private function onMoveCursorLoading(ev:MouseEvent):void {
			loadingSprite.x = ev.stageX;
			loadingSprite.y = ev.stageY;
		} 
		
 		private function openInfoWindow(e:MapMouseEvent):void {
 			
 			var m:Object = paDictionary[e.target];
  			
 			infoWindowToOpen = new PAInfoWindow(m);
 			infoWindowToOpen.targetUrl="/sites/2027";
 			infoWindowToOpen.addEventListener(MouseEvent.ROLL_OUT,onInfowindowRollOut);
            var options:InfoWindowOptions = new InfoWindowOptions({
              customContent: infoWindowToOpen,
              padding: 10,
              hasCloseButton: false,
              pointOffset:new Point(-25,-20),
              hasShadow: false
            });
            
            infoWindowToOpen.alpha=0;
            map.openInfoWindow(new LatLng(0,0),options);
            TweenLite.to(infoWindowToOpen,0.5,{alpha:1});
                
        }	 
        
 		private var rollingOver:Boolean=false;
		private function onInfowindowRollOut(e:Event ):void {
			map.closeInfoWindow();
			rollingOver=false;
		}
		
		
			
	}
}
