package com.vizzuality.markers
{
	import com.greensock.easing.Back;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	public class TooltipMarker extends Sprite
	{
		public function TooltipMarker(name:String) {
			

			
			var tf:TextField = new TextField();
            var format:TextFormat = tf.getTextFormat();
            format.font = "Arial";
            format.size = 10;
            format.bold=true;
			format.align = TextFormatAlign.CENTER;	                    
           	format.leftMargin = 6;
           	format.rightMargin = 6;
           	
            tf.defaultTextFormat = format;
            tf.background = true;
            tf.backgroundColor = 0x333333;

            tf.text = name;
            tf.textColor = 0xffffff;
			tf.autoSize = TextFieldAutoSize.LEFT;
            tf.x = 0;
            tf.y = 0;
            addChild(tf);
			super();
		}
		
	}
}