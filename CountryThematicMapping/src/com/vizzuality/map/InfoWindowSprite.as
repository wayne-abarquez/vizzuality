package com.vizzuality.map
{
	import com.vizzuality.feature.Provider;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;

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

			graphics.beginFill(0xFFFFFF, 1);
      		graphics.drawRect(0, 0, 150, 100);
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
    		xTextFormat.font = "Verdana";
    		xTextFormat.size = 10;
    		xTextFormat.color = 0x2A2A2A;
    		
    		//NAME
    		var nameText:TextField = new TextField();
		    nameText.x = 10;
		    nameText.y = 10;
		    nameText.text = this.provide_name;
		    nameText.selectable = true;
		    nameText.setTextFormat(xTextFormat);		    
		    addChild(nameText);
		    
    		//CITY
    		var cityText:TextField = new TextField();
		    cityText.x = 10;
		    cityText.y = 26;
		    cityText.text = city;
		    cityText.selectable = true;
		    cityText.setTextFormat(xTextFormat);
		    addChild(cityText);
		    
    		//OCCURRENCES
    		var occText:TextField = new TextField();
		    occText.x = 10;
		    occText.y = 58;
		    occText.text = occurrences + ' occ.';
		    occText.selectable = true;
		    occText.setTextFormat(xTextFormat);
		    addChild(occText);
		    
    		//RESOURCES
    		var resText:TextField = new TextField();
		    resText.x = 10;
		    resText.y = 73;
		    resText.text = resources + ' res.';
		    resText.selectable = true;
		    resText.setTextFormat(xTextFormat);
		    addChild(resText);
    		
    		cacheAsBitmap = true;
    		
		}
	}
}