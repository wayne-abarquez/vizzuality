package com.vizzuality
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class ImageContainer extends Sprite
	{
		
		private var _imgUrl:String;
		private var loader:Loader;
		private var imageMask: Sprite = new Sprite();
		
		public function ImageContainer(imgUrl:String = "",button:Boolean = false)
		{
			super();
			_imgUrl=imgUrl;
			var picturesSquare:Sprite = new Sprite();
			
			if (button) {
				picturesSquare.graphics.beginFill(0xCCCCCC);
				picturesSquare.graphics.lineStyle(1,0x999999);
				picturesSquare.graphics.drawRect(0,0,300, 252);		
				picturesSquare.graphics.endFill();		
				
				this.addChild(picturesSquare);	
				
				var mainNameSprite: Sprite = new Sprite();
	            var nameText: TextField = new TextField();
	            nameText.text = "add your image here ;)";
	            var newFormat:TextFormat = new TextFormat(); 
	   			newFormat.size = 28; 
	   			newFormat.color = 0x666666;
	   			newFormat.bold = true;
	   			newFormat.align = "center";
	   			newFormat.letterSpacing = 0;
				newFormat.font = "Helvetica";
	    		nameText.setTextFormat(newFormat); 
	            nameText.wordWrap = true;
	            nameText.width = 190;
	            nameText.height = 70;
	            nameText.x = 0;
	            nameText.y = 0;
	            mainNameSprite.x = 63;
	            mainNameSprite.y = 90;
	            mainNameSprite.addChild(nameText);
	            mainNameSprite.width = 190;
	            mainNameSprite.height = 70;
	            mainNameSprite.mouseChildren=false;
	            mainNameSprite.buttonMode=true;
	            mainNameSprite.useHandCursor=true;
	            addChild(mainNameSprite);
	            mainNameSprite.addEventListener(MouseEvent.CLICK,onClickUploadImage); 
	            		
			} else {
				picturesSquare.graphics.beginFill(0xFFFFFF);
				picturesSquare.graphics.lineStyle(1,0x999999);
				picturesSquare.graphics.drawRect(0,0,300, 252);		
				picturesSquare.graphics.endFill();		
				
				this.addChild(picturesSquare);
	
				
				loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onImageDownload);	
				loader.load(new URLRequest(_imgUrl));				
			}
			
		}
		
		private function onImageDownload(event:Event):void {
	   		imageMask.graphics.beginFill(0x330000,1);
	  		imageMask.graphics.drawRect(3,3,294,246);
	  		imageMask.graphics.endFill();
	  		
	  		this.addChild(imageMask);
	  		loader.mask = imageMask;

			this.addChild(loader);
			
			loader.x=-(loader.width/2) + 147;
			loader.y=-(loader.height/2) + 123;
		}
		
		private function onClickUploadImage(ev:MouseEvent):void {
			navigateToURL(new URLRequest("http://vizzuality.com"),"_self");
		}
		
	}
}