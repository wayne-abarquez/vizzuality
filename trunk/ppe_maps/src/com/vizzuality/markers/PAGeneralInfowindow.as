package com.vizzuality.markers
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class PAGeneralInfowindow extends Sprite{
		
			private var imageLoader:Loader = new Loader();
			private var imageMask:Sprite = new Sprite();
			
			public var targetUrl:String;
			
			[Embed('assets/bkg.png')] 
	  		private var bkg:Class;
          
            public function PAGeneralInfowindow(ob:Object) {
 					
				this.buttonMode = true;
				this.useHandCursor = true;
				this.mouseChildren = false; 					
 				
				imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, displayImg);
			
				var fileRequest:URLRequest = new URLRequest("http://localhost:3000/images/thumbnails/thumb04.jpg");
				imageLoader.load(fileRequest);
 				
 				addChild(new bkg());

		        /* var lin:Sprite = new Sprite();
		        lin.graphics.lineStyle(1,0xcccccc);
		   		lin.graphics.beginFill(0xFFFFFF,1);
		   		lin.graphics.drawRoundRect(0,0,140,72,5);
		        addChild(lin);
		        
		        var triangleHeight:uint = 20;
				var triangleShape:Shape = new Shape();
				triangleShape.graphics.lineStyle(1,0xcccccc);
				triangleShape.graphics.beginFill(0xFFFFFF);
				triangleShape.graphics.moveTo(triangleHeight/2, 5);
				triangleShape.graphics.lineTo(triangleHeight, triangleHeight+5);
				triangleShape.graphics.lineTo(0,triangleHeight+5);
				triangleShape.graphics.lineTo(triangleHeight/2, 5);
				triangleShape.x = 55;
				triangleShape.y = 63;
				addChild(triangleShape); */
 				
 				var background:Sprite = new Sprite();
 				background.graphics.lineStyle(1,0xdde3e8);
	            background.graphics.drawRect(5,5,58,58);
	            background.graphics.endFill();
	            addChild(background);
	            
                var mainNameSprite: Sprite = new Sprite();
	            var nameText: TextField = new TextField();
	            nameText.text =  ob.user;
	            var newFormat:TextFormat = new TextFormat(); 
	   			newFormat.size = 11; 
	   			newFormat.color = 0x336699;
	   			newFormat.bold = true;
	   			newFormat.letterSpacing = 0;
				newFormat.font = "Helvetica";
	    		nameText.setTextFormat(newFormat); 
	            nameText.wordWrap = true;
	            nameText.width = 70;
	            nameText.height = 15;
	            nameText.x = 0;
	            nameText.y = 0;
	            mainNameSprite.x = 67;
	            mainNameSprite.y = 11;
	            mainNameSprite.addChild(nameText);
	            mainNameSprite.width = 70;
	            mainNameSprite.height = 15;
	            mainNameSprite.mouseChildren=false;
	            mainNameSprite.buttonMode=true;
	            mainNameSprite.useHandCursor=true;
	            addChild(mainNameSprite);

	            
	            var exampleSprite2: Sprite = new Sprite();
	            var countryText2: TextField = new TextField();
	            countryText2.text =  ob.ago;
	            var newFormat2:TextFormat = new TextFormat(); 
	   			newFormat2.size = 11; 
	   			newFormat2.color = 0x999999;
	   			newFormat2.letterSpacing = 0;
				newFormat2.font = "Helvetica";
	    		countryText2.setTextFormat(newFormat2); 
	            countryText2.width = 70;
	            countryText2.height = 15;
	            countryText2.x = 0;
	            countryText2.y = 0;
	            exampleSprite2.x = 67;
	            exampleSprite2.y = 24;
	            exampleSprite2.addChild(countryText2);
	            exampleSprite2.width = 70;
	            exampleSprite2.height = 15; 
	            exampleSprite2.mouseChildren=false;
	            exampleSprite2.buttonMode=true;
	            exampleSprite2.useHandCursor=true;
	            addChild(exampleSprite2);
	            
	            if (ob.action!=null) {
		            var mainNameSprite3: Sprite = new Sprite();
		            var nameText3: TextField = new TextField();
		            var newFormat3:TextFormat = new TextFormat(); 
		   			newFormat3.size = 11; 
		   			newFormat3.color = 0x666666;
		   			newFormat3.bold = true;
		   			newFormat3.letterSpacing = 0;
					newFormat3.font = "Helvetica";
		            nameText3.text =  ob.action;
		    		nameText3.setTextFormat(newFormat3); 
		            nameText3.wordWrap = true;
		            nameText3.width = 70;
		            nameText3.height = 15;
		            nameText3.x = 0;
		            nameText3.y = 0;
		            mainNameSprite3.x = 67;
		            mainNameSprite3.y = 40;
		            mainNameSprite3.addChild(nameText3);
		            mainNameSprite3.width = 70;
		            mainNameSprite3.height = 15;
		            mainNameSprite3.mouseChildren=false;
		            mainNameSprite3.buttonMode=true;
		            mainNameSprite3.useHandCursor=true;
		            addChild(mainNameSprite3);	            	
	            }
	            
	            
	            
	            var mainNameSprite2: Sprite = new Sprite();
	            var nameText2: TextField = new TextField();
	            nameText2.text =  "view";
	    		nameText2.setTextFormat(newFormat); 
	            nameText2.wordWrap = true;
	            nameText2.width = 70;
	            nameText2.height = 15;
	            nameText2.x = 0;
	            nameText2.y = 0;
	            mainNameSprite2.x = 67;
	            mainNameSprite2.y = 50;
	            mainNameSprite2.addChild(nameText2);
	            mainNameSprite2.width = 70;
	            mainNameSprite2.height = 15;
	            mainNameSprite2.mouseChildren=false;
	            mainNameSprite2.buttonMode=true;
	            mainNameSprite2.useHandCursor=true;
	            addChild(mainNameSprite2);
	            
            }
            

			
			private function displayImg(e:Event):void{
  			
	  			imageMask.graphics.beginFill(0x330000,1);
	  			imageMask.graphics.drawRect(9,10,58,58);
	  			imageMask.graphics.endFill();
	  			
	  			addChild(imageMask);
	  			imageLoader.mask = imageMask;
	  			imageLoader.x = 4;
	  			imageLoader.y = 4; 
	  			addChildAt(imageLoader,2);
  			}
      }
}