package com.vizzuality.view
{
	import com.vizzuality.VizzualityShape;
	import com.vizzuality.vizzButton;
	
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.geom.Matrix;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	public class SearchBox extends Sprite
	{
		private var parentWidth: int;
		
		
		public function SearchBox(parentWidth: int){
			parentWidth = parentWidth;
			createSearchBox();
		}
		
		private function createSearchBox():void {
			var searchContainer:Sprite = new Sprite();
			var fillType:String = GradientType.LINEAR;
			var colors:Array = [0xfd9700, 0xe68000];
			var alphas:Array = [1, 1];
			var ratios:Array = [0, 255];
			var matrix:Matrix = new Matrix();
			var gradWidth:Number = 360;
			var gradHeight:Number = 240;
			var gradRotation:Number =  Math.PI; // rotation expressed in radians
			var gradOffsetX:Number = 0;
			var gradOffsetY:Number = 0;

			matrix.createGradientBox(gradWidth, gradHeight, gradRotation, gradOffsetX, gradOffsetY);
			var spreadMethod:String = SpreadMethod.PAD;
			searchContainer.graphics.beginGradientFill(fillType, colors, alphas, ratios, matrix, spreadMethod);
			searchContainer.graphics.drawRoundRect(0, 0, 950, 68, 5);
			searchContainer.graphics.endFill();

			this.addChild(searchContainer);
			
			var tf:TextFormat = new TextFormat();
			tf.size = 14;
			tf.color = 0x666666;
			tf.italic = true;
			tf.font = "Arial";
			tf.leftMargin = 5;
			tf.rightMargin = 5;
			var ti:TextField = new TextField();
			ti.type = TextFieldType.INPUT;
			ti.backgroundColor = 0xffffff;
			ti.background = true;
			ti.border = true;
			ti.borderColor = 0xc46d00;
			ti.x = 10;
			ti.y = 12;
			ti.width = 806;
			ti.height = 30;
			ti.defaultTextFormat = tf;
			this.addChild(ti);
			
			var zoomPlus:vizzButton = new vizzButton(this,816,12,124,30,"Search",18,32,5);
			zoomPlus.addEventListener(MouseEvent.CLICK,function(e:Event):void {ExternalInterface.call("alert",ti.text)});
			var separateBar:Sprite = new Sprite();
			separateBar.graphics.beginFill(0xcccccc,1);
	   		separateBar.graphics.drawRect(815,13,1,29);
	   		separateBar.graphics.endFill();
	   		this.addChild(separateBar);
			      
            var exampleSprite: VizzualityShape = new VizzualityShape("http://localhost:3000/");
            var countryText: TextField = new TextField();
            countryText.text =  "E.x: Yosemite Natural park";
            var newFormat:TextFormat = new TextFormat(); 
   			newFormat.size = 10; 
   			newFormat.color = 0xFFFFFF;
   			newFormat.bold = true;
   			newFormat.letterSpacing = 0;
			newFormat.font = "Arial";
    		countryText.setTextFormat(newFormat); 
            countryText.wordWrap = true;
            countryText.width = 150;
            countryText.height = 30;
            countryText.x = 0;
            countryText.y = 0;
            exampleSprite.x = 10;
            exampleSprite.y = 44;
            exampleSprite.addChild(countryText);
            exampleSprite.width = 150;
            exampleSprite.height = 30; 
            exampleSprite.mouseChildren=false;
            exampleSprite.buttonMode=true;
            exampleSprite.useHandCursor=true;
            addChild(exampleSprite);
            exampleSprite.addEventListener(MouseEvent.CLICK,clicked);					
		}	
		
		private function clicked(event:MouseEvent):void {
		    navigateToURL(new URLRequest(event.target.url));
		}
	}
}