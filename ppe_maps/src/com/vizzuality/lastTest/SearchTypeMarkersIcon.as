package com.vizzuality.lastTest{
	
	
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
			
			var background:Shape = new Shape();
			var triangleShape:Shape = new Shape();
			
			var shadow: Shape = new Shape();
			var triangleShadow: Shape = new Shape();
			
			
			switch (type) {
				case 1: shadow.graphics.beginFill(0x000000,0.06);
			            shadow.graphics.drawRoundRect(-3,-3,34,34,3,3);
			            shadow.graphics.endFill();
			            addChild(shadow);
			            
						triangleShadow.graphics.beginFill(0x000000,0.06);
						triangleShadow.graphics.moveTo(0,0);
						triangleShadow.graphics.lineTo(22, 0);
						triangleShadow.graphics.lineTo(11, 9);
						triangleShadow.graphics.lineTo(0,0);		
						triangleShadow.x = 3;
						triangleShadow.y = 27;
						addChild(triangleShadow);
				
						background.graphics.beginFill(0xFFFFFF,1);
			            background.graphics.drawRect(0,0,28,28);
			            background.graphics.endFill();
			            addChild(background);

						triangleShape.graphics.beginFill(0xFFFFFF);
						triangleShape.graphics.moveTo(0,0);
						triangleShape.graphics.lineTo(22, 0);
						triangleShape.graphics.lineTo(11, 9);
						triangleShape.graphics.lineTo(0,0);		
						triangleShape.x = 3;
						triangleShape.y = 23;
						addChild(triangleShape);
						break;
				
				case 2: shadow.graphics.beginFill(0x000000,0.06);
			            shadow.graphics.drawRoundRect(-3,-3,42,42,3,3);
			            shadow.graphics.endFill();
			            addChild(shadow);
			            
						triangleShadow.graphics.beginFill(0x000000,0.06);
						triangleShadow.graphics.moveTo(0,0);
						triangleShadow.graphics.lineTo(22, 0);
						triangleShadow.graphics.lineTo(11, 9);
						triangleShadow.graphics.lineTo(0,0);		
						triangleShadow.x = 8;
						triangleShadow.y = 37;
						addChild(triangleShadow); 
				
						background.graphics.beginFill(0xFFFFFF,1);
			            background.graphics.drawRect(0,0,37,37);
			            background.graphics.endFill();
			            addChild(background);
			            
						triangleShape.graphics.beginFill(0xFFFFFF);
						triangleShape.graphics.moveTo(0,0);
						triangleShape.graphics.lineTo(22, 0);
						triangleShape.graphics.lineTo(11, 9);
						triangleShape.graphics.lineTo(0,0);		
						triangleShape.x = 8;
						triangleShape.y = 33;
						addChild(triangleShape);
			            
						break;
						
				case 3: shadow.graphics.beginFill(0x000000,0.06);
			            shadow.graphics.drawRoundRect(-3,-3,60,60,3,3);
			            shadow.graphics.endFill();
			            addChild(shadow);
			            
						triangleShadow.graphics.beginFill(0x000000,0.06);
						triangleShadow.graphics.moveTo(0,0);
						triangleShadow.graphics.lineTo(22, 0);
						triangleShadow.graphics.lineTo(11, 9);
						triangleShadow.graphics.lineTo(0,0);		
						triangleShadow.x = 16;
						triangleShadow.y = 56;
						addChild(triangleShadow);
				
						background.graphics.beginFill(0xFFFFFF,1);
			            background.graphics.drawRect(0,0,54,54);
			            background.graphics.endFill();
			            addChild(background);

						triangleShape.graphics.beginFill(0xFFFFFF);
						triangleShape.graphics.moveTo(0,0);
						triangleShape.graphics.lineTo(22, 0);
						triangleShape.graphics.lineTo(11, 9);
						triangleShape.graphics.lineTo(0,0);		
						triangleShape.x = 16;
						triangleShape.y = 52;
						addChild(triangleShape);
						break;
			}
			
			/* this.addEventListener(MouseEvent.CLICK,function(event:Event):void {
            	navigateToURL(new URLRequest( "http://ppe.tinypla.net/sites/" + paData.paId),"_self");
            }); */

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
			border_blue.graphics.drawRect(0,0,50,50);
			border_blue.graphics.endFill();
			border_blue.x = 20;
			border_blue.y = 19;
			sp.addChild(border_blue);
            
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
	            countryText2.text = StringUtils.truncate(paData.local_name,35);	            	
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
            
            
            imageMaskOver = new Sprite();
            imageMaskOver.x = 20;
            imageMaskOver.y = 20;
 			imageMaskOver.graphics.beginFill(0x330000,1);
 			imageMaskOver.graphics.drawRect(2,2,49,49);
 			imageMaskOver.graphics.endFill();
 			sp.addChild(imageMaskOver);
            
            this.addEventListener(MouseEvent.CLICK,function(event:Event):void {
            	navigateToURL(new URLRequest( "http://ppe.tinypla.net/sites/" + paData.paId),"_self");
            });

		    return sp;       	
        }
        
        private function onMouseOver(event:MouseEvent):void {
 			this.addChild(overSprite);	
 			this.removeChild(imageLoader);
  			imageLoader.width = 49; 
  			imageLoader.height = 49;
  			

 			switch (type) {
            	case 1: overSprite.x = -31;
            			overSprite.y = -45;
            			imageMaskOver.x = 20;
            			imageMaskOver.y = 18;
            			imageLoader.x = 20;
  						imageLoader.y = 19;
            			break;
            			
            	case 2: imageLoader.x = 43;
  						imageLoader.y = 43;
            			break;
            	case 3: overSprite.x=-18;
            			overSprite.y=-17;
            			imageLoader.x = 21;
  						imageLoader.y = 18;
            			break;
            	default: break;
			} 
 			
 			imageLoader.mask = imageMaskOver; 
 			overSprite.addChild(imageLoader);
 			
        }
        

  		
  		private function onMouseOut(event:MouseEvent ):void {
 			overSprite.removeChild(imageLoader);
 			imageLoader.mask = imageMask;
 			this.addChild(imageLoader);	
 			this.removeChild(overSprite);		  			
 			
  			
  			switch (type) {
            	case 1: imageLoader.width = 24; imageLoader.height = 24; 
            			imageLoader.x = 2; imageLoader.y = 2;
            			break;
            	case 2: imageLoader.width = 33; imageLoader.height = 33;
            			imageLoader.x = 2; imageLoader.y = 2;
            			break;
            	case 3: imageLoader.width = 51; imageLoader.height = 51;
            			imageLoader.x = 2; imageLoader.y = 2;
            			break;
            	default: break;
			} 
  		}




  		private function displayImg(e:Event):void{

 			
   			imageMask.graphics.beginFill(0x330000,1);
			switch (type) {
            	case 1: imageMask.graphics.drawRect(2,2,24,24); break;
            	case 2: imageMask.graphics.drawRect(2,2,33,33); break;
            	case 3: imageMask.graphics.drawRect(2,2,50,50); break;
            	default: break;
			}  			
  			imageMask.graphics.endFill();

			switch (type) {
            	case 1: imageLoader.width = 24; imageLoader.height = 24; break;
            	case 2: imageLoader.width = 33; imageLoader.height = 33; break;
            	case 3: imageLoader.width = 51; imageLoader.height = 51; break;
            	default: break;
			}
			
  			imageLoader.x = 2;
  			imageLoader.y = 2;
  			addChild(imageMask);
  			imageLoader.mask = imageMask; 
  			addChild(imageLoader);
  			
  			

  		}
      }
 }