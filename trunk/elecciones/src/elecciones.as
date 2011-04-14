package
{
	import com.google.maps.LatLng;
	import com.google.maps.Map;
	import com.google.maps.MapEvent;
	import com.google.maps.MapOptions;
	import com.google.maps.controls.ControlPosition;
	import com.google.maps.controls.ZoomControl;
	import com.google.maps.controls.ZoomControlOptions;
	import com.google.maps.overlays.Polygon;
	import com.google.maps.overlays.Polyline;
	import com.google.maps.overlays.PolylineOptions;
	import com.google.maps.overlays.TileLayerOverlay;
	import com.google.maps.styles.FillStyle;
	import com.vizzuality.elecciones.map.PolygonsOverlay;
	import com.vizzuality.elecciones.map.PolygonsTileLayer;
	
	import flash.display.Bitmap;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Point;
	
	import net.hires.debug.Stats;
	
	
	[SWF(backgroundColor=0xFFFFFF, width=800, height=500)]
	public class elecciones extends Sprite {
		
		
		private var map:Map;
		private var square:Sprite;
		[Embed('assets/cargandomapa1.png')] 
		private var loadingImg:Class;		
		private var imgLoading:Bitmap;		
		
		public var pd:Vector.<Array> = new Vector.<Array>;
		public var pd_vec_lat:Vector.<Number> = new Vector.<Number>
		public var pd_vec_lon:Vector.<Number> = new Vector.<Number>
		
		private var merc_data:Array=[[-775881.081480662804097,4469522.816462433896959],
			[-773206.925957139697857,4467795.959014882333577],[-772213.668191259843297,4464726.688045101240277],
			[-769883.332663618260995,4461945.932072692550719],[-774620.408162430394441,4464726.688045101240277],
			[-776454.114807131933048,4468419.513810731470585],[-775881.081480662804097,4469522.816462433896959]];

		
		private var wgs84_data:Array=[[-6.969858341532632,37.217899295190414],
			[-6.945835993743698,37.205544944898961],[-6.936913407422094,37.183581655491935],
			[-6.915979647206022,37.163677424466819],[-6.958533520432134,37.183581655491935],
			[-6.975005987487403,37.210006238059762],[-6.969858341532632,37.217899295190414]]
		
		public function elecciones() {
			include "data.as";
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;		
			
			imgLoading= new loadingImg() as Bitmap;
			imgLoading.x = 200;
			imgLoading.y = 150;
			mouseChildren = true;
			
			map=new Map();
			map.addEventListener(MapEvent.MAP_PREINITIALIZE, preinit);
			//map.key=root.loaderInfo.parameters.mapkey;			
			map.key="sds";
			map.sensor="false";
			
			map.addEventListener(MapEvent.MAP_READY, onMapReady);
			map.setSize(new Point(800, 500));
			addChild(map);
			square = new Sprite();
			square.graphics.beginFill(0xFFFFFF);
			square.graphics.drawRect(0,0,270,191);
			square.graphics.endFill();
			square.x = 0;
			square.y = 0;			
			addChild(square);
			addChild(imgLoading);
			addChild( new Stats() );
			
		}
		
		private function preinit(ev:Event):void {
			var mo:MapOptions = new MapOptions();
			mo.center = new LatLng(37.217899295190414, -6.969858341532632);
			mo.zoom =14;
				
			mo.backgroundFillStyle = new FillStyle({color:0xFFFFFF});
			map.setInitOptions(mo);
		}	
		
		private function onMapReady(event:MapEvent):void
		{
			var zco:ZoomControlOptions= new ZoomControlOptions({
				position:new ControlPosition(ControlPosition.ANCHOR_TOP_RIGHT, 3, 3),
				hasScrollTrack:false
			});
			map.addControl(new ZoomControl(zco));
			//downloadData();
			removeChild(imgLoading);
			removeChild(square);
			
			drawCustomPolygon();
			
			//var tlo:TileLayerOverlay = new TileLayerOverlay(new PolygonsTileLayer());
			//map.addOverlay(tlo);
			
		}
		
		
		private function drawCustomPolygon() : void {
			map.clearOverlays();
			
/*			var batch : Array = [];
			for each ( var a : Array in pd ) {
				batch.push( new LatLng( a[0], a[1] ) );
			}*/
			
			var polygomOverlay : PolygonsOverlay = new PolygonsOverlay();
			polygomOverlay.vertexPoints = merc_data;
			map.addOverlay( polygomOverlay );
			
			
			var coords:Array =[]; 
			for each (var el:Array in wgs84_data) {
				coords.push(new LatLng(el[1],el[0]));
			}
			map.addOverlay(new Polygon(coords));
			
		}		
		
		
		
	}
}