package com.vizzuality.markers{
	
	import flare.vis.data.NodeSprite;
	
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
	
	public class SearchMarkerIcon extends NodeSprite {	

		private var imageLoader:Loader = new Loader();
		private var imageMask:Sprite = new Sprite();
		private var imageMask2:Sprite = new Sprite();
		private var paData:Object;
		
		private var overSprite:Sprite;
		
		
		
		[Embed(source="/assets/arrow.gif")]
		public var imgcls:Class;
		
        public function SearchMarkerIcon(m:Object) {

				super();    
				this.buttonMode = true;
				this.useHandCursor = true;
				this.mouseChildren = false;
				
				paData= m;

				imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, displayImg);
				
				var fileRequest:URLRequest = new URLRequest(m.imgURL);
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
	            
                if(paData.sites >0){
                	var tf:TextField = new TextField();
                    var format:TextFormat = tf.getTextFormat();
                    format.font = "Arial";
                    format.size = 8;
                    format.bold=true;
					format.align = TextFormatAlign.CENTER;               
                    tf.defaultTextFormat = format;
                    tf.text = paData.sites.toString();
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
                
                overSprite=createOverSprite();
                overSprite.x=-25;
                overSprite.y=-20;
             	
             	this.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
             	this.addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
         	
             	
                
        }
        
        private function createOverSprite():Sprite {
        	var sp:Sprite=new Sprite();
        	
 					var linGrad:String = GradientType.LINEAR;  
				   	var linMatrix:Matrix = new Matrix();
				    linMatrix.createGradientBox(250,40,90,0,0);
				    var linColors:Array = [0x4f92cf, 0x155a9a];
				    var linAlphas:Array = [1, 1];
				    var linRatios:Array = [1, 255];
			        var lin:Sprite = new Sprite();
			   		lin.graphics.beginGradientFill(linGrad, linColors, linAlphas, linRatios,linMatrix, SpreadMethod.PAD);
			   		lin.graphics.drawRoundRect(0,7,250,41,5);
			        sp.addChild(lin);
 					
 					var background:Sprite = new Sprite();
 					background.graphics.beginGradientFill(linGrad, linColors, linAlphas, linRatios,linMatrix);
		            background.graphics.drawCircle(40,28,28);
		            background.graphics.endFill();
		            sp.addChild(background);
		            
		            var count:Sprite = new Sprite();
		            count.graphics.beginFill(0xff3300,1);
		            count.graphics.drawCircle(40,28,7);
		            count.graphics.endFill();
		            count.x=20;
		            count.y=-20;

                    
					var imgcls: Bitmap = new imgcls();
			        imgcls.y = 22;
			        imgcls.x = 5;
			        sp.addChild(imgcls);                    
                    
 					if(paData.sites >0){
						sp.addChild(count);
	                    var tf:TextField = new TextField();
	                    var format:TextFormat = tf.getTextFormat();
	                    format.font = "Arial";
	                    format.size = 8;
	                    format.bold=true;
						format.align = TextFormatAlign.CENTER;	                    
	                    tf.defaultTextFormat = format;
	                    tf.text = paData.sites.toString();
	                    tf.textColor = 0xffffff;
	                    tf.mouseEnabled = false;
						tf.autoSize = "none";
	                    tf.width = 14;
	                    tf.height = 15;
	                    tf.x = 53;
	                    tf.y = 2;
	                    mouseChildren = false;
	                    sp.addChild(tf);
	    			}
                    

                    var mainNameSprite: Sprite = new Sprite();
		            var nameText: TextField = new TextField();
		            nameText.text =  paData.area;
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
		            sp.addChild(mainNameSprite);
		            //mainNameSprite.addEventListener(MouseEvent.CLICK,clicked); 
		            
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
		            sp.addChild(exampleSprite2);
		            this.addEventListener(MouseEvent.CLICK,function(event:Event):void {
		            	navigateToURL(new URLRequest( "http://ppe.tinypla.net/sites/" + paData.paId),"_self");
		            });    
		        
		            
		     return sp;       	
        }
        
        private function onMouseOver(event:MouseEvent):void {
 			this.addChild(overSprite);	
 			this.removeChild(imageLoader);
 			imageLoader.x = 5;
  			imageLoader.y = 0;
 			overSprite.addChild(imageLoader);	
      	
        }
  		
  		private function onMouseOut(event:MouseEvent ):void {
 			overSprite.removeChild(imageLoader);
 			this.addChild(imageLoader);	
 			this.removeChild(overSprite);		  			
 			imageLoader.x = -20;
  			imageLoader.y = -20;
  		}
  		
  		
  		private function displayImg(e:Event):void{
/*   			var loader:Loader = Loader(e.target.loader);
            var original:Bitmap = Bitmap(loader.content);
            var duplicate:Bitmap = new Bitmap(original.bitmapData.clone()); */
  			
  			
  			
  			imageMask.graphics.beginFill(0x330000,1);
  			imageMask.graphics.drawCircle(15,8,25);
  			imageMask.graphics.endFill();
  			
/*   			imageMask2.graphics.beginFill(0x330000,1);
  			imageMask2.graphics.drawCircle(15,8,25);
  			imageMask2.graphics.endFill();
  			imageMask2.x=25;
  			imageMask2.y=20; */
  			
  			imageLoader.x = -20;
  			imageLoader.y = -20;
/*   			duplicate.x = 5;
  			duplicate.y = 0; */
  			addChild(imageMask);
  			//overSprite.addChild(imageMask2);
  			imageLoader.mask = imageMask; 
  			//duplicate.mask = imageMask2;
  			addChild(imageLoader);
  			//overSprite.addChild(duplicate);
  			
  		}
  		
  		
      }
      
 }