package com.vizzuality
{
	import com.google.maps.Color;
	import com.greensock.TweenLite;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
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
			picturesSquare.graphics.drawRoundRect(0,0,632, 250,4,4);
			picturesSquare.graphics.endFill();		
			addChild(picturesSquare);
			
			
			//all images will be contained in a Sprite
			imagesContainerSprite = new Sprite();		
			imagesContainerSprite.x=11;
			imagesContainerSprite.y=11;

			//Loop through the array of images and create ImageContainer objects for them
			//this creates a bigger sprite than what actually we want to be shown.
			//we will mask it later.
 			var i:Number=0;
			for each(var pic:Object in images) {
				var img:ImageContainer = new ImageContainer(pic.url);
				img.width = 300;
				img.height = 250;
				imagesContainerSprite.addChild(img);
				img.x = i*310;
				i++;
			}
			
			if (images.length==1) {
				var img2:ImageContainer = new ImageContainer("",true);
				img2.width = 300;
				img2.height = 250;
				imagesContainerSprite.addChild(img2);
				img2.x = i*310;
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
				}else if(e.currentTarget == sp2 && position < images.length-2){
					TweenLite.to(imagesContainerSprite,0.7,{x:imagesContainerSprite.x - 310});
					position++;				
				}
			}
			
			
			if(position==0) {
				sp1.alpha = 1;
				sp1.removeEventListener(MouseEvent.CLICK,handleClickImage);
				TweenLite.to(sp1,0.7,{alpha:0,onComplete: onFinishedTween, onCompleteParams:[sp1]});
			} else {
				if (sp1==null && sp1.parent==null) {
					sp1.alpha = 1;
					sp1.removeEventListener(MouseEvent.CLICK,handleClickImage);
					TweenLite.to(sp1,0.7,{alpha:0,onComplete: onFinishedTween, onCompleteParams:[sp1]});			
				}
			}
			
			if(position>0 && sp1.parent==null) {
				sp1.alpha=0;
				sp1.addEventListener(MouseEvent.CLICK,handleClickImage);
				addChild(sp1);
				TweenLite.to(sp1,0.7,{alpha:1});
			}
			

			if(position==images.length-2) {
				sp2.alpha=1;
				TweenLite.to(sp2,0.7,{alpha:0,onComplete: onFinishedTween, onCompleteParams:[sp2]});
				sp2.removeEventListener(MouseEvent.CLICK,handleClickImage);
			} else{
				if(sp2.parent==null) {
					sp2.alpha=0;
					sp2.addEventListener(MouseEvent.CLICK,handleClickImage);
					addChild(sp2);
					TweenLite.to(sp2,0.7,{alpha:1});
				}
			} 
			
		}
		
		private function onFinishedTween(obj:Sprite):void {
			removeChild(obj);
		}		
		
	}
}