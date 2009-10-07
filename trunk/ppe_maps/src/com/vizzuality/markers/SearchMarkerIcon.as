package com.vizzuality.markers
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class SearchMarkerIcon extends Sprite {	

            public function SearchMarkerIcon(imageUrl:String,sites:int) {
     
                    var background:Shape = new Shape();
		            background.graphics.beginFill(0xFFFFFF,1);
		            background.graphics.drawCircle(15,8,28);
		            background.graphics.endFill();
		            addChild(background);
		            
		            var image:Shape = new Shape();
		            image.graphics.beginFill(0x000000,0.6);
		            image.graphics.drawCircle(15,8,25);
		            image.graphics.endFill();
		            addChild(image);
		            
		            var count:Sprite = new Sprite();
		            count.graphics.beginFill(0xff3300,1);
		            count.graphics.drawCircle(15,8,7);
		            count.graphics.endFill();
		            count.x=20;
		            count.y=-20;
		            
                    
                    var tf:TextField = new TextField();
                    var format:TextFormat = tf.getTextFormat();
                    format.font = "Arial";
                    format.size = 8;
                    format.bold=true;
                    tf.defaultTextFormat = format;
                    tf.text = sites.toString();
                    tf.textColor = 0xffffff;
                    tf.mouseEnabled = false;
					tf.autoSize = "center";
                    tf.width = 15;
                    tf.height = 15;
                    tf.background = false;
                    tf.backgroundColor = 0xFFFFFF;
                    tf.x = 8;
                    tf.y = 2;
                    mouseChildren = false;
                    count.addChild(tf);
                    addChild(count);
                    
                    var percent:Sprite = new Sprite();
		            percent.graphics.beginFill(0xff6600,1);
		            percent.graphics.drawCircle(15,8,7);
		            percent.graphics.endFill();
		            percent.x=-20;
		            percent.y=20;
		            
		            var tf1:TextField = new TextField();
                    tf1.defaultTextFormat = format;
                    tf1.text = "10";
                    tf1.textColor = 0xffffff;
                    tf1.mouseEnabled = false;
					tf1.autoSize = "center";
                    tf1.width = 15;
                    tf1.height = 15;
                    tf1.background = false;
                    tf1.backgroundColor = 0xFFFFFF;
                    tf1.x = 8;
                    tf1.y = 2;
                    percent.addChild(tf1);
                    addChild(percent);
                    
            }
      }
 }
