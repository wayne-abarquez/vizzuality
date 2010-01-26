package com.vizzuality.markers
{
	import com.google.maps.Color;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import mx.containers.Canvas;
	
	public class GenericMarkerInfoIcon extends Sprite
	{
		[Embed(source="assets/calibri.ttf",fontName="calibri",mimeType='application/x-font')]
        public var f1:Class;
		
        public var infoSprite: Sprite = new Sprite();
        public var bottomSprite: Sprite = new Sprite();
        public var textCity:TextField;
	    public var formatCity:TextFormat;
	    public var textPrice:TextField;
	    public var formatPrice:TextFormat;
	    public var textFlight:TextField;
	    public var formatTextFlight:TextFormat;
	 	public var textCompany:TextField;
	    public var formatTextCompany:TextFormat;
	 	public var textIda:TextField;
	    public var formatTextIda:TextFormat;
	 	public var textVuelta:TextField;
	    public var formatTextVuelta:TextFormat;
	 	public var textIdaValue:TextField;
	    public var formatTextIdaValue:TextFormat;
	 	public var textIdaValue2:TextField;
	    public var formatTextIdaValue2:TextFormat;
	 	public var textVueltaValue:TextField;
	    public var formatTextVueltaValue:TextFormat;
	 	public var textVueltaValue2:TextField;
	    public var formatTextVueltaValue2:TextFormat;
	 	public var textOptions:TextField;
	    public var formatTextOptions:TextFormat;
	 	public var textOptionsPlus:TextField;
	    public var formatTextOptionsPlus:TextFormat;
	 	public var mycity: String;
	 	public var myprice: String;
	 	public var canvas : Canvas = new Canvas;
	 	
	 
	public function GenericMarkerInfoIcon(color:String,city:String,price:String)
		{
			
			textCity = new TextField();
	    	formatCity = textCity.getTextFormat();
	    	textPrice = new TextField();
	    	formatPrice = textPrice.getTextFormat();
			
			mycity = city;
			myprice = price;
			var Box:Sprite = new Sprite();
			switch(color){
			    case 'yellow':
			        Box.graphics.beginFill(0xffcc00);
			        break;
			    case 'orange':
			        Box.graphics.beginFill(0xff9900);
			        break;
			    case 'darkorange':
			        Box.graphics.beginFill(0xff6600);
			        break;
			    case 'red':
			        Box.graphics.beginFill(0xff3300);
			        break;
			}
			
            Box.graphics.drawRoundRect(0,0,100,30,8);
            Box.graphics.endFill();
            addChild(Box);
            
            formatCity.size = 11;
 			formatCity.font = "calibri";
 			formatCity.bold = true;
            textCity.defaultTextFormat = formatCity;
            textCity.text = city.toUpperCase();
            textCity.textColor = 0x000000;
            textCity.mouseEnabled = false;
            textCity.width = 100;
            textCity.height = 30;
  			textCity.y = 0;
  			textCity.x = 4;
  			textCity.embedFonts = true;
            mouseChildren = false;
            addChild(textCity); 
 
            formatPrice.size = 14;
  			formatPrice.font = "calibri";
 			formatPrice.bold = true;
            textPrice.defaultTextFormat = formatPrice;
            textPrice.text = price.toUpperCase();
            textPrice.textColor = 0xffffff;
            textPrice.mouseEnabled = false;
            textPrice.width = 100;
            textPrice.height = 30;
 			textPrice.y = 9;
 			textPrice.x = 4;
  			textPrice.embedFonts = true;
            mouseChildren = false;
            addChild(textPrice);
 
 			infoSprite.graphics.beginFill(0x000000,0.1);
            infoSprite.graphics.drawRoundRect(-2,-2,175,166,8);
            infoSprite.graphics.endFill();
            switch(color){
			    case 'yellow':
			        infoSprite.graphics.beginFill(0xffcc00);
			        break;
			    case 'orange':
			        infoSprite.graphics.beginFill(0xff9900);
			        break;
			    case 'darkorange':
			        infoSprite.graphics.beginFill(0xff6600);
			        break;
			    case 'red':
			        infoSprite.graphics.beginFill(0xff3300);
			        break;
			}
			
            infoSprite.graphics.drawRoundRect(3,3,165,156,8);
            infoSprite.graphics.endFill();
            
            //infoSprite.mask = bottomSprite;
            bottomSprite.graphics.beginFill(0x000000,0.2);
            bottomSprite.graphics.drawRect(3,131,165,28);
            bottomSprite.graphics.endFill();
            
            bottomSprite.graphics.beginFill(0x000000,0.4);
            bottomSprite.graphics.drawRoundRect(75,136,88,18,8);
            bottomSprite.graphics.endFill();
            
            bottomSprite.graphics.beginFill(0xffffff);
            bottomSprite.graphics.drawRoundRect(146,139,12,12,4);
            bottomSprite.graphics.endFill();
			            
 			this.addEventListener(MouseEvent.CLICK,ShowTripInfo);
		}
		
		private function ShowTripInfo(ev: MouseEvent):void{
			if (infoSprite.parent == null) {
            	addChild(infoSprite);
            	addChild(bottomSprite);
            	
            	textCity = new TextField();
	    		formatCity = textCity.getTextFormat();
	    		textPrice = new TextField();
	    		formatPrice = textPrice.getTextFormat();
	            textFlight = new TextField();
	    		formatTextFlight = textFlight.getTextFormat();
	 	        textCompany = new TextField();
	    		formatTextCompany = textCompany.getTextFormat();
	 	 	    textIda = new TextField();
	    		formatTextIda = textIda.getTextFormat();
	 	 	    textVuelta = new TextField();
	    		formatTextVuelta = textVuelta.getTextFormat();
	 	 	 	textIdaValue = new TextField();
	    		formatTextIdaValue = textIdaValue.getTextFormat();
	 	 	 	textIdaValue2 = new TextField();
	    		formatTextIdaValue2 = textIdaValue2.getTextFormat();
	 	 	 	textVueltaValue = new TextField();
	    		formatTextVueltaValue = textVueltaValue.getTextFormat();
	 	 	 	textVueltaValue2 = new TextField();
	    		formatTextVueltaValue2 = textVueltaValue2.getTextFormat();
	 	 	 	textOptions = new TextField();
	    		formatTextOptions = textOptions.getTextFormat();
				textOptionsPlus = new TextField();
	    		formatTextOptionsPlus = textOptions.getTextFormat();
	 
	 
	            formatCity.size = 19;
	 			formatCity.font = "calibri";
	 			formatCity.bold = true;
	            textCity.defaultTextFormat = formatCity;
	            textCity.text = mycity.toUpperCase();
	            textCity.textColor = 0xffffff;
	            textCity.mouseEnabled = false;
	            textCity.width = 150;
	            textCity.height = 30;
	  			textCity.y = 4;
	  			textCity.x = 8;
	  			textCity.embedFonts = true;
	  			mouseChildren = false;
	            addChild(textCity); 
	 
	            formatPrice.size = 27;
	  			formatPrice.font = "calibri";
	 			formatPrice.bold = true;
	            textPrice.defaultTextFormat = formatPrice;
	            textPrice.text = myprice.toUpperCase();
	            textPrice.textColor = 0xffffff;
	            textPrice.mouseEnabled = false;
	            textPrice.width = 60;
	            textPrice.height = 35;
	 			textPrice.y = 20;
	  			textPrice.x = 8;
	  			textPrice.embedFonts = true;
	            mouseChildren = false;
	            addChild(textPrice);
	 
	            formatTextFlight.size = 11;
	 			formatTextFlight.font = "calibri";
	 			formatTextFlight.bold = true;
	            textFlight.defaultTextFormat = formatTextFlight;
	            textFlight.text = "VUELO DIRECTO CON";
	            textFlight.textColor = 0x666666;
	            textFlight.mouseEnabled = false;
	            textFlight.width = 100;
	            textFlight.height = 20;
	  			textFlight.y = 55;
	  			textFlight.x = 8;
	  			textFlight.embedFonts = true;
	  			mouseChildren = false;
	            addChild(textFlight); 
	 
	 	        formatTextCompany.size = 13;
	 			formatTextCompany.font = "calibri";
	 			formatTextCompany.bold = true;
	            textCompany.defaultTextFormat = formatTextCompany;
	            textCompany.text = "IBERIA";
	            textCompany.textColor = 0xffffff;
	            textCompany.mouseEnabled = false;
	            textCompany.width = 120;
	            textCompany.height = 20;
	  			textCompany.y = 68;
	  			textCompany.x = 8; 
	  			textCompany.embedFonts = true;
	  			mouseChildren = false;
	            addChild(textCompany); 
	 
	 	 	    formatTextIda.size = 13;
	 			formatTextIda.font = "calibri";
	 			formatTextIda.bold = true;
	            textIda.defaultTextFormat = formatTextIda;
	            textIda.text = "ida";
	            textIda.textColor = 0x666666;
	            textIda.mouseEnabled = false;
	            textIda.width = 50;
	            textIda.height = 20;
	  			textIda.y = 90;
	  			textIda.x=8;   
	  			textIda.embedFonts = true;
	  			mouseChildren = false;
	            addChild(textIda);
	 
	 			formatTextIdaValue.size = 13;
	 			formatTextIdaValue.font = "calibri";
	 			formatTextIdaValue.bold = true;
	            textIdaValue.defaultTextFormat = formatTextIdaValue;
	            textIdaValue.text = "11:15";
	            textIdaValue.textColor = 0xffffff;
	            textIdaValue.mouseEnabled = false;
	            textIdaValue.width = 50;
	            textIdaValue.height = 20;
	  			textIdaValue.y = 100;
	  			textIdaValue.x=8;
	  			textIdaValue.embedFonts = true;
	  			mouseChildren = false;
	            addChild(textIdaValue);
	 
	 	 		formatTextIdaValue2.size = 13;
	 			formatTextIdaValue2.font = "calibri";
	 			formatTextIdaValue2.bold = true;
	            textIdaValue2.defaultTextFormat = formatTextIdaValue2;
	            textIdaValue2.text = "19:15";
	            textIdaValue2.textColor = 0xffffff;
	            textIdaValue2.mouseEnabled = false;
	            textIdaValue2.width = 50;
	            textIdaValue2.height = 20;
	  			textIdaValue2.y = 100;
	  			textIdaValue2.x=40;
/* 	  			textCompany.borderColor = Color.CYAN;
	  			textCompany.border = true; */
	  			textIdaValue2.embedFonts = true;
	  			mouseChildren = false;
	            addChild(textIdaValue2);
	 
	 	 	 	formatTextVuelta.size = 13;
	 			formatTextVuelta.font = "calibri";
	 			formatTextVuelta.bold = true;
	            textVuelta.defaultTextFormat = formatTextVuelta;
	            textVuelta.text = "vuelta";
	            textVuelta.textColor = 0x666666;
	            textVuelta.mouseEnabled = false;
	            textVuelta.width = 50;
	            textVuelta.height = 20;
	  			textVuelta.y = 90;
	  			textVuelta.x=85;
	  			textVuelta.embedFonts = true;
	  			mouseChildren = false;
	            addChild(textVuelta);
	 
	 			formatTextVueltaValue.size = 13;
	 			formatTextVueltaValue.font = "calibri";
	 			formatTextVueltaValue.bold = true;
	            textVueltaValue.defaultTextFormat = formatTextVueltaValue;
	            textVueltaValue.text = "12:15";
	            textVueltaValue.textColor = 0xffffff;
	            textVueltaValue.mouseEnabled = false;
	            textVueltaValue.width = 50;
	            textVueltaValue.height = 20;
	  			textVueltaValue.y = 100;
	  			textVueltaValue.x=85;
	  			textVueltaValue.embedFonts = true;
	  			mouseChildren = false;
	            addChild(textVueltaValue);
	 
	 	 		formatTextVueltaValue2.size = 13;
	 			formatTextVueltaValue2.font = "calibri";
	 			formatTextVueltaValue2.bold = true;
	            textVueltaValue2.defaultTextFormat = formatTextVueltaValue2;
	            textVueltaValue2.text = "20:15";
	            textVueltaValue2.textColor = 0xffffff;
	            textVueltaValue2.mouseEnabled = false;
	            textVueltaValue2.width = 50;
	            textVueltaValue2.height = 20;
	  			textVueltaValue2.y = 100;
	  			textVueltaValue2.x = 120;
	  			textVueltaValue2.embedFonts = true;
	  			mouseChildren = false;
	            addChild(textVueltaValue2);
	 
	 	 	 	formatTextOptions.size = 8;
	 			formatTextOptions.font = "Arial";
	 			formatTextOptions.bold = true;
	            textOptions.defaultTextFormat = formatTextOptions;
	            textOptions.text = "MAS OPCIONES";
	            textOptions.textColor = 0xffffff;
	            textOptions.mouseEnabled = false;
	            textOptions.width = 70;
	            textOptions.height = 20;
	  			textOptions.y = 139;
	  			textOptions.x= 78;
	  			mouseChildren = false;
	            addChild(textOptions);
	 
	 	 	 	formatTextOptionsPlus.size = 13;
	 			formatTextOptionsPlus.font = "Arial";
	 			formatTextOptionsPlus.bold = true;
	            textOptionsPlus.defaultTextFormat = formatTextOptionsPlus;
	            textOptionsPlus.text = "+";
	            textOptionsPlus.textColor = 0x712f00;
	            textOptionsPlus.mouseEnabled = false;
	            textOptionsPlus.width = 25;
	            textOptionsPlus.height = 25;
	  			textOptionsPlus.y = 136;
	  			textOptionsPlus.x= 146;
/* 	  			textOptionsPlus.borderColor = Color.CYAN;
	  			textOptionsPlus.border = true; */	            
	  			mouseChildren = false;
	            addChild(textOptionsPlus);
	 
            } else {
            	removeChild(infoSprite);
            	removeChild(textCity);
            	removeChild(textPrice);
            	removeChild(bottomSprite);
            	removeChild(textFlight);
            	removeChild(textCompany);
            	removeChild(textIda);
            	removeChild(textIdaValue);
            	removeChild(textIdaValue2);
            	removeChild(textVuelta);
      			removeChild(textVueltaValue);
            	removeChild(textVueltaValue2);
            	removeChild(textOptions);
            	removeChild(textOptionsPlus);
            }
        }
	}
}