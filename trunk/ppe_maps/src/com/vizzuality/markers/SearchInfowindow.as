package com.vizzuality.markers
{
	import com.vizzuality.VizzualityShape;
	
	import flash.display.Bitmap;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class SearchInfowindow extends Sprite
	{
			[Embed(source="/assets/arrow.gif")]
			public var imgcls:Class;
          
            public function SearchInfowindow(ob:Object) {
 					
 					var linGrad:String = GradientType.LINEAR;  /* 0x316ea7 */
				   	var linMatrix:Matrix = new Matrix();
				    linMatrix.createGradientBox(width,height,30);
				    var linColors:Array = [0x4f92cf, 0x316ea7];
				    var linAlphas:Array = [1, 1];
				    var linRatios:Array = [0, 255];
			        var lin:Sprite = new Sprite();
			   		lin.graphics.beginGradientFill(linGrad, linColors, linAlphas, linRatios,linMatrix);
			   		lin.graphics.drawRoundRect(0,7,225,41,5);
			        addChild(lin);
			        
			        var imgcls: Bitmap = new imgcls();
			        imgcls.y = 22;
			        imgcls.x = 5;
			        addChild(imgcls);;
 					
 					var background:Sprite = new Sprite();
 					background.graphics.beginGradientFill(linGrad, linColors, linAlphas, linRatios,linMatrix);
		            background.graphics.drawCircle(40,28,28);
		            background.graphics.endFill();
		            addChild(background);
		            
		            var image:Shape = new Shape();
		            image.graphics.beginFill(0xcccccc,1);
		            image.graphics.drawCircle(40,28,25);
		            image.graphics.endFill();
		            addChild(image);
		            
		            var count:Sprite = new Sprite();
		            count.graphics.beginFill(0xff3300,1);
		            count.graphics.drawCircle(40,28,7);
		            count.graphics.endFill();
		            count.x=20;
		            count.y=-20;
		            addChild(count);
                    
                    var tf:TextField = new TextField();
                    var format:TextFormat = tf.getTextFormat();
                    format.font = "Arial";
                    format.size = 8;
                    format.bold=true;
                    tf.defaultTextFormat = format;
                    tf.text = "10";
                    tf.textColor = 0xffffff;
                    tf.mouseEnabled = false;
					tf.autoSize = "center";
                    tf.width = 15;
                    tf.height = 15;
                    tf.background = false;
                    tf.backgroundColor = 0xFFFFFF;
                    tf.x = 53;
                    tf.y = 2;
                    mouseChildren = false;
                    addChild(tf);
                    
                    var percent:Sprite = new Sprite();
		            percent.graphics.beginFill(0xff6600,1);
		            percent.graphics.drawCircle(40,28,7);
		            percent.graphics.endFill();
		            percent.x=-20;
		            percent.y=20;
                    addChild(percent);
                    
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
                    tf1.x = 13;
                    tf1.y = 43;
                    addChild(tf1);
                    
                    
                    var exampleSprite: VizzualityShape = new VizzualityShape("http://localhost:3000/");
		            var countryText: TextField = new TextField();
		            countryText.text =  ob.area;
		            var newFormat:TextFormat = new TextFormat(); 
		   			newFormat.size = 12; 
		   			newFormat.color = 0xFFFFFF;
		   			newFormat.bold = true;
		   			newFormat.letterSpacing = 0;
					newFormat.font = "Helvetica";
		    		countryText.setTextFormat(newFormat); 
		            countryText.wordWrap = true;
		            countryText.width = 150;
		            countryText.height = 30;
		            countryText.x = 0;
		            countryText.y = 0;
		            exampleSprite.x = 73;
		            exampleSprite.y = 14;
		            exampleSprite.addChild(countryText);
		            exampleSprite.width = 150;
		            exampleSprite.height = 30; 
		            exampleSprite.mouseChildren=false;
		            exampleSprite.buttonMode=true;
		            exampleSprite.useHandCursor=true;
		            addChild(exampleSprite);
		            exampleSprite.addEventListener(MouseEvent.CLICK,clicked); 
		            
		            var exampleSprite2: VizzualityShape = new VizzualityShape("http://localhost:3000/");
		            var countryText2: TextField = new TextField();
		            countryText2.text =  "Local area PPE";
		            var newFormat2:TextFormat = new TextFormat(); 
		   			newFormat2.size = 10; 
		   			newFormat2.color = 0xFFFFFF;
		   			newFormat2.italic = true;
		   			newFormat2.letterSpacing = 0;
					newFormat2.font = "Helvetica";
		    		countryText2.setTextFormat(newFormat2); 
		            countryText2.wordWrap = true;
		            countryText2.width = 150;
		            countryText2.height = 30;
		            countryText2.x = 0;
		            countryText2.y = 0;
		            exampleSprite2.x = 73;
		            exampleSprite2.y = 26;
		            exampleSprite2.addChild(countryText2);
		            exampleSprite2.width = 150;
		            exampleSprite2.height = 30; 
		            exampleSprite2.mouseChildren=false;
		            exampleSprite2.buttonMode=true;
		            exampleSprite2.useHandCursor=true;
		            addChild(exampleSprite2);
		            exampleSprite2.addEventListener(MouseEvent.CLICK,clicked); 
 					

            }
            
          	private function clicked(event:MouseEvent):void {
			    navigateToURL(new URLRequest(event.target.url));
			}
      }
}