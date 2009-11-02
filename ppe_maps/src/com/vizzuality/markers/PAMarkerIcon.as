package com.vizzuality.markers{
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class PAMarkerIcon extends Sprite {	

		
        public function PAMarkerIcon() {

			this.buttonMode = true;
			this.useHandCursor = true;
			this.mouseChildren = false;

			var background:Sprite = new Sprite();
 			background.graphics.beginFill(0xFFFFFF,1);
            background.graphics.drawCircle(0,0,28);
            background.graphics.endFill();
            addChild(background);
            
            var background2:Sprite = new Sprite();
 			background2.graphics.beginFill(0xff6600);
            background2.graphics.drawCircle(0,0,24);
            background2.graphics.endFill();
            addChild(background2);
            
            var text: Sprite = new Sprite();
            var tf1:TextField = new TextField();
			var format2:TextFormat = tf1.getTextFormat();
            format2.font = "Arial";
            format2.size = 11;
            format2.bold=true;
            tf1.defaultTextFormat = format2;
            tf1.text = "PA";
            tf1.textColor = 0xffffff;
            tf1.mouseEnabled = false;
            tf1.width = 19;
            tf1.height = 15;
            tf1.background = false;
            tf1.backgroundColor = 0xFFFFFF;
            tf1.x = 0;
            tf1.y = 0;
            text.addChild(tf1);
            text.x=-9;
            text.y=-7;
            addChild(text);
                
        }
  		
     }
      
 }
