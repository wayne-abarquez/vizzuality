package com.vizzuality.markers
{
	import com.vizzuality.VizzualityShape;
	
	import flash.display.Bitmap;
	import flash.display.GradientType;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class PAInfoWindow extends Sprite{
		
			[Embed(source="/assets/arrow.gif")]
			public var imgcls:Class;
			
			private var imageLoader:Loader = new Loader();
			private var imageMask:Sprite = new Sprite();
			
			public var targetUrl:String;
          
            public function PAInfoWindow(ob:Object) {
 					
					this.buttonMode = true;
					this.useHandCursor = true;
					this.mouseChildren = false; 					
 					
					/* imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, displayImg);
				
					var fileRequest:URLRequest = new URLRequest(ob.imgURL);
					imageLoader.load(fileRequest); */
 					
 					var linGrad:String = GradientType.LINEAR;  
				   	var linMatrix:Matrix = new Matrix();
				    linMatrix.createGradientBox(250,40,90,0,0);
				    var linColors:Array = [0x4f92cf, 0x155a9a];
				    var linAlphas:Array = [1, 1];
				    var linRatios:Array = [1, 255];
			        var lin:Sprite = new Sprite();
			   		lin.graphics.beginGradientFill(linGrad, linColors, linAlphas, linRatios,linMatrix, SpreadMethod.PAD);
			   		lin.graphics.drawRoundRect(0,7,250,41,5);
			        addChild(lin);
 					
 					var background:Sprite = new Sprite();
 					background.graphics.beginGradientFill(linGrad, linColors, linAlphas, linRatios,linMatrix);
		            background.graphics.drawCircle(40,28,28);
		            background.graphics.endFill();
		            addChild(background);
		            
		            var count:Sprite = new Sprite();
		            count.graphics.beginFill(0xff3300,1);
		            count.graphics.drawCircle(40,28,7);
		            count.graphics.endFill();
		            count.x=20;
		            count.y=-20;

                    
					var imgcls: Bitmap = new imgcls();
			        imgcls.y = 22;
			        imgcls.x = 5;
			        addChild(imgcls);                    
                    
/* 					if(ob.sites >0){
						addChild(count);
	                    var tf:TextField = new TextField();
	                    var format:TextFormat = tf.getTextFormat();
	                    format.font = "Arial";
	                    format.size = 8;
	                    format.bold=true;
						format.align = TextFormatAlign.CENTER;	                    
	                    tf.defaultTextFormat = format;
	                    tf.text = ob.sites.toString();
	                    tf.textColor = 0xffffff;
	                    tf.mouseEnabled = false;
						tf.autoSize = "none";
	                    tf.width = 14;
	                    tf.height = 15;
	                    tf.x = 53;
	                    tf.y = 2;
	                    mouseChildren = false;
	                    addChild(tf);
	    			} */
                    
                    var percent:Sprite = new Sprite();
		            percent.graphics.beginFill(0xff6600,1);
		            percent.graphics.drawCircle(40,28,7);
		            percent.graphics.endFill();
		            percent.x=-20;
		            percent.y=20;

                    
/*                     if(ob.isNeeded){
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
	                    tf1.x = 36;
	                    tf1.y = 21;
	                    percent.addChild(tf1);
	                    addChild(percent);
	                } */
                    
                   
                    var mainNameSprite: Sprite = new Sprite();
		            var nameText: TextField = new TextField();
		            nameText.text =  "Jamonite";
		            var newFormat:TextFormat = new TextFormat(); 
		   			newFormat.size = 12; 
		   			newFormat.color = 0xFFFFFF;
		   			newFormat.bold = true;
		   			newFormat.letterSpacing = 0;
					newFormat.font = "Helvetica";
		    		nameText.setTextFormat(newFormat); 
		            nameText.wordWrap = true;
		            nameText.width = 150;
		            nameText.height = 30;
		            nameText.x = 0;
		            nameText.y = 0;
		            mainNameSprite.x = 73;
		            mainNameSprite.y = 16;
		            mainNameSprite.addChild(nameText);
		            mainNameSprite.width = 150;
		            mainNameSprite.height = 30;
		            mainNameSprite.mouseChildren=false;
		            mainNameSprite.buttonMode=true;
		            mainNameSprite.useHandCursor=true;
		            addChild(mainNameSprite);
		            mainNameSprite.addEventListener(MouseEvent.CLICK,clicked); 
		            
		            var exampleSprite2: Sprite = new Sprite();
		            var countryText2: TextField = new TextField();
		            countryText2.text =  "Local area PPE";
		            var newFormat2:TextFormat = new TextFormat(); 
		   			newFormat2.size = 10; 
		   			newFormat2.color = 0xFFFFFF;
		   			newFormat2.italic = true;
		   			newFormat2.letterSpacing = 0;
					newFormat2.font = "Helvetica";
		    		countryText2.setTextFormat(newFormat2); 
		            countryText2.width = 150;
		            countryText2.height = 15;
		            countryText2.x = 0;
		            countryText2.y = 0;
		            exampleSprite2.x = 73;
		            exampleSprite2.y = 29;
		            exampleSprite2.addChild(countryText2);
		            exampleSprite2.width = 150;
		            exampleSprite2.height = 15; 
		            exampleSprite2.mouseChildren=false;
		            exampleSprite2.buttonMode=true;
		            exampleSprite2.useHandCursor=true;
		            addChild(exampleSprite2);
		            this.addEventListener(MouseEvent.CLICK,clicked); 

            }
            
          	private function clicked(event:MouseEvent):void {
			    navigateToURL(new URLRequest(this.targetUrl),"_self");
			}
			
			private function displayImg(e:Event):void{
  			
	  			imageMask.graphics.beginFill(0x330000,1);
	  			imageMask.graphics.drawCircle(40,28,25);
	  			imageMask.graphics.endFill();
	  			
	  			addChild(imageMask);
	  			imageLoader.mask = imageMask;
	  			imageLoader.x = 15;
	  			imageLoader.y = 4; 
	  			addChildAt(imageLoader,2);
  			}
      }
}