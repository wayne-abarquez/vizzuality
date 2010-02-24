package com.vizzuality.markers{
	
	
	import com.google.maps.Color;
	import com.vizzuality.utils.StringUtils;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class SearchTypeMarkersIcon extends Sprite {	

		private var imageLoader:Loader = new Loader();
		private var imageMask:Sprite = new Sprite();
		private var imageMaskOver:Sprite = new Sprite();
		private var paData:Object;
		private var type: Number;
		private var overSprite:Sprite;
/* 		private var count:Sprite; */
		
/* 		private var overSprite:Sprite; */
		
		
		
  		[Embed(source="/assets/backgroundMarker.png")]
		public var overImage:Class;
		
		[Embed(source="/assets/bigMarker.png")]
		public var big:Class;
		
		[Embed(source="/assets/smallMarker.png")]
		public var small:Class;
		
		[Embed(source="/assets/mediumMarker.png")]
		public var medium:Class;
		
        public function SearchTypeMarkersIcon(m:Object, _type:Number) {

			super();    
			this.buttonMode = true;
			this.useHandCursor = true;
			this.mouseChildren = false;
			
			paData= m;
			type= _type;

			imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, displayImg);
			
			var fileRequest:URLRequest = new URLRequest(m.imgURL);
			imageLoader.load(fileRequest);
			
			var background:Bitmap;
			var triangleShape:Shape = new Shape();
			
			var shadow: Shape = new Shape();
			var triangleShadow: Shape = new Shape();
			
			
			switch (type) {
				case 1: background = new small();
			            addChild(background);
						break;
				
				case 2: background = new medium();
			            addChild(background);
						break;
						
				case 3: background = new big();
			            addChild(background);
						break;
			}
			
			 this.addEventListener(MouseEvent.CLICK,function(event:Event):void {
            	navigateToURL(new URLRequest( "/sites/" + paData.paId),"_self");
            });

            overSprite=createOverSprite();
            overSprite.x=-18; /* overSprite.x=-16; */
            overSprite.y=-17;
         	
         	this.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
         	this.addEventListener(MouseEvent.MOUSE_OUT,onMouseOut); 


        }


        private function createOverSprite():Sprite {
        	var sp:Sprite=new Sprite();
        	
 			var background:Bitmap = new overImage();
            sp.addChild(background);
            
        	var border_blue: Sprite = new Sprite();
        	border_blue.graphics.beginFill(0x015783,1);
			border_blue.graphics.drawRect(0,0,48,48);
			border_blue.graphics.endFill();
			border_blue.x = 20;
			border_blue.y = 19;
			
            
            var mainNameSprite: Sprite = new Sprite();
            var nameText: TextField = new TextField();
            nameText.text = StringUtils.truncate(paData.area,30);
            var newFormat:TextFormat = new TextFormat(); 
   			newFormat.size = 12; 
   			newFormat.color = 0xFFFFFF;
   			newFormat.bold = true;
   			newFormat.letterSpacing = -0.5;
			newFormat.font = "Arial";
    		nameText.setTextFormat(newFormat); 
            nameText.wordWrap = true;
            nameText.width = 115;
            nameText.height = 35;
            nameText.x = 0;
            nameText.y = 0;
            mainNameSprite.x = 72;
            mainNameSprite.y = 16;
            mainNameSprite.addChild(nameText);
            mainNameSprite.width = 115;
            mainNameSprite.height = 35;
            mainNameSprite.mouseChildren=false;
            mainNameSprite.buttonMode=true;
            mainNameSprite.useHandCursor=true;
            sp.addChild(mainNameSprite);

            
            var exampleSprite2: Sprite = new Sprite();
            var countryText2: TextField = new TextField();
            if (paData.local_name == "" || paData.local_name == null) {
            	countryText2.text = "";
            } else {
	            countryText2.text = StringUtils.truncate(paData.local_name,20);	            	
            }
            var newFormat2:TextFormat = new TextFormat(); 
   			newFormat2.size = 11; 
   			newFormat2.color = 0xFFFFFF;
   			newFormat2.italic = true;
   			newFormat2.bold = false;
   			newFormat2.letterSpacing = 0;
			newFormat2.font = "Arial";
    		countryText2.setTextFormat(newFormat2); 
            countryText2.width = 115;
            countryText2.height = 15;
            countryText2.x = 0;
            countryText2.y = 0;
            exampleSprite2.x = 72;
            if (nameText.length<20) {
            	exampleSprite2.y = 29;
            } else {
            	exampleSprite2.y = 43;
            }
            exampleSprite2.addChild(countryText2);
            exampleSprite2.width = 115;
            exampleSprite2.height = 15; 
            exampleSprite2.mouseChildren=false;
            exampleSprite2.buttonMode=true;
            exampleSprite2.useHandCursor=true;
            sp.addChild(exampleSprite2);
            
            
            var exampleSprite3: Sprite = new Sprite();
            var countryText3: TextField = new TextField();
            /* if (paData.sites==0 || paData.sites == null) { */
            	countryText3.text = paData.sites + " Points of interest";            	
           /*  } */
            var newFormat3:TextFormat = new TextFormat(); 
   			newFormat3.size = 10; 
   			newFormat3.color = 0x333333;
   			newFormat3.italic = true;
   			newFormat3.bold = false;
   			newFormat3.letterSpacing = 0;
			newFormat3.font = "Arial";
    		countryText3.setTextFormat(newFormat3); 
            countryText3.width = 115;
            countryText3.height = 15;
            countryText3.x = 0;
            countryText3.y = 0;
            exampleSprite3.x = 72;
            exampleSprite3.y = 55;
            exampleSprite3.addChild(countryText3);
            exampleSprite3.width = 115;
            exampleSprite3.height = 15; 
            exampleSprite3.mouseChildren=false;
            exampleSprite3.buttonMode=true;
            exampleSprite3.useHandCursor=true;
            sp.addChild(exampleSprite3);
            
            
            imageMaskOver = new Sprite();
            imageMaskOver.x = 1;
            imageMaskOver.y = 1;
 			imageMaskOver.graphics.beginFill(0x330000,1);
 			imageMaskOver.graphics.drawRect(0,0,46,46);
 			imageMaskOver.graphics.endFill();
 			border_blue.addChild(imageMaskOver);
 			sp.addChild(border_blue);
            
            this.addEventListener(MouseEvent.CLICK,function(event:Event):void {
            	navigateToURL(new URLRequest( "/sites/" + paData.paId),"_self");
            });

		    return sp;       	
        }
        
        private function onMouseOver(event:MouseEvent):void {
 			this.addChild(overSprite);	
 			this.removeChild(imageLoader);
  			imageLoader.width = 50; 
  			imageLoader.height = 50;
  			

 			switch (type) {
            	case 1: //DONE
            			overSprite.x = -24;
            			overSprite.y = -39;
            			imageLoader.x = 20;
  						imageLoader.y = 19;
            			break;
            			
            	case 2: //TODO!!!
            			imageLoader.x = 43;
  						imageLoader.y = 43;
            			break;
            			
            	case 3: //DONE
            			overSprite.x=-11;
            			overSprite.y=-10;
            			imageLoader.x = 19;
  						imageLoader.y = 18;
            			break;
            	default: break;
			} 
 			
 			imageLoader.mask = imageMaskOver;
 			 overSprite.addChild(imageLoader); 
 			
        }
        

  		
  		private function onMouseOut(event:MouseEvent ):void {
 			overSprite.removeChild(imageLoader);
 			this.removeChild(overSprite);		  			
 			imageLoader.mask = imageMask;
 			this.addChild(imageLoader);	
  			
  			switch (type) {
            	case 1: //DONE
            			imageLoader.x = 7; imageLoader.y = 8; 
            			imageLoader.width = 26; imageLoader.height = 26; 
            			break;
            	case 2: //TODO!!!
            			imageLoader.width = 33; imageLoader.height = 33;
            			break;
            	case 3: //DONE
            			imageLoader.x = 8; imageLoader.y = 8;
            			imageLoader.width = 50; imageLoader.height = 50;
            			break;
            	default: break;
			} 
  		}




  		private function displayImg(e:Event):void{

 			
   			imageMask.graphics.beginFill(0x330000,1);
			switch (type) {
            	case 1: imageMask.graphics.drawRect(2,2,24,24); break;
            	case 2: imageMask.graphics.drawRect(2,2,32,32); break;
            	case 3: imageMask.graphics.drawRect(2,2,49,49); break;
            	default: break;
			}  			
  			imageMask.graphics.endFill();

			switch (type) {
            	case 1: imageLoader.width = 26; imageLoader.height = 26; 
            			imageLoader.x = 7;
			  			imageLoader.y = 8;
			  			imageMask.x = 7;
			  			imageMask.y = 8;
            			break;
            	case 2: imageLoader.width = 34; imageLoader.height = 34; 
            			imageLoader.x = 8;
			  			imageLoader.y = 8;
			  			imageMask.x = 8;
			  			imageMask.y = 8;
            			break;
            	case 3: imageLoader.width = 50; imageLoader.height = 50; 
            			imageLoader.x = 8;
			  			imageLoader.y = 8;
			  			imageMask.x = 8;
			  			imageMask.y = 8;
            			break;
            	default: break;
			}
			
/*   			imageLoader.x = 8;
  			imageLoader.y = 8;
  			imageMask.x = 8;
  			imageMask.y = 8; */
  			addChild(imageMask);
  			imageLoader.mask = imageMask; 
  			addChild(imageLoader); 
  			
  			

  		}
      }
 }