package com.vizzuality.utils
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	public class DataTipeSlider extends Sprite
	{
		public var tf: TextField;

		public function DataTipeSlider()
		{
			

			var background: Sprite = new Sprite();
			var arrow: Sprite = new Sprite();
			tf= new TextField();
            var format:TextFormat = tf.getTextFormat();
            format.font = "Arial";
            format.size = 9;
            format.bold = false;
			format.align = TextFormatAlign.CENTER;	                    
           	format.leftMargin = 3;
	        format.rightMargin = 3;
           	
            tf.defaultTextFormat = format;
            tf.textColor = 0xBFBFBF;
            tf.text = "1000";
			tf.autoSize = TextFieldAutoSize.CENTER;
            tf.x = 0;
            tf.y = 2;
            
            background.addChild(tf);
            background.graphics.beginFill(0x000000,0.8);
            background.graphics.drawRoundRect(0,0,tf.width,24,5);
            background.x = -tf.width/2;
            background.y = 0;
            
            arrow.graphics.lineStyle(0.8,0x000000,0.8);
            arrow.graphics.beginFill(0x000000,0.8);
            arrow.graphics.moveTo(0,0);
			arrow.graphics.lineTo(16, 0);
			arrow.graphics.lineTo(8, 8);
			arrow.graphics.lineTo(0, 0);
			arrow.x = -8;
			arrow.y = 24;
			background.addChild(arrow);     
            addChild(background);
            
            super();
            
		}

		public function setValue(v:String):void{
			tf.text = v + 'm';
		}

	}
}
