package com.vizzuality.markers
{
	import com.google.maps.Color;
	import com.vizzuality.utils.StringUtils;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	public class TooltipMarker extends Sprite
	{
		public function TooltipMarker(name:String) {
			
			var background: Sprite = new Sprite();
			var arrow: Sprite = new Sprite();
			var tf:TextField = new TextField();
            var format:TextFormat = tf.getTextFormat();
            format.font = "Arial";
            format.size = 11;
            format.bold=true;
			format.align = TextFormatAlign.CENTER;	                    
           	format.leftMargin = 5;
	        format.rightMargin = 5;
           	format.align = "center";
           	
            tf.defaultTextFormat = format;
            tf.text = StringUtils.truncate(name,30);
            tf.textColor = 0xffffff;
			tf.autoSize = TextFieldAutoSize.LEFT;
            tf.x = 0;
            tf.y = 4;
            
            background.addChild(tf);
            background.graphics.beginFill(0x000000,0.8);
            background.graphics.drawRoundRect(0,0,tf.width,24,5);
            background.x = -tf.width/2;
            background.y = 0;
            addChild(background);
            
            arrow.graphics.lineStyle(0.8,0x000000,0.3);
            arrow.graphics.beginFill(0x000000,0.8);
            arrow.graphics.moveTo(0,0);
			arrow.graphics.lineTo(16, 0);
			arrow.graphics.lineTo(8, 8);
			arrow.graphics.lineTo(0, 0);
			arrow.x = -8;
			arrow.y = 24;
			addChild(arrow);     
            
			super();
		}
		
	}
}