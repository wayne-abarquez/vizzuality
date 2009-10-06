package {
	import com.google.maps.Alpha;
	import com.google.maps.Map;
	import com.google.maps.MapEvent;
	import com.google.maps.MapOptions;
	import com.google.maps.MapType;
	import com.google.maps.styles.FillStyle;
	import com.greensock.plugins.*;
	
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.Security;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
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
			
				var searchContainer:Sprite = new Sprite();
				var fillType:String = GradientType.LINEAR;
				var colors:Array = [0xfd9700, 0xe68000];
				var alphas:Array = [1, 1];
				var ratios:Array = [0, 255];
				var matrix:Matrix = new Matrix();
				var gradWidth:Number = 360;
				var gradHeight:Number = 240;
				var gradRotation:Number =  Math.PI; // rotation expressed in radians
				var gradOffsetX:Number = 0;
				var gradOffsetY:Number = 0;
	
				matrix.createGradientBox(gradWidth, gradHeight, gradRotation, gradOffsetX, gradOffsetY);
				var spreadMethod:String = SpreadMethod.PAD;
				searchContainer.graphics.beginGradientFill(fillType, colors, alphas, ratios, matrix, spreadMethod);
				searchContainer.graphics.drawRoundRect((this.width/2)-475, 0, 950, 68, 5);
				searchContainer.graphics.endFill();
	
				addChild(searchContainer);
				
				var tf:TextFormat = new TextFormat();
				tf.size = 20;
				tf.color = 0x666666;
				tf.italic = true;
				var ti:TextField = new TextField();
				ti.type = TextFieldType.INPUT;
				ti.backgroundColor = 0xffffff;
				ti.background = true;
				ti.border = true;
				ti.borderColor = 0xc46d00;
				ti.x = this.width/2 - 465;
				ti.y = 12;
				ti.width = 806;
				ti.height = 30;
				ti.defaultTextFormat = tf;
				addChild(ti);
				

				var tf2:TextFormat = new TextFormat();
				tf2.size = 13;
				tf2.bold = true;
				tf2.color = 0xFFFFFF;
				var ti2:TextField = new TextField();
				ti2.x = 255;
				ti2.y = 44;
				ti2.width = 150;
				ti2.height = 30;
				ti2.text = "E.x: Yosemite Narual park";
				ti2.defaultTextFormat = tf2;
				
				addChild(ti2);
				
				
		}			
				
	}
}
