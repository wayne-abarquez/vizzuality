package {
	import com.adobe.serialization.json.JSON;
	import com.google.maps.Alpha;
	import com.google.maps.InfoWindowOptions;
	import com.google.maps.LatLng;
	import com.google.maps.Map;
	import com.google.maps.MapEvent;
	import com.google.maps.MapMouseEvent;
	import com.google.maps.MapOptions;
	import com.google.maps.MapType;
	import com.google.maps.controls.ControlPosition;
	import com.google.maps.controls.ZoomControl;
	import com.google.maps.controls.ZoomControlOptions;
	import com.google.maps.overlays.Marker;
	import com.google.maps.overlays.MarkerOptions;
	import com.google.maps.overlays.PolygonOptions;
	import com.google.maps.overlays.TileLayerOverlay;
	import com.google.maps.styles.FillStyle;
	import com.google.maps.styles.StrokeStyle;
	import com.greensock.plugins.*;
	import com.vizzuality.ImageCarrousel;
	import com.vizzuality.data.ImageData;
	import com.vizzuality.maps.Multipolygon;
	import com.vizzuality.tileoverlays.GeoserverTileLayer;
	
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
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
		private var panoramioDict:Dictionary = new Dictionary(true);
		public var picturesInfoWindows:Dictionary = new Dictionary(true);	

		private var imgC:ImageCarrousel;


		private var mapKey:String = "nokey";
		private var mp:Multipolygon;
		
		private var paId:Number;
		
				
			
		/*[Embed('assets/bottom_buttons.png')] 
		private var butButtons:Class;	*/						
						
		public function PaMap()
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
			
			square = new Sprite();
			square.graphics.beginFill(0x275186);
			square.graphics.drawRect(0,0,960, stage.stageHeight);
			square.graphics.endFill();
			
			
			addChildAt(square,0);
			
			positionElements();	
								
								
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

			var dsLoader:URLLoader = new URLLoader();
			dsLoader.addEventListener(Event.COMPLETE,onDataLoaded);
			paId=root.loaderInfo.parameters.id;
			if(isNaN(paId)) {
				paId=377207;
			}
			dsLoader.load(new URLRequest("http://localhost:3000/sites/"+paId+"/json"));
			
		}
		
		private function onDataLoaded(event:Event):void {
			dataLoaded=true;
			data = JSON.decode(event.currentTarget.data as String);
			
			//fake addition of pictures
			data.pictures=[];
			for (var im:Number=1;im<=4;im++) {
				data.pictures.push({id:im,lat:(44.498121*(1+im/500)),lng:(-110.22743*(1+im/500))});
			}
			//end of fake pictures
			
			
			if(map.isLoaded() && !dataAnalyzed) {
				dataAnalyzed=true;
				loadData();				
			}
				
		}
		
		
		private function loadData():void {
			
			
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
			
			mp= new Multipolygon();
			mp.fromGeojsonMultiPolygon(data.coordinates,polOpt);						
			mp.addToMap(map);
			
			//Place images
			for each(var pic:Object in data.pictures) {
				var img:ImageData=new ImageData();
				img.latlng = new LatLng(pic.lat,pic.lng);
				img.imageUrl = "http://localhost:3000/images/paimages/"+paId+"_"+pic.id+"_m.jpg";
				img.thumbnail = "http://localhost:3000/images/paimages/"+paId+"_"+pic.id+"_s.jpg";
				img.id=pic.id;
				img.height=293;
				img.width=245;
				var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, createPanoramioMarker,false,0,true);
				panoramioDict[loader]=img;
				loader.load(new URLRequest(img.thumbnail));				
			}

			
			
			
			map.setCenter(mp.getLatLngBounds().getCenter(),map.getBoundsZoomLevel(mp.getLatLngBounds())-1);		
			
			if((data.pictures as Array).length>0) {
				imgC = new ImageCarrousel();
				imgC.init(data.pictures as Array);
				addChild(imgC);
				
				map.panBy(new Point(-320,0),false);
				positionElements();
				
			}
			
					
			
			
			//getPanoramioPics();		
				
		}		
			
		
		private function preinit(ev:Event):void {
				var mo:MapOptions = new MapOptions();
				mo.backgroundFillStyle = new FillStyle({color:0xE9E9E9,alpha: Alpha.OPAQUE});
				mo.mapType=MapType.PHYSICAL_MAP_TYPE;	
				map.setInitOptions(mo);
		}		
		
		private function onMapReady(event:MapEvent):void {
			var zco:ZoomControlOptions= new ZoomControlOptions({
				position:new ControlPosition(ControlPosition.ANCHOR_TOP_LEFT, 10, 10)
			});
			map.addControl(new ZoomControl(zco));
			
			if(dataLoaded && !dataAnalyzed) {
				dataAnalyzed=true;
				loadData();	
			}
			
			var tl:GeoserverTileLayer = new GeoserverTileLayer();
			var tlo:TileLayerOverlay = new TileLayerOverlay(tl);
			//tlo.foreground.alpha=1;
			map.addOverlay(tlo);				

		}		
			

		
		private function createPanoramioMarker(ev:Event):void {
			
			var photo:ImageData=panoramioDict[ev.target.loader];
			(ev.target.loader as Loader).width=25;
			(ev.target.loader as Loader).height=25;
			
			var latlng:LatLng = photo.latlng;
	      	var photoUrl:String = photo.imageUrl;
	      	
	       var marker:Marker = new Marker(latlng, new MarkerOptions(
	       	{tooltip: photo.title,
	       	 draggable:false,
	       	 hasShadow:false,	        
	       	 icon: ev.target.loader}));		        
              
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
			
			
			//picturesSquare.x = square.x ;
			//picturesSquare.y = stage.stageHeight-picturesSquare.height-20;	
			//imgContainer.x = picturesSquare.x+10;
			//imgContainer.y = picturesSquare.y+10;	
			//maskSprite.x = picturesSquare.x+9;
			//maskSprite.y = picturesSquare.y+10;	
/* 			imgLoading1.x = picturesSquare.x+10;
			imgLoading1.y = picturesSquare.y+10;	
			imgLoading2.x = picturesSquare.x+320;
			imgLoading2.y = picturesSquare.y+10;	 */
			
/* 			sp1.x=picturesSquare.x - 10;									
			sp1.y=picturesSquare.y + 40;								
			sp2.x=(picturesSquare.x+picturesSquare.width)-28;									
			sp2.y=picturesSquare.y+178;	 */
			//butButtonsBitmap.x=picturesSquare.width	+picturesSquare.x +16;
			//butButtonsBitmap.y=	sp2.y + 55;				
		}
		
 		private function stageResizeHandler(ev:Event):void {
			positionElements();
			if(map!=null)
				map.setSize(new Point(stage.stageWidth, stage.stageHeight-45));
		}	
		

		
				
	}
}
