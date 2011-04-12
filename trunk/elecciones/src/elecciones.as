package
{
	import com.google.maps.Map;
	import com.google.maps.MapEvent;
	import com.google.maps.MapOptions;
	import com.google.maps.controls.ControlPosition;
	import com.google.maps.controls.ZoomControl;
	import com.google.maps.controls.ZoomControlOptions;
	import com.google.maps.styles.FillStyle;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Point;
	
	[SWF(backgroundColor=0xFFFFFF, width=598, height=400)]
	public class elecciones extends Sprite {
		
		
		private var map:Map;
		private var square:Sprite;
		[Embed('assets/cargandomapa1.png')] 
		private var loadingImg:Class;		
		private var imgLoading:Bitmap;		
		
		public function elecciones() {
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
			map.setSize(new Point(598, 400));
			addChild(map);
			square = new Sprite();
			square.graphics.beginFill(0xFFFFFF);
			square.graphics.drawRect(0,0,270,191);
			square.graphics.endFill();
			square.x = 0;
			square.y = 0;			
			addChild(square);
			addChild(imgLoading);
			
		}
		
		private function preinit(ev:Event):void {
			var mo:MapOptions = new MapOptions();
			mo.backgroundFillStyle = new FillStyle({color:0xFFFFFF});
			map.setInitOptions(mo);
		}	
		
		private function onMapReady(event:MapEvent):void
		{
			var zco:ZoomControlOptions= new ZoomControlOptions({
				position:new ControlPosition(ControlPosition.ANCHOR_TOP_LEFT, 3, 3),
				hasScrollTrack:false
			});
			map.addControl(new ZoomControl(zco));
			//downloadData();
			removeChild(imgLoading);
			removeChild(square);
		}
		
	}
}