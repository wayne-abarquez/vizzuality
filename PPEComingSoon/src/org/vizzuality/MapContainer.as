package org.vizzuality{
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	public class MapContainer extends Sprite{
		
		[Embed(source="assets/mapBkg.png")]
		private var MapImage:Class;
		
		[Embed(source="assets/dot.png")]
		private var Dot:Class;
		
		[Embed( source="/fonts/LucidaGrande.swf", fontFamily="Lucida Grande" )]
		public static var LucidaGrande:Class;		
		
		public function MapContainer(){
			super();
			
			var mi:Bitmap = new MapImage();
			this.addChild(mi);
			
			var tf:TextFormat = new TextFormat();
			tf.size = 10;
			tf.align = TextFormatAlign.LEFT;
			tf.font = "Lucida Grande";
			tf.letterSpacing = 0;
			
			var t1:TextField = new TextField();
			t1.defaultTextFormat = tf;
			t1.text = "coming people from";
			t1.textColor = 0x01b4063;
			t1.width = 100;
			t1.selectable = false;
			t1.x = -12;
			t1.y = 91;
			this.addChild(t1);

			var t2:TextField = new TextField();
			t2.defaultTextFormat = tf;
			t2.text = " in the las 24 hours";
			t2.textColor = 0x1b4063;
			t2.width = 99;
			t2.x = 331;
			t2.y = 89;
			t2.selectable = false;
			this.addChild(t2);
			
			for (var i:Number = 0;i<16;i++){
				var d:Bitmap = new Dot();
				d.x =  Math.round(Math.random() * (400 - 0)) + 0;
				d.y =  Math.round(Math.random() * (130 - 10)) + 10;
				this.addChild(d);
			}
			
		}
		
	}
}