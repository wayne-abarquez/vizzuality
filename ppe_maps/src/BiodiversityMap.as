package {
	import com.adobe.serialization.json.JSON;
	import com.google.maps.Alpha;
	import com.google.maps.Map;
	import com.google.maps.MapEvent;
	import com.google.maps.MapOptions;
	import com.google.maps.MapType;
	import com.google.maps.interfaces.IPane;
	import com.google.maps.overlays.Polygon;
	import com.google.maps.overlays.PolygonOptions;
	import com.google.maps.overlays.TileLayerOverlay;
	import com.google.maps.styles.FillStyle;
	import com.greensock.plugins.*;
	import com.vizzuality.maps.Multipolygon;
	import com.vizzuality.tileoverlays.GbifTileLayer;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextField;
	import flash.text.TextFormat;

	[SWF(backgroundColor=0x666666, width=312, height=175)]
	public class BiodiversityMap extends Sprite
	{

		[Embed(source="assets/buttons.swf", symbol="zoomMore_up")]
        private var ZoomInButton:Class;
        
        [Embed(source="assets/buttons.swf", symbol="zoomMore_over")]
        private var ZoomInButton_over:Class;
 
        [Embed(source="assets/buttons.swf", symbol="zoomLess_up")]
        private var ZoomOutButton:Class;
        
        [Embed(source="assets/buttons.swf", symbol="zoomLess_over")]
        private var ZoomOutButton_over:Class;	
        
        [Embed(source="assets/biodiversityMap.png")]
        private var biodiversitySprite:Class;	
        
        [Embed(source="assets/gbif.png")]
        private var logoGbif:Class;
		
		
		private var map:Map;	
		private var dataLoaded:Boolean=false;
		private var dataAnalyzed:Boolean=false;
		private var data:Object;
		private var pol:Polygon;
		private var mapKey:String = "nokey";
		private var gbifTileLayer:GbifTileLayer;	
		private var polygonPane:IPane;
		private var tilesPane:IPane;
		private var domain:String;
		private var paId:Number;
		
		
		private var textSpriteGBIFOver:TextField = new TextField();
	    private var formatTextSpriteGBIFOver:TextFormat = textSpriteGBIFOver.getTextFormat();								
 		private	var textSpriteGBIF:TextField = new TextField();
	    private var formatTextSpriteGBIF:TextFormat = textSpriteGBIF.getTextFormat();
		
		private var BitmapMap: Bitmap = new biodiversitySprite(); 
		private var spriteMap: Sprite = new Sprite(); 

	 	public function BiodiversityMap()
		{ 
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;	
			stage.addEventListener(Event.RESIZE, stageResizeHandler);	

/* 			var externalDomains:Array=["ppe.org.tiles.s3.amazonaws.com","174.129.214.28:8080","ppe.tinypla.net"];
			for each(var dom:String in externalDomains) {
			    Security.allowDomain(dom);
			    Security.loadPolicyFile("http://"+dom+"/crossdomain.xml");
			    var request:URLRequest = new URLRequest("http://"+dom+"/crossdomain.xml");
			    var loader:URLLoader = new URLLoader();
			    loader.load(request);				
			}	 */			
				
			initMap();			
			
			domain=root.loaderInfo.parameters.domain;
			if (domain=='') {
				domain = 'http://localhost:3000';
			}
			
			var dsLoader:URLLoader = new URLLoader();
			paId=root.loaderInfo.parameters.id;
			dsLoader.addEventListener(Event.COMPLETE,onDataLoaded);
			if(isNaN(paId)) {
				paId=377207;
			}
			dsLoader.load(new URLRequest(domain + "/sites/"+paId+"/json"));
			
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
				    thickness: 1,
				    color: 0x336699,
				    alpha: 0.7
				  },
				  fillStyle: {
				    color: 0x336699,
				    alpha: 0.35
				  }	
			});
			
			var mp:Multipolygon= new Multipolygon();
			mp.fromGeojsonMultiPolygon(data.coordinates,polOpt);
			mp.addToPane(polygonPane);
			
			map.setCenter(mp.getLatLngBounds().getCenter(),map.getBoundsZoomLevel(mp.getLatLngBounds()));		
		}
		

		
	
		
		private function initMap():void {
			map=new Map();
			
			var mk:String=root.loaderInfo.parameters.key;
			if(mk!=null) {
				map.key=root.loaderInfo.parameters.key;
			} else {
				map.key=mapKey;
			}			
				
			map.y=0;
			map.x=0;
			map.setSize(new Point(312, 125));
			
			map.addEventListener(MapEvent.MAP_PREINITIALIZE, preinit);
			map.addEventListener(MapEvent.MAP_READY, onMapReady);
			
			addChild(map);
		    
			BitmapMap.x = 0;
		    BitmapMap.y = 117;
			this.addChild(BitmapMap);			
			
			spriteMap.x=235;
			spriteMap.y=140;
			
			spriteMap.useHandCursor = true;
  			spriteMap.mouseChildren = false;
  			spriteMap.buttonMode = true;
  			
			this.addChild(spriteMap);	
			
			var textSprite:TextField = new TextField();
	        var formatTextSprite:TextFormat = textSprite.getTextFormat();	
	  		formatTextSprite.size = 12;
	  		formatTextSprite.font = "Arial";
			textSprite.defaultTextFormat = formatTextSprite;
            textSprite.text = "explore biodiversity data on ";
            textSprite.textColor = 0xffffff;
            textSprite.width = 172;
            textSprite.height = 20;
  			textSprite.y = 132;
  			textSprite.x = 110;
            this.addChild(textSprite); 
 	
	  		formatTextSpriteGBIF.size = 12;
	  		formatTextSpriteGBIF.font = "Arial";
			textSpriteGBIF.defaultTextFormat = formatTextSpriteGBIF;
            textSpriteGBIF.text = "GBIF network";
            textSpriteGBIF.textColor = 0x669900;
            textSpriteGBIF.width = 95;
            textSpriteGBIF.height = 16;
  			textSpriteGBIF.y = 6;
  			textSpriteGBIF.x = -50;
            spriteMap.addChild(textSpriteGBIF);
	
	  		formatTextSpriteGBIFOver.size = 12;
	  		formatTextSpriteGBIFOver.font = "Arial";
			textSpriteGBIFOver.defaultTextFormat = formatTextSpriteGBIFOver;
            textSpriteGBIFOver.text = "GBIF";
            textSpriteGBIFOver.textColor = 0xff6600;
            textSpriteGBIFOver.width = 32;
            textSpriteGBIFOver.height = 16;
  			textSpriteGBIFOver.y = 0;
  			textSpriteGBIFOver.x = 0; 
  			
 			spriteMap.addEventListener(MouseEvent.ROLL_OVER, biodiversityRollOver);
 			spriteMap.addEventListener(MouseEvent.ROLL_OUT, biodiversityRollOut);
 			spriteMap.addEventListener(MouseEvent.CLICK, biodiversityClick); 
 			
 			var logoGBIF_: Bitmap = new logoGbif();
 			logoGBIF_.x = 268;
 			logoGBIF_.y = 132;
 			this.addChild(logoGBIF_);
 			
		}	
		
		private function biodiversityClick(ev:MouseEvent):void {
 			navigateToURL(new URLRequest("http://widgets.gbif.org/pa/#/area/"+paId));
		}
		private function biodiversityRollOver(ev:MouseEvent):void {
 			spriteMap.addChild(textSpriteGBIFOver);
		}
		private	function biodiversityRollOut(ev:MouseEvent):void {
 			spriteMap.removeChild(textSpriteGBIFOver);
		}	
		
		private function preinit(ev:Event):void {
				var mo:MapOptions = new MapOptions();
				mo.backgroundFillStyle = new FillStyle({color:0xE9E9E9,alpha: Alpha.OPAQUE});
				mo.mapType=MapType.PHYSICAL_MAP_TYPE;	
				map.setInitOptions(mo);
		}		
		
		private function onMapReady(event:MapEvent):void {
			tilesPane=map.getPaneManager().createPane();
			polygonPane=map.getPaneManager().createPane();
			
			
			var zoomIn:Sprite = new ZoomInButton();			
			var zoomIn_over: Sprite = new ZoomInButton_over();
            addChild(zoomIn);
            zoomIn.x = 13;
            zoomIn.y = 135;
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
            zoomOut.x = 13;
            zoomOut.y = 151;
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
			
			
			if(dataLoaded && !dataAnalyzed) {
				dataAnalyzed=true;
				loadData();	
			}
			
			//var tl:GeoserverTileLayer = new GeoserverTileLayer();
			//var tlo:TileLayerOverlay = new TileLayerOverlay(tl);
			//tlo.foreground.alpha=1;
			//map.addOverlay(tlo);		
			
			var animalia:GbifTileLayer = new GbifTileLayer(13140803);
			//var plantae:GbifTileLayer = new GbifTileLayer(13140804);
			var gtlo:TileLayerOverlay = new TileLayerOverlay(animalia);
			tilesPane.addOverlay(gtlo);
			gtlo.foreground.alpha=0.7;
			//var gtlo2:TileLayerOverlay = new TileLayerOverlay(plantae);
			//tilesPane.addOverlay(gtlo2);
			//gtlo2.foreground.alpha=0.7;
 
		}	
		
		private function stageResizeHandler(ev:Event):void {
			if(map!=null)
				map.setSize(new Point(312, 125));
		}		
		
	}
}
