package com.vizzuality.markers{
	
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class SearchMarkerIcon extends Sprite {	

		private var imageLoader:Loader = new Loader();
		private var imageMask:Sprite = new Sprite();
		
        public function SearchMarkerIcon(imageUrl:String,sites:int,isNeeded:Boolean) {

				this.buttonMode = true;
				this.useHandCursor = true;
				this.mouseChildren = false;

				imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, displayImg);
				
				var fileRequest:URLRequest = new URLRequest(imageUrl);
				imageLoader.load(fileRequest);

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
	            
                if(sites >0){
                	var tf:TextField = new TextField();
                    var format:TextFormat = tf.getTextFormat();
                    format.font = "Arial";
                    format.size = 8;
                    format.bold=true;
					format.align = TextFormatAlign.CENTER;               
                    tf.defaultTextFormat = format;
                    tf.text = sites.toString();
                    tf.textColor = 0xffffff;
                    tf.mouseEnabled = false;
					tf.autoSize = "none";
                    tf.width = 14;
                    tf.height = 15;
                    tf.x = 8;
                    tf.y = 2;
                    mouseChildren = false;
                    count.addChild(tf);
                    addChild(count);
                }
                
/*                 var percent:Sprite = new Sprite();
	            percent.graphics.beginFill(0xff6600,1);
	            percent.graphics.drawCircle(15,8,7);
	            percent.graphics.endFill();
	            percent.x=-20;
	            percent.y=20;
	            
	            if(isNeeded){ 
		            var tf1:TextField = new TextField();
					var format2:TextFormat = tf1.getTextFormat();
                    format2.font = "Arial";
                    format2.size = 10;
                    format2.bold=true;
                    tf1.defaultTextFormat = format2;
                    tf1.text = "!";
                    tf1.textColor = 0xffffff;
                    tf1.mouseEnabled = false;
					tf1.autoSize = "center";
                    tf1.width = 15;
                    tf1.height = 15;
                    tf1.background = false;
                    tf1.backgroundColor = 0xFFFFFF;
                    tf1.x = 11;
                    tf1.y = 1;
                    percent.addChild(tf1);
                    addChild(percent);
             	} */
                
        }
  		
  		private function displayImg(e:Event):void{
  			
  			imageMask.graphics.beginFill(0x330000,1);
  			imageMask.graphics.drawCircle(15,8,25);
  			imageMask.graphics.endFill();
  			
  			imageLoader.x = -10;
  			imageLoader.y = -16;
  			addChild(imageMask);
  			imageLoader.mask = imageMask; 
  			addChildAt(imageLoader,2);
  		}
      }
      
 }
