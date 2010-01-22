package com.vizzuality.lastTest{
	
	
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	public class SearchTypeMarkersIcon extends Sprite {	

		private var imageLoader:Loader = new Loader();
		private var imageMask:Sprite = new Sprite();
		private var imageMask2:Sprite = new Sprite();
		private var paData:Object;
		private var type: Number;
		
/* 		private var count:Sprite; */
		
/* 		private var overSprite:Sprite; */
		
		
		
/*  		[Embed(source="/assets/arrow.gif")]
		public var imgcls:Class; */
		
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
			
			this.addEventListener(MouseEvent.CLICK,function(event:Event):void {
            	navigateToURL(new URLRequest( "http://ppe.tinypla.net/sites/" + paData.paId),"_self");
            });

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