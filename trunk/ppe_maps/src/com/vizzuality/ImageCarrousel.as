package com.vizzuality
{
	import com.google.maps.Color;
	import com.greensock.TweenLite;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class ImageCarrousel extends Sprite
	{
		
		public var images:Array = [];
		private var fl:Boolean = true;
		private var position:Number = 0;	
		
		private var imagesContainerSprite:Sprite;	
		private var sp1:Sprite;	
		private var sp2:Sprite;	
		
		
		[Embed('assets/leftArrow.png')] 
		private var leftArrow:Class;				
		[Embed('assets/rightArrow.png')] 
		private var rightArrow:Class;	
				
		public function ImageCarrousel()
		{
			super();
			
			
		}
		
		public function init(imgArray:Array):void {	
			images=imgArray;

 			
 			//Create the outer gray square.
 			var picturesSquare:Sprite = new Sprite();
			picturesSquare.graphics.beginFill(0xEEEEEE);
			picturesSquare.graphics.drawRoundRect(0,0,630, 250,4,4);
			picturesSquare.graphics.endFill();		
			addChild(picturesSquare);
			
			
			//all images will be contained in a Sprite
			imagesContainerSprite = new Sprite();		
			imagesContainerSprite.x=9;
			imagesContainerSprite.y=9;

			//Loop through the array of images and create ImageContainer objects for them
			//this creates a bigger sprite than what actually we want to be shown.
			//we will mask it later.
 			var i:Number=0;
			for each(var pic:Object in images) {
				var img:ImageContainer = new ImageContainer(pic.url);
				imagesContainerSprite.addChild(img);
				img.x = i*310;
				i++;
			}
			//Add it
			addChild(imagesContainerSprite);

			
			//Create mask
 			var maskSprite:Sprite = new Sprite();
			maskSprite.graphics.beginFill(Color.RED);
			maskSprite.graphics.drawRect(0,0,612, 254);
			maskSprite.graphics.endFill();
			maskSprite.x=9;
			maskSprite.y=9;			
			addChild(maskSprite);	
			
			//Apply thr mask to the image container sprite
			imagesContainerSprite.mask= maskSprite;			
			
			
			//craete and add the left button
 			var leftArrowBitmap:Bitmap = new leftArrow() as Bitmap;
			leftArrowBitmap.width=38;
			leftArrowBitmap.height=34;
			sp1 = new Sprite();
			sp1.useHandCursor = true;
			sp1.mouseChildren = false;
			sp1.buttonMode = true;
			sp1.addChild(leftArrowBitmap);
			sp1.addEventListener(MouseEvent.CLICK,handleClickImage);
			sp1.x=picturesSquare.x - 10;	
			sp1.y=picturesSquare.y + 40;
			//addChild(sp1);
			
			//craete and add the right button
			var rightArrowBitmap:Bitmap = new rightArrow() as Bitmap;
			rightArrowBitmap.width=38;
			rightArrowBitmap.height=34;
			sp2 = new Sprite();
			sp2.useHandCursor = true;
			sp2.mouseChildren = false;
			sp2.buttonMode = true;
			sp2.addChild(rightArrowBitmap);
			sp2.addEventListener(MouseEvent.CLICK,handleClickImage);						
			sp2.x=(picturesSquare.x+picturesSquare.width)-28;									
			sp2.y=picturesSquare.y+178;
			if(imgArray.length>2)
				addChild(sp2);
							
				
			
		}
		
		private function handleClickImage(e:MouseEvent):void{
			TweenLite.killTweensOf(imagesContainerSprite,true);
			if(fl){
				if (e.currentTarget == sp1 && position > 0){
					TweenLite.to(imagesContainerSprite,0.7,{x:imagesContainerSprite.x + 310});
					position--;
				}else if(e.currentTarget == sp2 && position < 3){
					TweenLite.to(imagesContainerSprite,0.7,{x:imagesContainerSprite.x - 310});
					position++;				
				}
			}
			if(position==0) {
				removeChild(sp1);
			} else {
				if (sp1!=null && sp1.parent!=null) {
					removeChild(sp1);				
				}
			}
			
			if(position>0 && sp1.parent==null) {
				addChild(sp1);
			}
			
			if(position==images.length-2) {
				removeChild(sp2);
			} else{
				if(sp2.parent==null)
					addChild(sp2);
			}			
			
		}		
		
	}
}