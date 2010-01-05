package com.vizzuality
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;

	public class ImageContainer extends Sprite
	{
		
		private var _imgUrl:String;
		private var loader:Loader;
		private var imageMask: Sprite = new Sprite();
		
		public function ImageContainer(imgUrl:String)
		{
			super();
			_imgUrl=imgUrl;
		
			var picturesSquare:Sprite = new Sprite();
			picturesSquare.graphics.beginFill(0xFFFFFF);
			picturesSquare.graphics.lineStyle(1,0x999999);
			picturesSquare.graphics.drawRect(0,0,300, 252);		
			picturesSquare.graphics.endFill();		
			
			this.addChild(picturesSquare);

			
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onImageDownload);	
			loader.load(new URLRequest(_imgUrl));
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
		
	}
}