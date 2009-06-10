package com.vizzuality.map
{
	import com.vizzuality.feature.Provider;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import mx.core.Application;

	public class InfoWindowSprite extends Sprite
	{
		
		private var provide_name:String;
		private var url:String;
		private var city:String;
		private var resources:Number
		private var occurrences:Number
		
		public function InfoWindowSprite(p:Provider)
		{
			super();
			this.provide_name=p.name;
			this.url=p.url;
			this.city=p.city;
			this.resources=p.resource_count;
			this.occurrences=p.occurrence_count;

			init();
		
		}
		
		private function init():void {

			graphics.beginFill(0x000000,0);
      		graphics.drawRect(0, 0, 200, 100);
      		graphics.endFill();
/* 		    // Create info window frame
		    graphics.lineStyle(2, 0x2A2A2A, 1, true);
		    graphics.beginFill(0x2A2A2A);
		    graphics.drawRect(0,0,150,100);
		    graphics.moveTo(0, 0);
		    graphics.lineTo(100,0)
		    graphics.lineTo(100, 100);
		    graphics.lineTo(0, 100);
		    graphics.lineTo(0, 0);
		    graphics.lineStyle(2, 0xEEEEEE);
		    graphics.endFill();	 */		
			
			var xTextFormat:TextFormat = new TextFormat();
    		xTextFormat.font = "DINOT-Medium";
    		xTextFormat.size = 16;
    		xTextFormat.color = 0xFFFFFF;
    		xTextFormat.leading = -4;
    		
			var x2TextFormat:TextFormat = new TextFormat();
    		x2TextFormat.font = "DINOT-Medium";
    		x2TextFormat.size = 15;
    		x2TextFormat.color = 0xa7e66b;
    		
			var urlFormat:TextFormat = new TextFormat();
    		urlFormat.font = "DINOT-Medium";
    		urlFormat.size = 10;
    		urlFormat.underline = true;
    		urlFormat.color = 0xFFFFFF;
    		   		
    		//NAME
    		var nameText:TextField = new TextField();
		    nameText.x = 3;
		    nameText.y = 0;
		    nameText.text = this.provide_name + ' ('+city+')';
		    nameText.selectable = true;
		    nameText.wordWrap=true;
		    nameText.autoSize = TextFieldAutoSize.LEFT;
		    nameText.width=178;
		    nameText.setTextFormat(xTextFormat);
		    addChild(nameText);
		    
    		//URL
    		var urlText:TextField = new TextField();
		    urlText.x = 3;
		    urlText.y = nameText.height - 4;
		    urlText.text = 'visit website';
		    urlText.selectable = true;
		    urlText.wordWrap=true;
		    urlText.autoSize = TextFieldAutoSize.LEFT;
		    urlText.width=132;
		    urlText.setTextFormat(urlFormat);		    
		    addChild(urlText);
		    urlText.addEventListener(MouseEvent.CLICK, onUrlClick,false,0,true);
		    
    		//OCCURRENCES
    		var occText:TextField = new TextField();
		    occText.x = 3;
		    occText.y = urlText.y +16;
		    occText.width=182;
		    occText.text = Application.application.numberFormatter.format(occurrences) + ' occurrences';
		    occText.selectable = true;
		    occText.setTextFormat(x2TextFormat);
		    addChild(occText);
		    
/*     		//RESOURCES
    		var resText:TextField = new TextField();
		    resText.x = 10;
		    resText.y = 73;
		    resText.text = resources + ' res.';
		    resText.selectable = true;
		    resText.setTextFormat(xTextFormat);
		    addChild(resText);
    		 */
    		cacheAsBitmap = true;
    		
		}
		
		
		private function onUrlClick(event:MouseEvent):void {
			navigateToURL(new URLRequest(this.url));
		}
	}
}