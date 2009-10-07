package com.vizzuality
{
import flash.display.GradientType;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.geom.Matrix;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

   public class vizzButton extends Sprite {
   	
      private var path:Sprite
      private var label: String
      private var widthBut : int
      private var heightBut: int
      private var sizeBut: int
      private var textX: int
      private var textY: int
      public var button:SimpleButton = new SimpleButton;
	  private var embeddedFonts:Array = new Array();

      public function vizzButton(where,x,y,width,height,text,size,labelX,labelY):void {
         path = where
         label = text
         widthBut = width
         heightBut = height
         sizeBut = size
         textX = labelX
         textY = labelY
         button.hitTestState = button.upState;
         button.useHandCursor = true;
         button.x = x         
         button.y = y
         
         button.upState = creaSprite(1,0xf7f7f7,0xeeeeee,widthBut,heightBut);
         button.overState = creaSprite(1,0xeeeeee,0xf7f7f7,widthBut,heightBut);
         button.downState = creaSprite(1,0x000000,0x999999,widthBut,heightBut);

		 button.hitTestState = button.upState;
		 button.useHandCursor = true;
         
         
         path.addChild(button);

 	 	 
      }
      
      
      public override function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void {
		button.addEventListener(type,listener, useCapture, priority, useWeakReference);
      }
      
      public override function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void {
		button.removeEventListener(type,listener,useCapture);
      }      


      private function creaSprite(line_height, first_color, second_color, width, height):Sprite {
         var linGrad:String = GradientType.LINEAR;
	   	 var linMatrix:Matrix = new Matrix();
	     linMatrix.createGradientBox(width,height,30);
	     var linColors:Array = [first_color, second_color];
	     var linAlphas:Array = [1, 1];
	     var linRatios:Array = [0, 255];
         var lin:Sprite = new Sprite();
   		 lin.graphics.beginGradientFill(linGrad, linColors, linAlphas, linRatios,linMatrix);
   		 lin.graphics.lineStyle(1,0xc46d00);
   		 lin.graphics.drawRect(0,0,width,height);
  		 var lab:TextField = createLabel();
         lin.addChild(lab);
         return lin;
  		 
  		 
      }
      
      private function createLabel():TextField {
	  	 var fmt:TextFormat = new TextFormat("Arial", sizeBut,0x666666,false);
		 var tf:TextField = new TextField();
		 tf.selectable = false;
		 tf.y=textY;
		 tf.x=textX;
		 tf.mouseEnabled = false;
		 tf.autoSize = TextFieldAutoSize.LEFT;
		 tf.defaultTextFormat = fmt;
		 tf.text = label;
		 return tf;
	  }
   }
}
