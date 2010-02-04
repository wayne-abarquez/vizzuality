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
	import com.vizzuality.data.ImageData;
	import com.vizzuality.maps.CustomMapEvent;
	import com.vizzuality.maps.MapEventDispatcher;
	import com.vizzuality.maps.Multipolygon;
	import com.vizzuality.markers.PAInfoWindow;
	import com.vizzuality.markers.PAMarker;
	import com.vizzuality.markers.PredefinedPaPageMarker;
	import com.vizzuality.markers.TooltipMarker;
	import com.vizzuality.tileoverlays.GeoserverTileLayer;
	
	import flash.display.Bitmap;
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
		private var mamufas: Sprite;

		private var sp2: Sprite;
		
		private var mouseOverPa:Boolean=false;


		private var mapKey:String = "nokey";
		private var mp:Multipolygon;
		private var domain: String;
		
		private var paId:Number;
		private var loadingSprite: TooltipMarker = new TooltipMarker('Click to go to this PA');;
		private var infoWindowToOpen: PAInfoWindow;
		private var paMarker: PAMarker;
		private var paDictionary: Dictionary = new Dictionary();
		private var tooltip: TooltipMarker;
		private var clickPoint: LatLng;
		private var onPAFlag: Boolean = false;
		
		[Embed(source="assets/mapButtons.swf", symbol="zoomMore_up")]
        private var ZoomInButton:Class;
        
        [Embed(source="assets/mapButtons.swf", symbol="zoomMore_over")]
        private var ZoomInButton_over:Class;
 
        [Embed(source="assets/mapButtons.swf", symbol="zoomLess_up")]
        private var ZoomOutButton:Class;
        
        [Embed(source="assets/mapButtons.swf", symbol="zoomLess_over")]
        private var ZoomOutButton_over:Class;
        
        
        
        [Embed(source="assets/PAsatelliteButton.png")]
        private var PAsatelliteButton:Class;
		[Embed(source="assets/PAsatelliteOverButton.png")]
        private var PAsatelliteOverButton:Class;  
        [Embed(source="assets/PAsatelliteSelectedButton.png")]
        private var PAsatelliteSelectedButton:Class;
              
        [Embed(source="assets/PAterrainButton.png")]
        private var PAterrainButton:Class;
        [Embed(source="assets/PAterrainOverButton.png")]
        private var PAterrainOverButton:Class;
        [Embed(source="assets/PAterrainSelectedButton.png")]
        private var PAterrainSelectedButton:Class;
        
        [Embed(source="assets/imageButton.png")]
        private var imageButton:Class;

		private var terrainButtonBitmap:Bitmap = new PAterrainButton();
		private	var terrainOverButtonBitmap:Bitmap = new PAterrainOverButton();
		private	var terrainSelectedButtonBitmap:Bitmap = new PAterrainSelectedButton();
		
		private	var satelliteButtonBitmap:Bitmap = new PAsatelliteButton();
		private	var satelliteOverButtonBitmap:Bitmap = new PAsatelliteOverButton();
		private	var satelliteSelectedButtonBitmap:Bitmap = new PAsatelliteSelectedButton();
		
		private var satelliteButtonSprite: Sprite = new Sprite();
		private var terrainButtonSprite: Sprite = new Sprite();
		
 /*
        [Embed(source="library.swf", symbol="circle")]
        private var Circle:Class; */
		
		

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
			var externalDomains:Array=["ppe.org.tiles.s3.amazonaws.com","ppe.tinypla.net:8080","ppe.tinypla.net"];
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
			square.graphics.drawRect(0,0,stage.stageWidth, stage.stageHeight);
			square.graphics.endFill();
			addChild(square);
			
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
			map.addEventListener(MapEvent.MAPTYPE_CHANGED,onMapTypeChange);
			map.setSize(new Point(stage.stageWidth, stage.stageHeight-46));
			addChildAt(map,1);
			
			mamufas = new Sprite();
			mamufas.x = 0;
			mamufas.y = 3;
			mamufas.graphics.beginFill(0x000000,0.5);
			mamufas.graphics.drawRect(0,0,stage.stageWidth, stage.stageHeight-46);
			mamufas.graphics.endFill();
			addChild(mamufas);	
				

			//get the PA data
			domain=root.loaderInfo.parameters.domain;
			if (domain==null) {
				domain = 'http://ppe.tinypla.net';
			}
			
			var dsLoader:URLLoader = new URLLoader();
			dsLoader.addEventListener(Event.COMPLETE,onDataLoaded);
			paId=root.loaderInfo.parameters.id;
			if(isNaN(paId)) {
				paId=2027;
			}
			dsLoader.load(new URLRequest(domain + "/api/site/"+paId+"/json"));
			
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
		
		private var urlOfPredefinedPicture:String;
		
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
			mp.addEventListener(MapMouseEvent.ROLL_OVER,function():void {
				onPAFlag = true;
				if (loadingSprite.parent != null) {
					loadingSprite.visible = false;
				}
			});
			mp.addEventListener(MapMouseEvent.ROLL_OUT,function():void {
				onPAFlag = false;
				if (loadingSprite.parent != null) {
					loadingSprite.visible = true;
				}
			});					
			mp.addToMap(map);
			
			
			//add the important image
			if(data.pictures!=null && (data.pictures as Array).length>0) {
				var coords:LatLng= new LatLng(
					data.pictures[0].y,
					data.pictures[0].x);
				urlOfPredefinedPicture = data.pictures[0].url;
				var marker:PredefinedPaPageMarker = new PredefinedPaPageMarker(coords,urlOfPredefinedPicture);
				map.addOverlay(marker);
			} else {
				urlOfPredefinedPicture=null;
			}
			
			
			//craete and add the right button
			var imageButtonBitmap:Bitmap = new imageButton() as Bitmap;
			imageButtonBitmap.width=124;
			imageButtonBitmap.height=27;
			sp2 = new Sprite();
			sp2.useHandCursor = true;
			sp2.mouseChildren = false;
			sp2.buttonMode = true;
			sp2.x = 648 + (stage.stageWidth/2) - (960/2);
			sp2.y = stage.stageHeight-31;
			trace();
			sp2.addChild(imageButtonBitmap);
			sp2.addEventListener(MouseEvent.CLICK,function (ev:MouseEvent):void {
				var bbox:String = data.bbox[0]+","+data.bbox[1]+","+data.bbox[2]+","+data.bbox[3];
				navigateToURL(new URLRequest(domain+"/flash/ImageSelector.swf?ID="+paId+"&Name=Null&BBox="+bbox+"&Dimensions=300x300"));
			});				
			addChild(sp2);	


			//Set the center of the map to the bbox of the area		
			var z:Number = 	map.getBoundsZoomLevel(mp.getLatLngBounds());
			if(z > 11){
				map.setCenter(mp.getLatLngBounds().getCenter(),11);		
			} else {
				map.setCenter(mp.getLatLngBounds().getCenter(),z);		
			}
			
/* 			//If there is pictures then display the ImageCarrousel
			if(data.pictures!=null && (data.pictures as Array).length>0) {
				imgC = new ImageCarrousel();
				imgC.init(data.pictures as Array);
				addChild(imgC);
				
				//Because the carrusel stay in the middle we have to pan the map and reposition
				map.panBy(new Point(-320,0),false);
				positionElements();
				
			} */
			
			//retrieve picture from panoramio
			getPanoramioPictures();
			mamufas.visible = false;
			
			//add the default PPE layer for visualizing the other Pas
			var tl:GeoserverTileLayer = new GeoserverTileLayer();
			var tlo:TileLayerOverlay = new TileLayerOverlay(tl);
			map.addOverlay(tlo);					
			
		}		
		
		private function onMapTypeChange(event:MapEvent):void {

			var polOptOrange:PolygonOptions=new PolygonOptions({
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
			var polOptBlue:PolygonOptions=new PolygonOptions({
				  strokeStyle: {
				    thickness: 2,
				    color: 0x006699,
				    alpha: 1
				  },
				  fillStyle: {
				    color: 0xFF7600,
				    alpha: 0
				  }	
			});

			if(map.getCurrentMapType()==MapType.PHYSICAL_MAP_TYPE) {
				mp.setOptions(polOptOrange);
			}
			if(map.getCurrentMapType()==MapType.SATELLITE_MAP_TYPE) {
				mp.setOptions(polOptBlue);				
			}
		}
		
		private function preinit(ev:Event):void {
				var mo:MapOptions = new MapOptions();
				mo.backgroundFillStyle = new FillStyle({color:0xE9E9E9,alpha: Alpha.OPAQUE});
				mo.mapType=MapType.PHYSICAL_MAP_TYPE;	
				map.setInitOptions(mo);
		}		
		
		private var zoomIn:Sprite;
		private var zoomOut:Sprite;
		private var typeMapSatellite_up:Sprite;
		private var typeMapTerrain_up:Sprite;
		
		private function onMapReady(event:MapEvent):void {
			
			map.addEventListener(MapMouseEvent.DOUBLE_CLICK,onMapDoubleClick);
			//map.addEventListener(MapZoomEvent.ZOOM_CHANGED,onZoomChange);
			//map.addControl(new MapTypeControl);
			
			zoomIn = new ZoomInButton();			
			var zoomIn_over: Sprite = new ZoomInButton_over();
            addChild(zoomIn);
            zoomIn.x = (stage.stageWidth/2) - 464;
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
		
			
			zoomOut = new ZoomOutButton();			
            addChild(zoomOut);
			var zoomOut_over: Sprite = new ZoomOutButton_over();
            zoomOut.x = (stage.stageWidth/2) - 434;
            zoomOut.y = 10;
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
			
			
			//add the maptypes button
			
			//terrain button
			terrainButtonSprite.x = (stage.stageWidth/2 + 322);
			terrainButtonSprite.y =	10;
			terrainButtonSprite.mouseChildren = false;
			terrainButtonSprite.buttonMode = true;
			terrainButtonSprite.useHandCursor = true;
			addChild(terrainButtonSprite);
			terrainButtonSprite.addChild(terrainButtonBitmap);
			terrainButtonSprite.addChild(terrainSelectedButtonBitmap)
	
			terrainButtonSprite.addEventListener(MouseEvent.ROLL_OVER,function (ev:MouseEvent):void {
				if(!terrainButtonSprite.contains(terrainSelectedButtonBitmap)){
					terrainButtonSprite.addChild(terrainOverButtonBitmap);
				}
			}); 
            terrainButtonSprite.addEventListener(MouseEvent.ROLL_OUT,function (ev:MouseEvent):void {
            	if(!terrainButtonSprite.contains(terrainSelectedButtonBitmap)){
					terrainButtonSprite.removeChild(terrainOverButtonBitmap);
            	}
			});
			terrainButtonSprite.addEventListener(MouseEvent.CLICK, function (ev:MouseEvent):void {
				if(satelliteButtonSprite.contains(satelliteSelectedButtonBitmap)){
					satelliteButtonSprite.removeChild(satelliteSelectedButtonBitmap);
				}
				terrainButtonSprite.addChild(terrainSelectedButtonBitmap);
				map.setMapType(MapType.PHYSICAL_MAP_TYPE);
			});
			
			//satellite button
			satelliteButtonSprite.x = (stage.stageWidth/2) + 402;
			satelliteButtonSprite.y = 10;
			satelliteButtonSprite.mouseChildren = false;
			satelliteButtonSprite.buttonMode = true;	
			satelliteButtonSprite.useHandCursor = true;
			addChild(satelliteButtonSprite);
			
			satelliteButtonBitmap.x=0;
			satelliteButtonBitmap.y=0;
			satelliteButtonSprite.addChild(satelliteButtonBitmap);
				
			satelliteButtonSprite.addEventListener(MouseEvent.ROLL_OVER,function (ev:MouseEvent):void {
				if(!satelliteButtonSprite.contains(satelliteSelectedButtonBitmap)){
					satelliteButtonSprite.addChild(satelliteOverButtonBitmap);
				}
			}); 
            satelliteButtonSprite.addEventListener(MouseEvent.ROLL_OUT,function (ev:MouseEvent):void {
				if(!satelliteButtonSprite.contains(satelliteSelectedButtonBitmap)){
					satelliteButtonSprite.removeChild(satelliteOverButtonBitmap);
				}
			});
			satelliteButtonSprite.addEventListener(MouseEvent.CLICK, function (ev:MouseEvent):void {
				if(terrainButtonSprite.contains(terrainSelectedButtonBitmap)){
					terrainButtonSprite.removeChild(terrainSelectedButtonBitmap);
				}
				satelliteButtonSprite.addChild(satelliteSelectedButtonBitmap);
				map.setMapType(MapType.SATELLITE_MAP_TYPE);
			});
						
			/* typeMapSatellite_up = new TypeMap_up();			
			addChild(typeMapSatellite_up);
			typeMapSatellite_up.x = (this.width/2) + 402;
			typeMapSatellite_up.y = 10;
			var typeMapSatellite_over:Sprite = new TypeMap_over();
			typeMapSatellite_up.addEventListener(MouseEvent.ROLL_OVER,function (ev:MouseEvent):void {
				typeMapSatellite_up.addChild(typeMapSatellite_over);
				typeMapSatellite_over.mouseChildren = false;
				typeMapSatellite_over.buttonMode = true;

			}); 
            typeMapSatellite_up.addEventListener(MouseEvent.ROLL_OUT,function (ev:MouseEvent):void {
				typeMapSatellite_up.removeChild(typeMapSatellite_over);
				typeMapSatellite_over.mouseChildren = false;
				typeMapSatellite_over.buttonMode = true; 
			});  		
			typeMapSatellite_up.addEventListener(MouseEvent.CLICK, function (ev:MouseEvent):void {
				map.setMapType(MapType.SATELLITE_MAP_TYPE);
			}); 				
			
			
			typeMapTerrain_up = new TypeMap_up();			
			addChild(typeMapTerrain_up);
			typeMapTerrain_up.x = (this.width/2) + 322;
			typeMapTerrain_up.y = 10;
			var typeMapTerrain_over:Sprite = new TypeMap_over();
			typeMapTerrain_up.addEventListener(MouseEvent.ROLL_OVER,function (ev:MouseEvent):void {
				typeMapTerrain_up.addChild(typeMapTerrain_over);
				typeMapTerrain_over.mouseChildren = false;
				typeMapTerrain_over.buttonMode = true;

			}); 
            typeMapTerrain_up.addEventListener(MouseEvent.ROLL_OUT,function (ev:MouseEvent):void {
				typeMapTerrain_up.removeChild(typeMapTerrain_over);
				typeMapTerrain_over.mouseChildren = false;
				typeMapTerrain_over.buttonMode = true; 
			});  						
			typeMapTerrain_up.addEventListener(MouseEvent.CLICK, function (ev:MouseEvent):void {
				map.setMapType(MapType.PHYSICAL_MAP_TYPE);
			}); */ 				
			

			

			MapEventDispatcher.addEventListener(CustomMapEvent.MOUSE_OUT_AREA,function(event:CustomMapEvent):void {
					mouseOverPa=false; 
					removeEventListener(MouseEvent.MOUSE_MOVE,onMoveCursorLoading);
					try {removeChild(loadingSprite);}
					catch (e:Error){}
				});
			MapEventDispatcher.addEventListener(CustomMapEvent.MOUSE_OVER_AREA,function(event:CustomMapEvent):void {
					mouseOverPa=true; 
					if (loadingSprite.parent==null) {
						/* loadingSprite = new TooltipMarker('Click to go to this PA'); */
						addChild(loadingSprite);
					}

					loadingSprite.x = event._local_x + 15;
					loadingSprite.y = event._local_y + 15;
					
					addEventListener(MouseEvent.MOUSE_MOVE,onMoveCursorLoading);
				});
			map.addEventListener(MapMouseEvent.CLICK,onMapClick);	
			
			if (dataLoaded && !dataAnalyzed) {
				dataAnalyzed = true;
				loadData();
			}			

		}		
		private function onMapClick(event:MapMouseEvent):void {
			if(mouseOverPa && !mp.pointInPolygon(event.latLng)) {
				map.closeInfoWindow();
				clickPoint = event.latLng;
/* 				loadingSprite.graphics.lineStyle(1,0x666666,1);
				loadingSprite.graphics.beginFill(0xFFFFFF);
				loadingSprite.graphics.drawRoundRect(0,0,30,30,5,5);
				loadingSprite.graphics.endFill();
				addChild(loadingSprite);
				loadingSprite.x = (map.fromLatLngToViewport(event.latLng) as Point).x;
				loadingSprite.y = (map.fromLatLngToViewport(event.latLng) as Point).y;
				this.addEventListener(MouseEvent.MOUSE_MOVE,onMoveCursorLoading); */
				
				//get PA clicked
				var dsLoader:URLLoader = new URLLoader();
				dsLoader.addEventListener(Event.COMPLETE,onGetPaByCoordsResult);
				dsLoader.addEventListener(IOErrorEvent.IO_ERROR, function (ev:IOErrorEvent):void {
						trace('empty data'); 
						try {
							map.removeOverlay(paMarker);					
						} catch (er:Error) {} 
						removeChild(loadingSprite); 
						});
						
				dsLoader.load(new URLRequest(domain + "/api/site_atts_by_point/"+(event.latLng as LatLng).lng()+"/"+ (event.latLng as LatLng).lat()));
				/* dsLoader.load(new URLRequest(domain + "/api/sites_by_point/"+(event.latLng as LatLng).lng()+"/"+ (event.latLng as LatLng).lat())); */
				/* TweenLite.delayedCall(3,onGetPaByCoordsResult,[{"name": "area", "point": event.latLng}]); */
				
			}
		}
		
		
		private function onMapDoubleClick(event:MapMouseEvent):void {
			//trace("onMapDoubleClick");			
				map.panBy(new Point(-320,0),false);
		}
		
		
		
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
			
						if((photo.photo_file_url as String).replace("mini_square","medium") !=urlOfPredefinedPicture) {
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
		        marker.addEventListener(MapMouseEvent.ROLL_OVER,function():void {
					if (loadingSprite.parent != null) {
						loadingSprite.visible = false;
					}
				});
				marker.addEventListener(MapMouseEvent.ROLL_OUT,function():void {
					if (loadingSprite.parent != null) {
						if (onPAFlag == true) {
							loadingSprite.visible = false;
						} else {
							loadingSprite.visible = true;						
						}
					}
				});    
	        	map.addOverlay(marker);
        		
        	});
	        panoramioMarkers[photo]=marker;
		} 		

		
		private function positionElements():void {
 			square.x = 0;
			square.y = 0;	
			square.height=stage.stageHeight-40;
			
			if(sp2) {
				sp2.x = 648 + (stage.stageWidth/2) - (960/2);
				sp2.y = stage.stageHeight-31; 
			}
			
			if(typeMapSatellite_up!=null)
				typeMapSatellite_up.x = (stage.stageWidth/2) + 402;
			if(typeMapTerrain_up!=null)
				typeMapTerrain_up.x = (stage.stageWidth/2) + 322;
			if(zoomIn!=null)
				zoomIn.x = (stage.stageWidth/2) - 464;
			if(zoomOut!=null)
				zoomOut.x = (stage.stageWidth/2) - 434;
			
		}
		
 		private function stageResizeHandler(ev:Event):void {
			positionElements();
			if(map!=null)
				map.setSize(new Point(stage.stageWidth, stage.stageHeight-45));
		}
		
		private function onGetPaByCoordsResult(ev:Event):void {
			
			var res:Object = JSON.decode(ev.target.data as String);

			if ((res as Array).length != 0) {
				removeChild(loadingSprite);
				navigateToURL(new URLRequest(domain + '/sites/' + res[0].id),"_self");
			}

 			
			/* this.removeEventListener(MouseEvent.MOUSE_MOVE,onMoveCursorLoading);
			try {
				map.removeOverlay(paMarker);				
			} catch (e:Error) {}
			
			paMarker = new PAMarker(ev.target.data as Object,clickPoint);
			
			paMarker.addEventListener(MapMouseEvent.ROLL_OVER, function(e:MapMouseEvent):void {
	            if(!rollingOver) {
	                openInfoWindow(e);     
	            }
	            rollingOver=true;                                                                
            });	
            
            paDictionary[paMarker]=ev.target.data;
                        
			map.addOverlay(paMarker); */
		}
		
		
		private function onMoveCursorLoading(ev:MouseEvent):void {
			loadingSprite.x = ev.stageX + 15;
			loadingSprite.y = ev.stageY + 15;
		} 
		
		
 		private function openInfoWindow(e:MapMouseEvent):void {
 			var m:Array = new Array(paDictionary[e.target]);
  			
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
            map.openInfoWindow(clickPoint,options);
            TweenLite.to(infoWindowToOpen,0.5,{alpha:1});
                
        }	 
        
 		private var rollingOver:Boolean=false;
		private function onInfowindowRollOut(e:Event ):void {
			map.closeInfoWindow();
			rollingOver=false;
		}
		
		
			
	}
}
