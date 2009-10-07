package {
	import com.google.maps.Alpha;
	import com.google.maps.Map;
	import com.google.maps.MapEvent;
	import com.google.maps.MapOptions;
	import com.google.maps.MapType;
	import com.google.maps.styles.FillStyle;
	import com.greensock.plugins.*;
	import com.vizzuality.*;
	
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
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
	
				this.addChild(searchContainer);
				
				var tf:TextFormat = new TextFormat();
				tf.size = 14;
				tf.color = 0x666666;
				tf.italic = true;
				tf.font = "Arial";
				tf.leftMargin = 5;
				tf.rightMargin = 5;
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
				this.addChild(ti);
				
				
				var zoomPlus:vizzButton = new vizzButton(this,1061,12,124,30,"Search",18,32,5);
				var separateBar:Sprite = new Sprite();
				separateBar.graphics.beginFill(0xcccccc);
		   		separateBar.graphics.drawRect(1061,13,1,29);
		   		separateBar.graphics.endFill();
		   		this.addChild(separateBar);
				      
	            var exampleSprite: VizzualityShape = new VizzualityShape("http://localhost:3000/");
	            var countryText: TextField = new TextField();
	            countryText.text =  "E.x: Yosemite Natural park";
	            var newFormat:TextFormat = new TextFormat(); 
       			newFormat.size = 10; 
       			newFormat.color = 0xFFFFFF;
       			newFormat.bold = true;
       			newFormat.letterSpacing = 0;
				newFormat.font = "Arial";
        		countryText.setTextFormat(newFormat); 
	            countryText.wordWrap = true;
	            countryText.width = 150;
	            countryText.height = 30;
	            countryText.x = 0;
	            countryText.y = 0;
	            exampleSprite.x = 255;
	            exampleSprite.y = 44;
	            exampleSprite.addChild(countryText);
	            exampleSprite.width = 150;
	            exampleSprite.height = 30; 
	            exampleSprite.mouseChildren=false;
                exampleSprite.buttonMode=true;
                exampleSprite.useHandCursor=true;
	            addChild(exampleSprite);
	            exampleSprite.addEventListener(MouseEvent.CLICK,clicked);					
		}	
		
		private function clicked(event:MouseEvent):void {
			    navigateToURL(new URLRequest(event.target.url));
		}					
	}
}
