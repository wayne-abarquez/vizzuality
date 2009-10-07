package {
	import com.google.maps.Alpha;
	import com.google.maps.Map;
	import com.google.maps.MapEvent;
	import com.google.maps.MapOptions;
	import com.google.maps.MapType;
	import com.google.maps.styles.FillStyle;
	import com.greensock.plugins.*;
	import com.vizzuality.*;
	import com.vizzuality.view.SearchBox;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.Security;
	import flash.utils.Timer;

	[SWF(backgroundColor=0xEEEEEE, widthPercent=100, heightPercent=100)]
	public class SearchMap extends Sprite
	{
		private var map:Map;
		private var mapKey:String = "nokey";
							
						
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
				map.setSize(new Point(stage.stageWidth, stage.stageHeight-15));				
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
				
			map.y=15;
			
			//timerResizing = new Timer(100);
			
			map.addEventListener(MapEvent.MAP_PREINITIALIZE, preinit);
			map.addEventListener(MapEvent.MAP_READY, onMapReady);
			map.setSize(new Point(stage.stageWidth, stage.stageHeight-15));
			addChild(map); 				
			
			
		}		
		
		private function preinit(ev:Event):void {
				var mo:MapOptions = new MapOptions();
				mo.backgroundFillStyle = new FillStyle({color:0xE9E9E9,alpha: Alpha.OPAQUE});
				mo.mapType=MapType.PHYSICAL_MAP_TYPE;	
				map.setInitOptions(mo);
		}		
		
		private function onMapReady(event:MapEvent):void {
			var searchBox: SearchBox = new SearchBox(this.width);
			searchBox.x = (this.width/2)-475;
			searchBox.y = 0;
			addChild(searchBox);
	 	}					
	}
}
