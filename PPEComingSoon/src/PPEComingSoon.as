package {
	
	import flash.display.Bitmap;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import org.vizzuality.MapContainer;
	import org.vizzuality.SentenceContainer;

	[SWF( backgroundColor='0xFF0000', frameRate='30' )]

	public class PPEComingSoon extends Sprite{

		private var bkg:Shape = new Shape();
		private var fluidObjects:Array = new Array();

		[Embed(source="assets/focus.png")]
		private var FocusImg:Class;

		[Embed(source="assets/title.png")]
		private var TitleImg:Class;
		
		[Embed( source="/fonts/LucidaGrande.swf", fontFamily="Lucida Grande" )]
		public static var LucidaGrande:Class;		
		
		private var textGlow:GlowFilter= new GlowFilter(0x000000,.2,5,5,2,2);		
		
		public function PPEComingSoon(){
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.addEventListener(Event.RESIZE,handleResize);
			
			drawBackground();
			drawFocus();
		}
		
		//Pinta el bkg
		private function drawBackground():void{
			
 			var colors:Array = [0x082e53,0x23598c];
			var alphas:Array = [1, 1];
			var ratios:Array = [70, 255];
			var matr:Matrix = new Matrix();
			matr.createGradientBox(stage.stageWidth, stage.stageHeight, 11, 0, 0);
			
			bkg.graphics.beginGradientFill(GradientType.LINEAR,colors,alphas,ratios,matr,SpreadMethod.PAD);	
			bkg.graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight);
			bkg.graphics.endFill();
			this.addChild(bkg);
		}
		
		private function drawFocus():void{
			//Pinta el haz de luz
			var s:Bitmap = new FocusImg();
			fluidObjects.push(s);
			s.x = (stage.stageWidth / 2) - (s.width/2); 
			s.y = (stage.stageHeight) - 960; 
			this.addChild(s);
			
			//Pinta el titulo grande
			var t:Bitmap = new TitleImg();
			fluidObjects.push(t);
			t.x = (stage.stageWidth / 2) - (t.width/2); 
			t.y = (stage.stageHeight / 2) - 200; 
			this.addChild(t);
			
			//Pinta el subtitulo
			var tf:TextFormat = new TextFormat();
			tf.size = 16;
			tf.align = TextFormatAlign.CENTER;
			tf.font = "Lucida Grande";
			tf.letterSpacing= -1;
			
			var st:TextField = new TextField();
			st.defaultTextFormat = tf;
			st.text = "Launching srping 2010";
			st.textColor = 0xFFFFFF;
			st.width = 200;
			st.selectable = false;
			st.filters = [textGlow];
			st.x = (stage.stageWidth / 2) - (st.width/2);
			st.y = (stage.stageHeight / 2) - 125;
			this.addChild(st);			
			fluidObjects.push(st);
			
			//Pinta el sencenceContainer;
			var sc:SentenceContainer = new SentenceContainer();
			fluidObjects.push(sc);
			sc.x = (stage.stageWidth / 2) - (sc.width/2);
			sc.y = (stage.stageHeight / 2) - 60;
			this.addChild(sc);
			
			//Pinta el mapa
			var map:MapContainer = new MapContainer();
			fluidObjects.push(map);
			map.x = (stage.stageWidth / 2) - (map.width/2);
			map.y = (stage.stageHeight / 2) + 30;
			this.addChild(map);
			
		}
		
		private function handleResize(e:Event):void{
			var i:Number = 0;
			bkg.width = stage.stageWidth;			
			bkg.height = stage.stageHeight;
			
			//Centra todos los elementos en el eje x
			for(i=0;i<=fluidObjects.length-1;i++){
				fluidObjects[i].x = (stage.stageWidth / 2) - (fluidObjects[i].width / 2); 
			}
			fluidObjects[0].y = (stage.stageHeight) - 960;
			fluidObjects[1].y = (stage.stageHeight / 2) - 200;
			fluidObjects[2].y = (stage.stageHeight / 2) - 125;
			fluidObjects[3].y = (stage.stageHeight / 2) - 60;
			fluidObjects[4].y = (stage.stageHeight / 2) + 30;
		}
	}
}
