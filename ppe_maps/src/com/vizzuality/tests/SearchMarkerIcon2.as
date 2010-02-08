package com.vizzuality.tests{
	
	import com.vizzuality.utils.StringUtils;
	
	import flare.vis.data.NodeSprite;
	
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
	
	public class SearchMarkerIcon2 extends NodeSprite {	

		private var imageLoader:Loader = new Loader();
		private var imageMask:Sprite = new Sprite();
		private var imageMask2:Sprite = new Sprite();
		private var paData:Object;
		private var count:Sprite;
		
		private var overSprite:Sprite;
		
		
		
		[Embed(source="/assets/arrow.gif")]
		public var imgcls:Class;
		
        public function SearchMarkerIcon2(m:Object) {

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
            background.graphics.drawCircle(15,8,29);
            background.graphics.endFill();
            addChild(background);
            
			var triangleShape:Shape = new Shape();
			triangleShape.graphics.beginFill(0xFFFFFF);
			triangleShape.graphics.moveTo(0,0);
			triangleShape.graphics.lineTo(22, 0);
			triangleShape.graphics.lineTo(11, 9);
			triangleShape.graphics.lineTo(0,0);		
			triangleShape.x = 5;
			triangleShape.y = 32;
			addChild(triangleShape);
            
            var image:Shape = new Shape();
            image.graphics.beginFill(0x000000,0.6);
            image.graphics.drawCircle(15,8,26);
            image.graphics.endFill();
            addChild(image);
            
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
            background.graphics.drawCircle(40,28,29);
            background.graphics.endFill();
            sp.addChild(background);
            
			var btriangleShape:Shape = new Shape();
			btriangleShape.graphics.beginFill(0x155a9a);
			btriangleShape.graphics.moveTo(0,0);
			btriangleShape.graphics.lineTo(22, 0);
			btriangleShape.graphics.lineTo(11, 9);
			btriangleShape.graphics.lineTo(0,0);		
			btriangleShape.x = 30;
			btriangleShape.y = 52;
			sp.addChild(btriangleShape);
            
            var mainNameSprite: Sprite = new Sprite();
            var nameText: TextField = new TextField();
            nameText.text = StringUtils.truncate(paData.area,25);
            var newFormat:TextFormat = new TextFormat(); 
   			newFormat.size = 12; 
   			newFormat.color = 0xFFFFFF;
   			newFormat.bold = true;
   			newFormat.letterSpacing = 0;
			newFormat.font = "Helvetica";
    		nameText.setTextFormat(newFormat); 
            nameText.wordWrap = true;
            nameText.width = 175;
            nameText.height = 30;
            nameText.x = 0;
            nameText.y = 0;
            mainNameSprite.x = 73;
            mainNameSprite.y = 16;
            mainNameSprite.addChild(nameText);
            mainNameSprite.width = 175;
            mainNameSprite.height = 30;
            mainNameSprite.mouseChildren=false;
            mainNameSprite.buttonMode=true;
            mainNameSprite.useHandCursor=true;
            sp.addChild(mainNameSprite);
            //mainNameSprite.addEventListener(MouseEvent.CLICK,clicked); 
            
            var exampleSprite2: Sprite = new Sprite();
            var countryText2: TextField = new TextField();
            if (paData.local_name == "" || paData.local_name == null) {
            	countryText2.text = "";
            } else {
	            countryText2.text =  StringUtils.truncate(paData.local_name,35);		            	
            }
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
            	navigateToURL(new URLRequest( "/sites/" + paData.paId),"_self");
            });

		    return sp;       	
        }
        
        private function onMouseOver(event:MouseEvent):void {
 			this.addChild(overSprite);	
 			this.removeChild(imageLoader);
 			imageLoader.x = 13;
  			imageLoader.y = 0;
 			overSprite.addChild(imageLoader);	
 			displaySites();    	
        }
        
        private function displaySites():void {
        	if (count.parent == null) {
        		if (paData.sites>0)
        			addChild(count);
        	} else {
        		removeChild(count);
        		if (paData.sites>0)
        			addChild(count);
        	}
        	
        }
  		
  		private function onMouseOut(event:MouseEvent ):void {
 			overSprite.removeChild(imageLoader);
 			this.addChild(imageLoader);	
 			this.removeChild(overSprite);		  			
 			imageLoader.x = -12;
  			imageLoader.y = -20;
  			displaySites();
  		}
  		
  		
  		private function displayImg(e:Event):void{

  			imageMask.graphics.beginFill(0x330000,1);
  			imageMask.graphics.drawCircle(15,8,26);
  			imageMask.graphics.endFill();

  			imageLoader.x = -12;
  			imageLoader.y = -20;
  			addChild(imageMask);
  			imageLoader.mask = imageMask; 
  			addChild(imageLoader);
  			
  			count = new Sprite();
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
  		}
      }
 }