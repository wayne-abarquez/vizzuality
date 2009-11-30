package {
	import com.adobe.serialization.json.JSON;
	import com.google.maps.Alpha;
	import com.google.maps.LatLng;
	import com.google.maps.LatLngBounds;
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
	import com.google.maps.overlays.Polygon;
	import com.google.maps.overlays.PolygonOptions;
	import com.google.maps.overlays.TileLayerOverlay;
	import com.google.maps.styles.FillStyle;
	import com.greensock.TweenLite;
	import com.greensock.plugins.*;
	import com.vizzuality.ImageContainer;
	import com.vizzuality.data.ImageData;
	import com.vizzuality.maps.Multipolygon;
	import com.vizzuality.tileoverlays.GeoserverTileLayer;
	
	import flash.display.Bitmap;
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
		private var picturesSquare:Sprite;	
		private var leftArrowBitmap:Bitmap;
		private var rightArrowBitmap:Bitmap;
		private var sp1:Sprite;
		private var sp2:Sprite;
		private var butButtonsBitmap:Bitmap;
		private var dataLoaded:Boolean=false;
		private var dataAnalyzed:Boolean=false;
		private var data:Object;
		private var panoramioMarkers:Dictionary;
		private var panoramioDict:Dictionary = new Dictionary(true);
		public var picturesInfoWindows:Dictionary = new Dictionary(true);	
		private var pol:Polygon;
		private var imgArrays:Array = [];
		private var imgContainer:Sprite;
		private var maskSprite:Sprite;
		private var mapKey:String = "nokey";
		
				
		[Embed('assets/leftArrow.png')] 
		private var leftArrow:Class;				
		[Embed('assets/rightArrow.png')] 
		private var rightArrow:Class;				
		[Embed('assets/bottom_buttons.png')] 
		private var butButtons:Class;							
						
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
			
			
			picturesSquare = new Sprite();
			picturesSquare.graphics.beginFill(0xEEEEEE);
			picturesSquare.graphics.drawRoundRect(0,0,630, 250,4,4);
			picturesSquare.graphics.endFill();
			
			imgArrays.push(new ImageContainer("http://localhost:3000/images/fakePanoramio1.jpg")); 
			imgArrays.push(new ImageContainer("http://localhost:3000/images/fakePanoramio2.jpg")); 
			imgArrays.push(new ImageContainer("http://localhost:3000/images/fakePanoramio3.jpg")); 
			imgArrays.push(new ImageContainer("http://localhost:3000/images/fakePanoramio4.jpg")); 
			imgArrays.push(new ImageContainer("http://localhost:3000/images/fakePanoramio5.jpg")); 	
			
			imgContainer= new Sprite();	
			
			var i:Number=0;
			for each(var img:ImageContainer in imgArrays) {
				imgContainer.addChild(img);
				img.x = i*310;
				i++;
			}
			
			//Create mask
			maskSprite = new Sprite();
			maskSprite.graphics.beginFill(0xE9E9E9);
			maskSprite.graphics.drawRect(0,0,612, 254);
			maskSprite.graphics.endFill();	
						
			
			leftArrowBitmap= new leftArrow() as Bitmap;
			leftArrowBitmap.width=38;
			leftArrowBitmap.height=34;
			sp1 = new Sprite();
			sp1.useHandCursor = true;
			sp1.mouseChildren = false;
			sp1.buttonMode = true;
			sp1.addChild(leftArrowBitmap);
			sp1.addEventListener(MouseEvent.CLICK,handleClickImage);
			
			rightArrowBitmap= new rightArrow() as Bitmap;
			rightArrowBitmap.width=38;
			rightArrowBitmap.height=34;
			sp2 = new Sprite();
			sp2.useHandCursor = true;
			sp2.mouseChildren = false;
			sp2.buttonMode = true;
			sp2.addChild(rightArrowBitmap);
			sp2.addEventListener(MouseEvent.CLICK,handleClickImage);			

						
			butButtonsBitmap= new butButtons() as Bitmap;
			butButtonsBitmap.width=313;
			butButtonsBitmap.height=31;
			positionElements();
								
								
			addChild(picturesSquare);
			addChild(imgContainer);								
			addChild(maskSprite);								
			addChild(sp1);
			addChild(sp2);
			addChild(butButtonsBitmap);								
								
			imgContainer.mask= maskSprite;		
								
								
			initMap();			

			var dsLoader:URLLoader = new URLLoader();
			dsLoader.addEventListener(Event.COMPLETE,onDataLoaded);
			var paId:Number=root.loaderInfo.parameters.id;
			if(isNaN(paId)) {
				paId=1;
			}
			dsLoader.load(new URLRequest("http://localhost:3000/sites/"+paId+"/json"));
			
		}
		
		private var fl:Boolean = true;
		private var position:Number = 0;
		private function handleClickImage(e:MouseEvent):void{
			TweenLite.killTweensOf(imgContainer,true);
			if(fl){
				if (e.currentTarget == sp1 && position > 0){
					TweenLite.to(imgContainer,0.7,{x:imgContainer.x + 310});
					position--;
				}else if(e.currentTarget == sp2 && position < 3){
					TweenLite.to(imgContainer,0.7,{x:imgContainer.x - 310});
					position++;				
				}
			}
		}
		
		private function onDataLoaded(event:Event):void {
			dataLoaded=true;
			data = JSON.decode(event.currentTarget.data as String);
			
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
			
			var mp:Multipolygon= new Multipolygon();
			mp.fromGeojsonMultiPolygon(data.coordinates,polOpt);						
			mp.addToMap(map);
			
			map.setCenter(mp.getLatLngBounds().getCenter(),map.getBoundsZoomLevel(mp.getLatLngBounds())-1);		
			map.panBy(new Point(-320,0),false);
					
			
			
			//getPanoramioPics();		
				
		}
		
		private function positionElements():void {
			square.x = (stage.stageWidth/2) - (960/2);
			square.y = 0;	
			square.height=stage.stageHeight-40;
			picturesSquare.x = square.x ;
			picturesSquare.y = stage.stageHeight-picturesSquare.height-20;	
			imgContainer.x = picturesSquare.x+10;
			imgContainer.y = picturesSquare.y+10;	
			maskSprite.x = picturesSquare.x+9;
			maskSprite.y = picturesSquare.y+10;	
/* 			imgLoading1.x = picturesSquare.x+10;
			imgLoading1.y = picturesSquare.y+10;	
			imgLoading2.x = picturesSquare.x+320;
			imgLoading2.y = picturesSquare.y+10;	 */
			
			sp1.x=picturesSquare.x - 10;									
			sp1.y=picturesSquare.y + 40;								
			sp2.x=(picturesSquare.x+picturesSquare.width)-28;									
			sp2.y=picturesSquare.y+178;	
			butButtonsBitmap.x=picturesSquare.width	+picturesSquare.x +16;
			butButtonsBitmap.y=	sp2.y + 55;				
		}
		
 		private function stageResizeHandler(ev:Event):void {
			positionElements();
			if(map!=null)
				map.setSize(new Point(stage.stageWidth, stage.stageHeight-45));
		}	
		
		private function initMap():void {
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
		
		private function getPanoramioPics():void {
			var url:String= "http://www.panoramio.com/map/get_panoramas.php?order=popularity&set=public&from=0&to=2&size=mini_square";
			
			panoramioMarkers = new Dictionary(true);
			var bbox:LatLngBounds=pol.getLatLngBounds();
			var firstBBox:LatLngBounds = new LatLngBounds(bbox.getSouthWest(),bbox.getCenter());
			var secondBBox:LatLngBounds = new LatLngBounds(bbox.getCenter(),bbox.getNorthEast());
			var thirdBBox:LatLngBounds = new LatLngBounds(firstBBox.getNorthWest(),new LatLng(secondBBox.getNorth(),bbox.getCenter().lng()));
			var fourthBBox:LatLngBounds = new LatLngBounds(firstBBox.getSouthEast(),secondBBox.getSouthEast());			
			
			var loader:URLLoader= new URLLoader();
			loader.addEventListener(Event.COMPLETE,onPanoramioResult);
			
 			loader.load(new URLRequest(url + "&minx="+firstBBox.getWest()+"&miny="+firstBBox.getSouth()+"&maxx="+firstBBox.getEast()+"&maxy="+firstBBox.getNorth()));
			loader.load(new URLRequest(url + "&minx="+secondBBox.getWest()+"&miny="+secondBBox.getSouth()+"&maxx="+secondBBox.getEast()+"&maxy="+secondBBox.getNorth()));
			loader.load(new URLRequest(url + "&minx="+thirdBBox.getWest()+"&miny="+thirdBBox.getSouth()+"&maxx="+thirdBBox.getEast()+"&maxy="+thirdBBox.getNorth()));
			loader.load(new URLRequest(url + "&minx="+fourthBBox.getWest()+"&miny="+fourthBBox.getSouth()+"&maxx="+fourthBBox.getEast()+"&maxy="+fourthBBox.getNorth()));
//			loader.load(new URLRequest(url + "&minx="+bbox.getWest()+"&miny="+bbox.getSouth()+"&maxx="+bbox.getEast()+"&maxy="+bbox.getNorth()));
			
		}		
		
		private function onPanoramioResult(event:Event):void {
			var res:Object = JSON.decode(event.currentTarget.data as String);
			for each(var photo:Object in res.photos) {
				//if(pa.geometry.pointInPolygon(new LatLng(photo.latitude, photo.longitude)) && (!existingPoints.indexOf(photo.latitude+photo.longitude)>=0)) {
					
					var img:ImageData=new ImageData();
					img.latlng = new LatLng(photo.latitude,photo.longitude);
					img.source="Panoramio";
					img.owner = photo.owner_name
					img.sourceUrl = photo.photo_url;
					img.title = photo.photo_title;
					img.imageUrl = (photo.photo_file_url as String).replace("medium","small");
					img.thumbnail = (photo.photo_file_url as String).replace("medium","mini_square");
					img.id=photo.photo_id;
					img.height=photo.height;
					img.width=photo.width;
					
					
					//pictures.addItem(img);
					var loader:Loader = new Loader();
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE, createPanoramioMarker,false,0,true);
					panoramioDict[loader]=img;
					loader.load(new URLRequest(img.thumbnail));			
					
				//}
			}			
		}
		
		private function createPanoramioMarker(ev:Event):void {
			
			var photo:ImageData=panoramioDict[ev.target.loader];
			
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
		   		
/* 		   		var optionsMark:InfoWindowOptions = new InfoWindowOptions({
	                customContent: loader.loader,
	                strokeStyle: new StrokeStyle({thickness: 6, color:0xFFFFFF}),
	                customOffset: new Point(0, 10),
	                cornerRadius:0,
					hasShadow:false,
	                width: (photo.width/2.1),
	                height: (photo.height/2.1),
	                drawDefaultFrame: true					
				});  	 
				picturesInfoWindows[marker]=optionsMark; */
				
		        marker.addEventListener(MapMouseEvent.CLICK, function(e:MapMouseEvent):void {
		      		//marker.openInfoWindow(optionsMark);  
		      		//map.panTo(e.latLng);   
		        });      
		        
	        	map.addOverlay(marker);
        		
        	});
	        panoramioMarkers[photo]=marker;
		} 		
		
		
				
	}
}
