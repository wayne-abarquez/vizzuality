package com.vizzuality.components
{
	import mx.core.UIComponent;
		
	public class MyCircle extends UIComponent
    {
        public var xCircle:int;
        public var yCircle:int;
        public var radius:int;

        override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
        {
        	graphics.beginFill(0x333333);
            graphics.drawCircle(xCircle, yCircle, radius);
            graphics.endFill();
        }
    }
}