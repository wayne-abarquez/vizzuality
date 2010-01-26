package com.vizzuality.components
{
	import mx.core.UIComponent;
		
	public class MyElipse extends UIComponent
    {
        public var xElipse:int;
        public var yElipse:int;
        public var heightElipse:int;
        public var widthElipse:int;
        public var radius:int;

        override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
        {
        	graphics.beginFill(0x333333);
        	graphics.drawRoundRect(xElipse,yElipse,widthElipse,heightElipse,radius);
            graphics.endFill();
        }
    }
}